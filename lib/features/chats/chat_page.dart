import 'dart:math';

import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/chats/stream_chat_state.dart';
import 'package:basetime/features/checkout/checkout_page.dart';
import 'package:basetime/features/matches/match.dart';
import 'package:basetime/features/meets/meet.dart';
import 'package:basetime/features/meets/meet_page.dart';
import 'package:basetime/widgets/appbar_widget.dart';
import 'package:basetime/widgets/loader.dart';
import 'package:basetime/widgets/show_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({
    super.key,
    required this.match,
  });

  static String name = 'chat';
  static String path = '/$name';

  final MatchModel match;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(streamChatStateProvider(widget.match.id));
    return chatState.when(
      data: (data) {
        final messages = [...data.messages];
        final meet = data.meet(ref);
        return Scaffold(
          appBar: AppBarBT(
            title: Wrap(
              spacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: data.otherUser.imageUrl != null
                      ? NetworkImage(data.otherUser.imageUrl!)
                      : null,
                  child: data.otherUser.imageUrl != null
                      ? null
                      : Text(
                          data.otherUser.firstName
                                  ?.substring(0, 1)
                                  .toUpperCase() ??
                              '',
                        ),
                ),
                Text('${data.otherUser.firstName} ${data.otherUser.lastName}'),
              ],
            ),
            actions: data.isSupplier
                ? []
                : [
                    if (meet == null && data.isClient)
                      IconButton(
                        onPressed: () async {
                          final dateResult = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );

                          if (dateResult != null && context.mounted) {
                            final timeResult = await showTimePicker(
                              context: context,
                              initialEntryMode: TimePickerEntryMode.dialOnly,
                              initialTime: TimeOfDay(
                                hour:
                                    DateFormat('ddMMyyyy').format(dateResult) ==
                                            DateFormat('ddMMyyyy')
                                                .format(DateTime.now())
                                        ? DateTime.now().hour + 1
                                        : 6,
                                minute: 0,
                              ),
                            );
                            if (timeResult != null) {
                              await data.createMeet(
                                Meet(
                                  id: '',
                                  chatRef: data.reference,
                                  author: data.client,
                                  dynamicCode:
                                      Random().nextInt(900000) + 100000,
                                  seconds: 0,
                                  date: DateTime(
                                    dateResult.year,
                                    dateResult.month,
                                    dateResult.day,
                                    timeResult.hour,
                                    timeResult.minute,
                                  ),
                                  createdAt: DateTime.now(),
                                  status: MeetStatus.request,
                                ),
                              );
                            }
                          }
                        },
                        icon: const Icon(Icons.edit_calendar_rounded),
                      ),
                  ],
          ),
          body: Column(
            children: [
              if (meet != null && meet.isClient)
                Card(
                  color: const Color(0xFF363636),
                  child: ListTile(
                    onTap: () {
                      if (meet.status == MeetStatus.qualify) {
                        context.push(
                          MeetPage.path,
                          extra: {
                            'meet': meet,
                            'chat': data,
                            'match': widget.match,
                          },
                        );
                      }
                    },
                    leading: meet.status == MeetStatus.qualify
                        ? const Icon(Icons.star_rounded)
                        : meet.status == MeetStatus.request
                            ? const Icon(Icons.today)
                            : meet.status == MeetStatus.aceptNotPayed
                                ? const Icon(Icons.payment)
                                : null,
                    title: Text(
                      meet.status == MeetStatus.qualify && meet.isClient
                          ? 'Debes clasificar el servicio'
                          : meet.status == MeetStatus.request ||
                                  meet.status == MeetStatus.aceptPayed
                              ? meet.isClient
                                  ? "Haz realizado una propuesta de meet para la fecha ${DateFormat("dd/MM/yyyy").format(meet.date)}"
                                      " a las ${DateFormat("h:mm a").format(meet.date)}"
                                  : "Tines una propuesta de meet para la fecha ${DateFormat("dd/MM/yyyy").format(meet.date)}"
                                      " a las ${DateFormat("h:mm a").format(meet.date)}"
                              : meet.status == MeetStatus.aceptNotPayed
                                  ? meet.isClient
                                      ? '${data.supplierData.firstName} ha aceptado tu solicitud'
                                      : 'Haz aceptado la solicitud de ${data.client.firstName}'
                                  : '',
                      style: GoogleFonts.ubuntu(),
                    ),
                    subtitle: meet.status == MeetStatus.qualify
                        ? null
                        : Text(
                            meet.status == MeetStatus.aceptPayed
                                ? 'Pagado'
                                : meet.status == MeetStatus.aceptNotPayed
                                    ? 'Esperando pago de garantía'
                                    : 'Esperando a ser aceptada',
                            style: GoogleFonts.ubuntu(),
                          ),
                    trailing: meet.status == MeetStatus.qualify
                        ? const Icon(Icons.chevron_right)
                        : meet.status == MeetStatus.request
                            ? IconButton(
                                onPressed: () async {
                                  String status = MeetStatus.request.name;
                                  switch (meet.status) {
                                    case MeetStatus.request:
                                      status = meet.isClient
                                          ? MeetStatus.cancel.name
                                          : MeetStatus.aceptNotPayed.name;
                                      break;
                                    default:
                                      status = MeetStatus.request.name;
                                  }
                                  await meet.update({
                                    'status': status,
                                    'updatedAt': Timestamp.now(),
                                  });
                                },
                                icon: meet.isClient
                                    ? const Icon(Icons.close)
                                    : const Icon(Icons.check),
                              )
                            : meet.status == MeetStatus.aceptNotPayed
                                ? FilledButton(
                                    style: FilledButton.styleFrom(
                                      minimumSize: const Size(39, 39),
                                    ),
                                    onPressed: () async {
                                      if (meet.isClient) {
                                        await context.push(
                                          CheckoutPage.path,
                                          extra: {
                                            'match': widget.match,
                                            'chat': data,
                                            'meet': meet,
                                          },
                                        );
                                      } else {
                                        await meet.update({
                                          'status': MeetStatus.cancel.name,
                                        });
                                      }
                                    },
                                    child: Text(
                                      meet.isClient
                                          ? 'Pagar \$${NumberFormat.currency(
                                              name: "",
                                              decimalDigits: 0,
                                            ).format(
                                              widget.match.service
                                                      .pricePerHour *
                                                  widget.match.hours,
                                            )}'
                                          : 'Cancelar',
                                      style: GoogleFonts.ubuntu(),
                                    ),
                                  )
                                : meet.status == MeetStatus.aceptPayed
                                    ? FilledButton(
                                        style: FilledButton.styleFrom(
                                          minimumSize: const Size(39, 39),
                                        ),
                                        onPressed: () {
                                          context.push(
                                            MeetPage.path,
                                            extra: {
                                              'meet': meet,
                                              'chat': data,
                                              'match': widget.match,
                                            },
                                          );
                                        },
                                        child: Text(
                                          context.lang!.meet,
                                          style: GoogleFonts.ubuntu(),
                                        ),
                                      )
                                    : null,
                  ),
                ),
              if (meet != null &&
                  meet.isSupplier &&
                  meet.status != MeetStatus.qualify)
                Card(
                  color: const Color(0xFF363636),
                  child: ListTile(
                    onTap: () {
                      if (meet.status == MeetStatus.qualify) {
                        context.push(
                          MeetPage.path,
                          extra: {
                            'meet': meet,
                            'chat': data,
                            'match': widget.match,
                          },
                        );
                      }
                    },
                    leading: meet.status == MeetStatus.qualify
                        ? const Icon(Icons.star_rounded)
                        : meet.status == MeetStatus.request
                            ? const Icon(Icons.today)
                            : meet.status == MeetStatus.aceptNotPayed
                                ? const Icon(Icons.payment)
                                : null,
                    title: Text(
                      meet.status == MeetStatus.qualify && meet.isClient
                          ? 'Debes clasificar el servicio'
                          : meet.status == MeetStatus.request ||
                                  meet.status == MeetStatus.aceptPayed
                              ? meet.isClient
                                  ? "Haz realizado una propuesta de meet para la fecha ${DateFormat("dd/MM/yyyy").format(meet.date)}"
                                      " a las ${DateFormat("h:mm a").format(meet.date)}"
                                  : "Tines una propuesta de meet para la fecha ${DateFormat("dd/MM/yyyy").format(meet.date)}"
                                      " a las ${DateFormat("h:mm a").format(meet.date)}"
                              : meet.status == MeetStatus.aceptNotPayed
                                  ? meet.isClient
                                      ? '${data.supplierData.firstName} ha aceptado tu solicitud'
                                      : 'Haz aceptado la solicitud de ${data.client.firstName}'
                                  : '',
                      style: GoogleFonts.ubuntu(),
                    ),
                    subtitle: meet.status == MeetStatus.qualify
                        ? null
                        : Text(
                            meet.status == MeetStatus.aceptPayed
                                ? 'Pagado'
                                : meet.status == MeetStatus.aceptNotPayed
                                    ? 'Esperando pago de garantía'
                                    : 'Esperando a ser aceptada',
                            style: GoogleFonts.ubuntu(),
                          ),
                    trailing: meet.status == MeetStatus.qualify
                        ? const Icon(Icons.chevron_right)
                        : meet.status == MeetStatus.request
                            ? IconButton(
                                onPressed: () async {
                                  String status = MeetStatus.request.name;
                                  switch (meet.status) {
                                    case MeetStatus.request:
                                      status = meet.isClient
                                          ? MeetStatus.cancel.name
                                          : MeetStatus.aceptNotPayed.name;
                                      break;
                                    default:
                                      status = MeetStatus.request.name;
                                  }
                                  await meet.update({
                                    'status': status,
                                    'updatedAt': Timestamp.now(),
                                  });
                                },
                                icon: meet.isClient
                                    ? const Icon(Icons.close)
                                    : const Icon(Icons.check),
                              )
                            : meet.status == MeetStatus.aceptNotPayed
                                ? FilledButton(
                                    style: FilledButton.styleFrom(
                                      minimumSize: const Size(39, 39),
                                    ),
                                    onPressed: () async {
                                      if (meet.isClient) {
                                        await context.push(
                                          CheckoutPage.path,
                                          extra: {
                                            'match': widget.match,
                                            'chat': data,
                                            'meet': meet,
                                          },
                                        );
                                      } else {
                                        await meet.update({
                                          'status': MeetStatus.cancel.name,
                                        });
                                      }
                                    },
                                    child: Text(
                                      meet.isClient
                                          ? 'Pagar \$${NumberFormat.currency(
                                              name: "",
                                              decimalDigits: 0,
                                            ).format(
                                              widget.match.service
                                                      .pricePerHour *
                                                  widget.match.hours,
                                            )}'
                                          : 'Cancelar',
                                      style: GoogleFonts.ubuntu(),
                                    ),
                                  )
                                : meet.status == MeetStatus.aceptPayed
                                    ? FilledButton(
                                        style: FilledButton.styleFrom(
                                          minimumSize: const Size(39, 39),
                                        ),
                                        onPressed: () {
                                          context.push(
                                            MeetPage.path,
                                            extra: {
                                              'meet': meet,
                                              'chat': data,
                                              'match': widget.match,
                                            },
                                          );
                                        },
                                        child: Text(
                                          context.lang!.meet,
                                          style: GoogleFonts.ubuntu(),
                                        ),
                                      )
                                    : null,
                  ),
                ),
              Expanded(
                child: Chat(
                  theme: const DefaultChatTheme(
                    backgroundColor: Colors.transparent,
                  ),
                  messages: List<types.Message>.from(
                    messages.map((message) {
                      return types.TextMessage(
                        id: message.id,
                        author: message.author,
                        text: (message as types.TextMessage).text,
                        createdAt: message.createdAt,
                      );
                    }),
                  ),
                  onMessageTap: (context, message) {},
                  onSendPressed: (partialText) async {
                    final now = DateTime.now().millisecondsSinceEpoch;
                    await data.sendMessage(
                      types.TextMessage(
                        text: partialText.text,
                        author: data.author,
                        id: 'temp-$now-${data.author.id}',
                        createdAt: now,
                      ),
                    );
                  },
                  user: data.author,
                  l10n: context.lang?.localeName == 'en'
                      ? const ChatL10nEn()
                      : const ChatL10nEs(),
                ),
              ),
            ],
          ),
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return ShowError(
          error: error,
          stackTrace: stackTrace,
        );
      },
      loading: () => const Loader(),
    );
  }
}

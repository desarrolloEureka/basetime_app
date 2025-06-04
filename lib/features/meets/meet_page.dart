import 'dart:async';

import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/chats/chat.dart';
import 'package:basetime/features/comment/comment_page.dart';
import 'package:basetime/features/matches/match.dart';
import 'package:basetime/features/meets/meet.dart';
import 'package:basetime/features/meets/stream_meet_state.dart';
import 'package:basetime/features/welcome/welcome_page.dart';
import 'package:basetime/widgets/appbar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class MeetPage extends ConsumerStatefulWidget {
  const MeetPage({
    super.key,
    required this.chat,
    required this.match,
    required this.meet,
  });

  final Chat chat;
  final MatchModel match;
  final Meet meet;

  static String name = 'meet';
  static String path = '/$name';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MeetPageState();
}

class _MeetPageState extends ConsumerState<MeetPage> {
  bool isCommenting = false;
  String _hours = '00';
  String _minutes = '00';
  String _seconds = '00';
  Timer? _timer;
  int code = 0;

  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _hours = widget.match.hours.toString().padLeft(2, '0');
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final streamMeet = ref.watch(
      streamMeetStateProvider(
        widget.meet.id,
        allStatus: true,
      ),
    );

    return Stack(
      children: [
        Image.asset(
          'assets/sign-in-bg.png',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBarBT(
            backgroundColor: Colors.transparent,
            title: Text(
              context.lang!.meet,
              style: GoogleFonts.ubuntu(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: streamMeet.when(
            data: (meeting) {
              if (meeting == null) {
                return const Center(
                  child: Text('No se encontró la reunión'),
                );
              }
              if (meeting.status == MeetStatus.cancel &&
                  meeting.cancellationAuthor != auth.currentUser!.uid) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          color: Colors.white,
                          margin: const EdgeInsets.all(32),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      context.replace(WelcomePage.path);
                                    },
                                    icon: Icon(
                                      Icons.close_rounded,
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  context.lang!.cancellationMeetAlert,
                                  style: GoogleFonts.ubuntu(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                ),
                              ),
                              const Divider(color: Colors.grey),
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                onPressed: () {
                                  context.replace(WelcomePage.path);
                                },
                                child: Center(
                                  child: Text(
                                    context.lang!.home,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (meeting.status == MeetStatus.qualify && meeting.isClient) {
                return CommentsPage(meet: meeting, match: widget.match);
              }

              if (meeting.status == MeetStatus.complete ||
                  meeting.status == MeetStatus.qualify && meeting.isSupplier) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          color: Colors.white,
                          margin: const EdgeInsets.all(32),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      context.replace(WelcomePage.path);
                                    },
                                    icon: Icon(
                                      Icons.close_rounded,
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  context.lang!.completedMeetAlert,
                                  style: GoogleFonts.ubuntu(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                ),
                              ),
                              const Divider(color: Colors.grey),
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                onPressed: () {
                                  context.replace(WelcomePage.path);
                                },
                                child: Center(
                                  child: Text(
                                    context.lang!.home,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (meeting.initAt != null) {
                if (_timer?.isActive ?? false) {
                  _timer?.cancel();
                }
                _timer = Timer.periodic(const Duration(seconds: 1), (_) {
                  final initDate = meeting.initAt!.add(
                    Duration(hours: widget.match.hours),
                  );
                  final remainingSeconds = initDate
                      .difference(
                        DateTime.now(),
                      )
                      .inSeconds;
                  final remainingMinutes = initDate
                      .difference(
                        DateTime.now(),
                      )
                      .inMinutes;
                  if (remainingMinutes < 10) {
                    context.showAlert<void>(
                      content: context.lang!.tenMinutesToFinish,
                    );
                  }
                  if (remainingSeconds < 1) {
                    widget.meet.update({
                      'status': MeetStatus.qualify.name,
                    });
                    _timer?.cancel();
                    return;
                  }
                  setState(() {
                    _hours =
                        Duration(seconds: remainingSeconds).inHours.toString();
                    _minutes =
                        (Duration(seconds: remainingSeconds).inMinutes % 60)
                            .toString()
                            .padLeft(2, '0');
                    _seconds =
                        (Duration(seconds: remainingSeconds).inSeconds % 60)
                            .toString()
                            .padLeft(2, '0');
                  });
                });
              }
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 520,
                            margin: const EdgeInsets.all(16).copyWith(
                              top: 0,
                            ),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: const GradientBoxBorder(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white,
                                    Colors.white38,
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white54,
                                  Colors.white38,
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Con ${widget.match.supplier.id != auth.currentUser?.uid ? widget.match.supplier.firstName : widget.match.client.firstName}',
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // Text(
                                    //   '@${widget.match.supplier.username}',
                                    //   style: GoogleFonts.ubuntu(
                                    //     color: Colors.white70,
                                    //     fontSize: 12,
                                    //     fontWeight: FontWeight.w600,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          widget.match.service.title,
                                          style: GoogleFonts.ubuntu(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      widget.match.service.description ?? '',
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.white60,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 16),
                                    // Wrap(
                                    //   spacing: 8,
                                    //   children: List<Widget>.from(
                                    //     widget.match.supplier.categories.map(
                                    //       (category) {
                                    //         return SvgPicture.network(
                                    //           category.iconURL,
                                    //         );
                                    //       },
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 64,
                            left: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                widget.match.service.imageURL,
                                width: MediaQuery.of(context).size.width,
                                height: 320,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Card(
                        margin: const EdgeInsets.all(16).copyWith(top: 0),
                        color: Theme.of(context).colorScheme.surface,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _hours,
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 32,
                                  ),
                                ),
                                Text(
                                  ':',
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 32,
                                  ),
                                ),
                                Text(
                                  _minutes,
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 32,
                                  ),
                                ),
                                Text(
                                  ':',
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 32,
                                  ),
                                ),
                                Text(
                                  _seconds,
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 32,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FilledButton(
                              onPressed: () async {
                                await widget.meet.update({
                                  'status': MeetStatus.cancel.name,
                                  'cancellationAuthor': auth.currentUser!.uid,
                                });
                                if (context.mounted) {
                                  context.replace(WelcomePage.path);
                                }
                              },
                              child: const Text('Cancelar Meet'),
                            ),
                            if (auth.currentUser?.uid ==
                                    widget.match.supplier.id &&
                                widget.meet.initAt == null)
                              const SizedBox(width: 8),
                            if (auth.currentUser?.uid !=
                                widget.match.supplier.id)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: (MediaQuery.of(context).size.width *
                                            0.5) -
                                        40,
                                    height: 42,
                                    margin: const EdgeInsets.all(2),
                                    padding: const EdgeInsets.all(4),
                                    child: Text(
                                      widget.meet.dynamicCode.toString(),
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      'Clave de inicio',
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.white,
                                        fontSize: 9,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (auth.currentUser?.uid ==
                                    widget.match.supplier.id &&
                                widget.meet.initAt == null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: (MediaQuery.of(context).size.width *
                                            0.5) -
                                        40,
                                    height: 42,
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: const Border.fromBorderSide(
                                        BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Center(
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        style: GoogleFonts.ubuntu(
                                          color: Colors.white,
                                          fontSize: 24,
                                        ),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                        ),
                                        maxLength: 6,
                                        onChanged: (value) async {
                                          if (int.parse(value) ==
                                              widget.meet.dynamicCode) {
                                            await widget.meet.update(
                                              {
                                                'initAt': Timestamp.now(),
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      'Ingresa la clave',
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.white,
                                        fontSize: 9,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (error, stack) {
              return Container();
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }
}

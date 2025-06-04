import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/auth/auth_changes_state.dart';
import 'package:basetime/features/chats/chat.dart';
import 'package:basetime/features/matches/match.dart';
import 'package:basetime/features/meets/meet.dart';
import 'package:basetime/features/meets/meet_page.dart';
import 'package:basetime/features/meets/stream_meets_state.dart';
import 'package:basetime/widgets/loader.dart';
import 'package:basetime/widgets/show_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MeetsTab extends ConsumerStatefulWidget {
  const MeetsTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MeetsTabState();
}

class _MeetsTabState extends ConsumerState<MeetsTab> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authChangesStateProvider);
    final getMeets = ref.watch(getMyMeetsProvider);
    return getMeets.when(
      data: (meets) {
        if (meets.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.lang!.emptyMeets,
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        meets.sort((a, b) => a.date.compareTo(b.date));

        return ListView.builder(
          itemCount: meets.length,
          itemBuilder: (context, index) {
            final meet = meets[index];
            return ListTile(
              onTap: () async {
                if (meet.status == MeetStatus.aceptPayed ||
                    meet.status == MeetStatus.qualify) {
                  final matchDoc = await matches.doc(meet.chatRef.id).get();
                  final match = matchDoc.data()!;
                  final chatDoc = await chats.doc(meet.chatRef.id).get();
                  final chat = chatDoc.data()!;
                  if (context.mounted) {
                    await context.push(
                      MeetPage.path,
                      extra: {
                        'meet': meet,
                        'chat': chat,
                        'match': match,
                      },
                    );
                  }
                }
              },
              leading: FutureBuilder<DocumentSnapshot<Chat>>(
                future: chats.doc(meet.chatRef.id).get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final doc = snapshot.data!;
                    final chat = doc.data()!;
                    return Image.network(chat.service.imageURL);
                  }
                  return const Text('');
                },
              ),
              title: FutureBuilder<DocumentSnapshot<Chat>>(
                future: chats.doc(meet.chatRef.id).get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final doc = snapshot.data!;
                    final chat = doc.data()!;
                    return Text(chat.service.title);
                  }
                  return const Text('');
                },
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if ((meet.status == MeetStatus.aceptPayed ||
                          meet.status == MeetStatus.qualify) &&
                      meet.author.id != currentUser.value!.data.uid)
                    Text(
                      'Con: ${meet.author.firstName} ${meet.author.lastName}',
                      style: GoogleFonts.ubuntu(
                        fontSize: 12,
                      ),
                    ),
                  Text(
                    'Fecha: ${DateFormat('dd/MM/yyyy h:mm a').format(meet.date)}',
                    style: GoogleFonts.ubuntu(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              trailing: meet.status == MeetStatus.aceptPayed ||
                      meet.status == MeetStatus.qualify
                  ? const Icon(Icons.chevron_right_rounded)
                  : null,
            );
          },
        );
      },
      error: (error, stackTrace) => ShowError(
        error: error,
        stackTrace: stackTrace,
      ),
      loading: () => const Loader(),
    );
  }
}

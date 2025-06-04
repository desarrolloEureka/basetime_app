import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/auth/auth_changes_state.dart';
import 'package:basetime/features/chats/chat_page.dart';
import 'package:basetime/features/matches/get_my_matches_state.dart';
import 'package:basetime/widgets/loader.dart';
import 'package:basetime/widgets/show_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatsTab extends ConsumerStatefulWidget {
  const ChatsTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatsTabState();
}

class _ChatsTabState extends ConsumerState<ChatsTab> {
  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(authChangesStateProvider);
    final streamMyMatches = ref.watch(streamMyMatchesProvider);
    return streamMyMatches.when(
      data: (matches) {
        if (matches.isEmpty || userState.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.lang!.emptyMatches,
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

        final user = userState.value!;

        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            final match = matches[index];
            final supplierOrClient = user.data.uid == match.client.id
                ? match.supplier
                : match.client;

            final isClient = user.data.uid == match.client.id;
            return ListTile(
              onTap: () {
                context.push(
                  ChatPage.path,
                  extra: match,
                );
              },
              // leading: CircleAvatar(
              //   foregroundImage: NetworkImage(
              //     supplierOrClient.photoURL ??
              //         "https://via.placeholder.com/512",
              //   ),
              // ),
              title: Text(
                '${supplierOrClient.firstName} '
                '${supplierOrClient.lastName}',
                style: GoogleFonts.ubuntu(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                '${context.lang!.hoursMeet(match.hours)} - '
                '${context.lang!.dollars(match.hours * match.service.pricePerHour)}',
                style: GoogleFonts.ubuntu(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              trailing: Container(
                decoration: BoxDecoration(
                  color: isClient ? Colors.red : Colors.green,
                ),
                padding: const EdgeInsets.all(8),
                child: Text(isClient ? 'Compra' : 'Venta'),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(
            color: Colors.white54,
          ),
          itemCount: matches.length,
        );
      },
      error: (error, stackTrace) {
        return ShowError(
          error: error,
          stackTrace: stackTrace,
        );
      },
      loading: () => const Loader(),
    );
  }
}

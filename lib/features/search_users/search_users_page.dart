import 'dart:async';

import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/auth/search_users_state.dart';
import 'package:basetime/features/feed/feed_details.dart';
import 'package:basetime/widgets/loader.dart';
import 'package:basetime/widgets/show_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

/// SearchUsersPage
class SearchUsersPage extends ConsumerStatefulWidget {
  const SearchUsersPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchUsersPageState();
}

class _SearchUsersPageState extends ConsumerState<SearchUsersPage> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  /// Appbar
  AppBar _appBar(BuildContext context) {
    final searchNotifier = ref.read(searchStateProvider.notifier);
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(59),
        child: Container(
          height: 49,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextFormField(
            style: GoogleFonts.ubuntu(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: context.lang!.search,
              hintStyle: GoogleFonts.ubuntu(
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(200),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              suffixIcon: const Icon(
                Icons.search_rounded,
                color: Colors.red,
              ),
            ),
            onChanged: (value) {
              if (_debounce?.isActive ?? false) {
                _debounce?.cancel();
              }
              _debounce = Timer(const Duration(milliseconds: 500), () {
                searchNotifier.search(value);
              });
            },
          ),
        ),
      ),
    );
  }

  /// Body
  Widget _body(BuildContext context) {
    final searchState = ref.watch(searchStateProvider);
    return searchState.when(
      data: (results) {
        if (results.isEmpty) {
          return Center(
            child: Text(
              'No results found',
              style: GoogleFonts.ubuntu(
                fontSize: 24,
              ),
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (BuildContext context, int index) {
            final user = results[index];
            return ListTile(
              onTap: () {
                context.push(
                  FeedDetails.path,
                  extra: user,
                );
              },
              tileColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              leading: SizedBox(
                width: 64,
                height: 64,
                child: user.data.photoURL != null
                    ? CircleAvatar(
                        foregroundImage: NetworkImage(
                          user.data.photoURL!,
                        ),
                      )
                    : Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(Icons.person),
                        ),
                      ),
              ),
              title: Text(
                '@${user.username}',
                style: GoogleFonts.ubuntu(
                  color: Colors.black54,
                ),
              ),
              subtitle: Text(
                user.data.displayName ?? '',
                style: GoogleFonts.ubuntu(
                  color: Colors.black54,
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 0,
              color: Colors.grey,
            );
          },
          itemCount: results.length,
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

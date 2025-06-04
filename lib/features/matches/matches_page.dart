import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/chats/chats_tab.dart';
import 'package:basetime/features/meets/meets_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchesPage extends ConsumerStatefulWidget {
  const MatchesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchesPageState();
}

class _MatchesPageState extends ConsumerState<MatchesPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          titleTextStyle: GoogleFonts.ubuntu(
            color: Colors.red,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          title: Text(context.lang!.matches),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: TabBar(
              dividerColor: Colors.transparent,
              tabAlignment: TabAlignment.center,
              tabs: [
                Tab(text: context.lang!.chat),
                Tab(text: context.lang!.meets),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            ChatsTab(),
            MeetsTab(),
          ],
        ),
      ),
    );
  }
}

import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/auth/user_entity.dart';
import 'package:basetime/features/comment/comments_state.dart';
import 'package:basetime/features/feed/feed_card.dart';
import 'package:basetime/features/feed/feed_content.dart';
import 'package:basetime/features/skills/stream_skill_state.dart';
import 'package:basetime/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedDetails extends ConsumerStatefulWidget {
  const FeedDetails({super.key, required this.user});

  static String name = 'feed-details';
  static String path = '/$name';

  final UserEntity user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedDetailsState();
}

class _FeedDetailsState extends ConsumerState<FeedDetails> {
  Position? position;

  @override
  void initState() {
    super.initState();
    getPosition();
  }

  Future<void> getPosition() async {
    final location = await Geolocator.getCurrentPosition();
    setState(() {
      position = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    final skillsState = ref.watch(
      streamSkillsProvider(widget.user.data.uid),
    );
    final commentsState = ref.watch(
      commentsStateProvider(widget.user.data.uid),
    );
    return Stack(
      children: [
        Image.asset(
          'assets/sign-in-bg.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBarBT(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Text(widget.user.username),
          ),
          body: skillsState.value != null && skillsState.value!.isEmpty
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          context.lang!.emptyCards,
                          style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 32,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )
              : position == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : FeedCard(
                      feed: FeedContent(
                        user: widget.user,
                        skills: skillsState.value ?? [],
                        comments: commentsState.value ?? [],
                      ),
                      position: position!,
                    ),
        ),
      ],
    );
  }
}

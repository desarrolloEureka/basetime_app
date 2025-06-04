import 'package:basetime/features/comment/comments_state.dart';
import 'package:basetime/features/feed/feed_content.dart';
import 'package:basetime/features/skills/stream_skill_state.dart';
import 'package:basetime/features/users/stream_users_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stream_feeds_state.g.dart';

@riverpod
class StreamFeedsState extends _$StreamFeedsState {
  Stream<List<FeedContent>> _stream() {
    final streamUsers = ref.watch(streamUsersProvider);
    final users = streamUsers.value;
    final feeds = <FeedContent>[];
    if (users != null) {
      for (final user in users) {
        final comments = ref.watch(commentsStateProvider(user.data.uid)).value;
        final streamSkills = ref.watch(
          streamSkillsProvider(user.data.uid),
        );
        final skills = streamSkills.value ?? [];
        if (skills.isNotEmpty) {
          feeds.add(
            FeedContent(
              user: user,
              skills: skills,
              comments: comments ?? [],
            ),
          );
        }
      }
    }
    return Stream.value(feeds);
  }

  @override
  Stream<List<FeedContent>> build() {
    return _stream();
  }
}

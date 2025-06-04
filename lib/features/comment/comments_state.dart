import 'package:basetime/features/comment/comment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comments_state.g.dart';

@riverpod
class CommentsState extends _$CommentsState {
  @override
  FutureOr<List<Comment>> build(String? userID) {
    return Comment.getList(userID);
  }

  Future<void> add(Comment comment) async {
    state = const AsyncLoading();
    await comment.add();
    state = await AsyncValue.guard(
      () => Comment.getList(comment.user.uid),
    );
  }
}

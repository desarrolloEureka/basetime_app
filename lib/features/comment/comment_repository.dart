import 'package:basetime/core/firebase/handle_errors.dart';
import 'package:basetime/core/firebase/repository.dart';
import 'package:basetime/features/comment/comment.dart';
import 'package:dartz/dartz.dart';

class CommentRepository extends FirebaseRepository {
  Future<Either<FirebaseError, List<Comment>>> getList() async {
    return const Right([]);
  }

  Future<Either<FirebaseError, Comment>> getComment(String id) async {
    return const Left(
      FirebaseError(code: 'Empty'),
    );
  }
}

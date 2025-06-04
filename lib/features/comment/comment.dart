import 'package:basetime/features/auth/custom_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final comments = FirebaseFirestore.instance
    .collection(
      'comments',
    )
    .withConverter<Comment>(
      fromFirestore: (doc, options) => Comment.fromFirestore(doc),
      toFirestore: (comment, options) => comment.toFirestore(),
    );

class Comment {
  Comment({
    required this.id,
    required this.rate,
    required this.content,
    required this.user,
    required this.author,
    required this.createdAt,
  });

  factory Comment.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final json = doc.data()!;
    return Comment(
      id: doc.id,
      rate: json['rate'] as int,
      content: json['content'] as String,
      user: CustomUser.fromJson(json['user']),
      author: CustomUser.fromJson({
        ...json['author'],
        'createdAt': (json['author']['createdAt'] as Timestamp?)?.toDate(),
      }),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  final String id;
  final int rate;
  final String content;
  final CustomUser user;
  final CustomUser author;
  final DateTime createdAt;

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'id': id,
      'rate': rate,
      'content': content,
      'user': user.toFirestore(),
      'author': author.toFirestore(),
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Future<void> add() async {
    await comments.add(this);
  }

  static Future<List<Comment>> getList(String? userID) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final snapshot = await comments
          .where(
            'user.uid',
            isEqualTo: userID ?? currentUser.uid,
          )
          .get();

      return List<Comment>.from(
        snapshot.docs.map((doc) => doc.data()),
      );
    }
    return [];
  }
}

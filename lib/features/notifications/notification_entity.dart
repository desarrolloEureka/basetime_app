import 'dart:developer';

import 'package:basetime/core/firebase/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final notifications = FirebaseFirestore.instance
    .collection(
  'notifications',
)
    .withConverter<NotificationEntity>(
  fromFirestore: (doc, _) {
    return NotificationEntity.fromDocument(doc);
  },
  toFirestore: (object, _) {
    return object.toJson();
  },
);

class NotificationEntity {
  NotificationEntity({
    required this.id,
    required this.content,
    required this.image,
    required this.to,
    required this.read,
    required this.createdAt,
    this.title,
  });

  factory NotificationEntity.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final json = doc.data()!;

    return NotificationEntity(
      id: doc.id,
      content: json['content'] as String,
      image: json['image'] as String,
      to: json['to'] as String,
      read: json['read'] as bool,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      title: json['title'] as String?,
    );
  }

  final String id;
  final String content;
  final String image;
  final String to;
  final bool read;
  final DateTime createdAt;
  String? title;

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'image': image,
      'to': to,
      'read': read,
      'createdAt': Timestamp.fromDate(createdAt),
      'title': title,
    };
  }

  static Stream<List<NotificationEntity>> stream() {
    final to = auth.currentUser!.uid;
    return notifications.where('to', isEqualTo: to).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  static Stream<int> streamNewsCount() {
    final uid = auth.currentUser!.uid;
    final snapshot = notifications
        .where('to', isEqualTo: uid)
        .where('read', isEqualTo: false)
        .snapshots();
    return snapshot.map((query) => query.size);
  }

  Future<void> toggleRead() async {
    try {
      await notifications.doc(id).update({
        'read': !read,
      });
    } catch (e) {
      log('Error on change to read notification', error: e);
    }
  }

  Future<void> destroy() async {
    try {
      await notifications.doc(id).delete();
    } catch (e) {
      log('Error on destroy notification', error: e);
    }
  }
}

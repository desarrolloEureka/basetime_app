import 'package:basetime/features/chats/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat;

final meets = FirebaseFirestore.instance
    .collection(
      'meets',
    )
    .withConverter<Meet>(
      fromFirestore: (doc, _) => Meet.fromDocument(doc),
      toFirestore: (object, _) => object.toJson(),
    );

class Meet {
  Meet({
    required this.id,
    required this.chatRef,
    required this.author,
    required this.dynamicCode,
    required this.seconds,
    required this.date,
    required this.createdAt,
    required this.status,
    this.initAt,
    this.cancellationAuthor,
  });

  factory Meet.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final json = doc.data()!;
    return Meet(
      id: doc.id,
      chatRef: json['chatRef'] as DocumentReference,
      author: chat.User.fromJson(json['author'] as Map<String, dynamic>),
      dynamicCode: json['dynamicCode'] as num,
      seconds: json['seconds'] as num,
      date: (json['date'] as Timestamp).toDate(),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      status: MeetStatus.values.firstWhere(
        (e) => e.name == (json['status'] as String),
      ),
      initAt: (json['initAt'] as Timestamp?)?.toDate(),
      cancellationAuthor: json['cancellationAuthor'] as String?,
    );
  }

  final String id;
  final DocumentReference chatRef;
  final chat.User author;
  final num dynamicCode;
  final num seconds;
  final DateTime date;
  final DateTime createdAt;
  final MeetStatus status;
  final DateTime? initAt;
  final String? cancellationAuthor;

  Map<String, dynamic> toJson() {
    return {
      'chatRef': chatRef,
      'author': author.toJson(),
      'dynamicCode': dynamicCode as int,
      'seconds': seconds as int,
      'date': Timestamp.fromDate(date),
      'createdAt': Timestamp.fromDate(createdAt),
      'status': status.name,
      'initAt': initAt != null ? Timestamp.fromDate(initAt!) : null,
      'cancellationAuthor': cancellationAuthor,
    };
  }

  bool get isClient => author.id == FirebaseAuth.instance.currentUser!.uid;
  bool get isSupplier => !isClient;

  bool get isPending {
    if (date.isBefore(DateTime.now())) {
      return false;
    }

    if (status == MeetStatus.complete || status == MeetStatus.cancel) {
      return false;
    }

    return true;
  }

  Future<DocumentReference<Meet>> create() async {
    try {
      return await meets.add(this);
    } on FirebaseException catch (error) {
      throw Exception(error.toString());
    } catch (error, stackTrace) {
      throw Exception('$error: $stackTrace');
    }
  }

  Future<void> update(Map<String, dynamic> json) async {
    try {
      await meets.doc(id).update(json);
    } on FirebaseException catch (error) {
      throw Exception(error.toString());
    } catch (error, stackTrace) {
      throw Exception('$error: $stackTrace');
    }
  }

  static Stream<Meet?> stream(String id, {bool allStatus = false}) {
    return meets.doc(id).snapshots().map((doc) {
      final meet = doc.data()!;
      if (allStatus) {
        return meet;
      } else if (meet.isPending) {
        return meet;
      } else {
        return null;
      }
    });
  }

  static Future<Meet?> getMeetbyMatchId(String matchID) async {
    final DocumentSnapshot<Chat> chatDoc = await chats.doc(matchID).get();
    final Chat chat = chatDoc.data()!;
    if (chat.meetRef != null) {
      final DocumentSnapshot<Meet> meetDoc = await meets
          .doc(
            chat.meetRef!.id,
          )
          .get();
      final meet = meetDoc.data()!;
      if (meet.isPending) {
        return meet;
      }
    }
    return null;
  }
}

/// Meet Status
enum MeetStatus {
  request,
  aceptNotPayed,
  aceptPayed,
  complete,
  qualify,
  cancel,
  reject,
}

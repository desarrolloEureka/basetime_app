import 'package:basetime/features/meets/meet.dart';
import 'package:basetime/features/meets/stream_meet_state.dart';
import 'package:basetime/features/skills/skill_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chats = FirebaseFirestore.instance
    .collection(
      'chats',
    )
    .withConverter<Chat>(
      fromFirestore: (doc, _) => Chat.fromDocument(doc),
      toFirestore: (object, _) => object.toJson(),
    );

class Chat {
  Chat({
    required this.id,
    required this.service,
    required this.supplierData,
    required this.client,
    required this.messages,
    this.meetRef,
  });

  factory Chat.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final json = doc.data()!;
    final messages = List<chat.Message>.from(
      (json['messages'] as List<dynamic>).map(
        (element) => chat.Message.fromJson(
          element as Map<String, dynamic>,
        ),
      ),
    )..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return Chat(
      id: doc.id,
      service: Skill.fromJson(json['service'] as Map<String, dynamic>),
      supplierData:
          chat.User.fromJson(json['supplierData'] as Map<String, dynamic>),
      client: chat.User.fromJson(json['client'] as Map<String, dynamic>),
      messages: messages,
      meetRef: json['meetRef'] as DocumentReference?,
    );
  }

  final String id;
  final Skill service;
  final chat.User supplierData;
  final chat.User client;
  final List<chat.Message> messages;
  DocumentReference? meetRef;

  Map<String, dynamic> toJson() {
    return {
      'service': {...service.toJson(), 'id': service.id},
      'supplierData': supplierData.toJson(),
      'client': client.toJson(),
      'messages': List<Map<String, dynamic>>.from(
        messages.map(
          (object) => object.toJson(),
        ),
      ),
      'meetRef': meetRef,
    };
  }

  chat.User get author {
    final authUser = FirebaseAuth.instance.currentUser!;
    if (authUser.uid == supplierData.id) {
      return supplierData;
    } else {
      return client;
    }
  }

  bool get isClient {
    final authUser = FirebaseAuth.instance.currentUser!;
    return authUser.uid == client.id;
  }

  chat.User get otherUser {
    final authUser = FirebaseAuth.instance.currentUser!;
    if (authUser.uid == supplierData.id) {
      return client;
    } else {
      return supplierData;
    }
  }

  bool get isSupplier {
    final authUser = FirebaseAuth.instance.currentUser!;
    return authUser.uid == supplierData.id;
  }

  DocumentReference get reference => chats.doc(id);

  Future<void> init() async {
    try {
      await chats.doc(id).set(this);
    } on FirebaseException catch (error) {
      throw Exception(error.toString());
    } catch (error, stackTrace) {
      throw Exception('$error: $stackTrace');
    }
  }

  /// Send message
  Future<void> sendMessage(
    chat.TextMessage message,
  ) async {
    try {
      await chats.doc(id).update({
        'messages': FieldValue.arrayUnion([message.toJson()]),
      });
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    } catch (e, s) {
      throw Exception('$e: $s');
    }
  }

  Meet? meet(WidgetRef ref) {
    if (meetRef == null) {
      return null;
    }
    final state = ref.watch(streamMeetStateProvider(meetRef!.id));
    return state.value;
  }

  Future<void> createMeet(Meet meet) async {
    try {
      final addMeet = await meet.create();
      await chats.doc(id).update({
        'meetRef': addMeet,
      });
    } on FirebaseException catch (error) {
      throw Exception(error.toString());
    } catch (error, stackTrace) {
      throw Exception('$error: $stackTrace');
    }
  }

  static Stream<Chat> stream(String id) {
    try {
      return chats.doc(id).snapshots().map((doc) {
        final data = doc.data()!;
        return data;
      });
    } on FirebaseException catch (error) {
      throw Exception(error.toString());
    } catch (error, stackTrace) {
      throw Exception('$error: $stackTrace');
    }
  }
}

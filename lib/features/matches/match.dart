import 'package:basetime/features/chats/chat.dart';
import 'package:basetime/features/skills/skill_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat;

final collection = FirebaseFirestore.instance
    .collection(
      'matches',
    )
    .withConverter(
      fromFirestore: (doc, _) => MatchModel.fromDocument(doc),
      toFirestore: (object, _) => object.toJson(),
    );

final matches = FirebaseFirestore.instance
    .collection(
      'matches',
    )
    .withConverter(
      fromFirestore: (doc, _) => MatchModel.fromDocument(doc),
      toFirestore: (object, _) => object.toJson(),
    );

class MatchModel {
  MatchModel({
    required this.id,
    required this.status,
    required this.service,
    required this.client,
    required this.supplier,
    required this.hours,
    required this.createdAt,
    this.openedAt,
    this.updatedAt,
  });

  factory MatchModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final json = doc.data()!;
    return MatchModel(
      id: doc.id,
      status: MatchStatus.values.firstWhere(
        (e) => e.name == (json['status'] as String),
      ),
      service: Skill.fromJson(json['service'] as Map<String, dynamic>),
      client: chat.User.fromJson(json['client'] as Map<String, dynamic>),
      supplier: chat.User.fromJson(json['supplier'] as Map<String, dynamic>),
      hours: json['hours'] as int,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      openedAt: (json['openedAt'] as Timestamp?)?.toDate(),
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  final String id;
  final MatchStatus status;
  final Skill service;
  final chat.User client;
  final chat.User supplier;
  final int hours;
  final DateTime createdAt;
  final DateTime? openedAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': status.name,
      'service': {...service.toJson(), 'id': service.id},
      'client': client.toJson(),
      'supplier': supplier.toJson(),
      'hours': hours,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  /// Furure My Matches
  static Future<List<MatchModel>> getMyMatches() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final snapshot = await collection
        .where(
          Filter.or(
            Filter('client.id', isEqualTo: currentUser.uid),
            Filter('supplier.id', isEqualTo: currentUser.uid),
          ),
        )
        .get();

    if (snapshot.docs.isNotEmpty) {
      return List<MatchModel>.from(
        snapshot.docs.map(
          (doc) => doc.data(),
        ),
      );
    } else {
      return [];
    }
  }

  /// Stream My Matches
  static Stream<List<MatchModel>> streamMyMatches() {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final snapshot = collection
        .where(
          Filter.or(
            Filter('client.id', isEqualTo: currentUser.uid),
            Filter('supplier.id', isEqualTo: currentUser.uid),
          ),
        )
        .snapshots();

    return snapshot.map(
      (query) {
        if (query.docs.isNotEmpty) {
          return List<MatchModel>.from(
            query.docs.map(
              (doc) => doc.data(),
            ),
          );
        } else {
          return [];
        }
      },
    );
  }

  /// Match!
  Future<void> match() async {
    try {
      final matchRef = await collection.add(this);

      await Chat(
        id: matchRef.id,
        client: client,
        supplierData: supplier,
        service: service,
        messages: [],
      ).init();
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    } catch (error, stackTrace) {
      throw Exception('$error: $stackTrace');
    }
  }

  /// Get match
  static Future<MatchModel> getMatch(Skill service) async {
    try {
      final query = await collection
          .where(
            Filter('service.id', isEqualTo: service.id),
          )
          .get();

      if (query.docs.isNotEmpty) {
        return query.docs.first.data();
      } else {
        throw Exception('Match not found');
      }
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    } catch (error, stackTrace) {
      throw Exception('$error: $stackTrace');
    }
  }
}

enum MatchStatus {
  notPayed,
  canceled,
  inDispute,
  payed,
}

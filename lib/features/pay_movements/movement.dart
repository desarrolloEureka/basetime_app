import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final movements =
    FirebaseFirestore.instance.collection('movements').withConverter(
          fromFirestore: (doc, opts) => Movement.fromFirestore(doc),
          toFirestore: (movement, opts) => movement.toFirestore(),
        );

class Movement {
  Movement({
    required this.id,
    required this.description,
    required this.type,
    required this.total,
    required this.userID,
    required this.createdAt,
    required this.meetId,
    this.subtotal,
    this.titular,
    this.serviceCommission,
  });

  factory Movement.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Movement(
      id: doc.id,
      description: data['description'] as String,
      type: MovementType.values.firstWhere(
        (type) {
          return type.name == (data['type'] as String);
        },
      ),
      meetId: data['meetId'] as String,
      total: data['total'] as num,
      userID: data['userId'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      titular: data['titular'] as String?,
      subtotal: data['subtotal'] as num?,
      serviceCommission: data['serviceCommission'] as num?,
    );
  }

  final String id;
  final String description;
  final MovementType type;
  final num total;
  final String userID;
  final DateTime createdAt;
  final String meetId;
  final String? titular;
  final num? subtotal;
  final num? serviceCommission;

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'type': type.name,
      'total': total,
      'userId': userID,
      'createdAt': Timestamp.fromDate(createdAt),
      'subtotal': subtotal,
      'serviceCommission': serviceCommission,
    };
  }

  Future<void> create() async {
    await movements.add(this);
  }

  static Future<List<Movement>> getMyMovements() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await movements.where('userId', isEqualTo: uid).get();

    if (snapshot.docs.isEmpty) {
      return <Movement>[];
    }
    return List<Movement>.from(
      snapshot.docs.map(
        (doc) => doc.data(),
      ),
    );
  }
}

enum MovementType {
  payment,
  paymentReferral,
  withdrawal,
  pendingWithdrawal,
  refund,
  pending,
  charged,
}

extension MovementTypeExtension on MovementType {
  Widget get icon => switch (this) {
        MovementType.payment => const Icon(
            Icons.arrow_circle_down_outlined,
            size: 32,
            color: Colors.red,
          ),
        MovementType.paymentReferral => const Icon(
            Icons.arrow_circle_up_outlined,
            size: 32,
            color: Colors.white,
          ),
        MovementType.withdrawal => const Icon(
            Icons.arrow_circle_down_outlined,
            size: 32,
            color: Colors.red,
          ),
        MovementType.pendingWithdrawal => const Icon(
            Icons.alarm_outlined,
            size: 32,
            color: Colors.white,
          ),
        MovementType.refund => const Icon(
            Icons.arrow_circle_up_outlined,
            size: 32,
            color: Colors.white,
          ),
        MovementType.pending => const Icon(
            Icons.alarm_outlined,
            size: 32,
            color: Colors.white,
          ),
        MovementType.charged => const Icon(
            Icons.arrow_circle_up_outlined,
            size: 32,
            color: Colors.white,
          ),
      };

  Color get color => switch (this) {
        MovementType.payment => Colors.red,
        MovementType.paymentReferral => Colors.white,
        MovementType.withdrawal => Colors.red,
        MovementType.pendingWithdrawal => Colors.white,
        MovementType.refund => Colors.white,
        MovementType.pending => Colors.white,
        MovementType.charged => Colors.white,
      };

  Widget get detailsIcon => switch (this) {
        MovementType.payment => const Icon(
            Icons.arrow_circle_down_outlined,
            size: 32,
            color: Colors.white,
          ),
        MovementType.paymentReferral => const Icon(
            Icons.arrow_circle_up_outlined,
            size: 32,
            color: Colors.white,
          ),
        MovementType.withdrawal => const Icon(
            Icons.arrow_circle_down_outlined,
            size: 32,
            color: Colors.red,
          ),
        MovementType.pendingWithdrawal => const Icon(
            Icons.alarm_outlined,
            size: 32,
            color: Colors.white,
          ),
        MovementType.refund => const Icon(
            Icons.arrow_circle_up_outlined,
            size: 32,
            color: Colors.white,
          ),
        MovementType.pending => const Icon(
            Icons.alarm_outlined,
            size: 32,
            color: Colors.white,
          ),
        MovementType.charged => const Icon(
            Icons.arrow_circle_up_outlined,
            size: 32,
            color: Colors.white,
          ),
      };
}

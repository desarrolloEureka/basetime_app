import 'package:basetime/features/matches/match.dart';
import 'package:basetime/features/meets/meet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final wallets = FirebaseFirestore.instance.collection('wallets').withConverter(
      fromFirestore: (doc, _) => Wallet.fromFirestore(doc),
      toFirestore: (wallet, _) => wallet.toFirestore(),
    );

class Wallet {
  Wallet({
    required this.id,
    required this.balance,
    required this.refund,
    required this.createdAt,
  });

  factory Wallet.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final json = doc.data()!;
    return Wallet(
      id: doc.id,
      balance: json['balance'] as num,
      refund: json['refund'] as num,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  final String id;
  final num balance;
  final num refund;
  final DateTime createdAt;

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'balance': balance,
      'refund': refund,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Future<void> update(Map<String, dynamic> json) async {
    await wallets.doc(id).update({
      ...json,
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> payment(MatchModel match, Meet meet) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final wallet = (await wallets.doc(user.uid).get()).data()!;
      final amount = match.hours * match.service.pricePerHour;

      if (wallet.refund < amount) {
        final restAmount = amount - wallet.refund;
        final change = wallet.balance - restAmount;
        await wallet.update({
          'refund': 0,
          'balance': change,
        });
      } else {
        final change = wallet.refund - amount;
        await wallet.update({
          'refund': change,
        });
      }

      await meet.update({
        'status': MeetStatus.aceptPayed.name,
        'service': match.service.id,
        'amount': amount,
        'hours': match.hours,
      });
    }
  }

  static Stream<Wallet?> getMyWallet() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = wallets.doc(uid).snapshots();
    return snapshot.map((document) {
      return document.data();
    });
  }

  static Future<void> init(String uid) async {
    await wallets.doc(uid).set(
          Wallet(
            id: uid,
            // ignore: prefer_int_literals
            balance: 0.0,
            refund: 0.0,
            createdAt: DateTime.now(),
          ),
        );
  }
}

import 'package:basetime/core/utils/generate_signature.dart';
import 'package:basetime/env.dart';
import 'package:basetime/features/bank_accounts/add_bank_account_page.dart';
import 'package:basetime/features/payments/payment_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

final banksAccounts = FirebaseFirestore.instance
    .collection('banksAccounts')
    .withConverter<BankAccount>(
      fromFirestore: (doc, _) => BankAccount.fromFirestore(doc),
      toFirestore: (bankAccount, _) => bankAccount.toFirestore(),
    );

class BankAccount {
  BankAccount({
    required this.id,
    required this.bank,
    required this.type,
    required this.number,
    required this.titular,
    required this.createdAt,
    required this.userID,
  });

  factory BankAccount.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final json = doc.data()!;
    return BankAccount(
      id: doc.id,
      bank: json['bank'] as String,
      type: AccountType.values.firstWhere(
        (element) => element.name == json['type'],
      ),
      number: json['number'] as String,
      titular: json['titular'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      userID: json['userID'] as String,
    );
  }

  final String id;
  final String bank;
  final AccountType type;
  final String number;
  final String titular;
  final DateTime createdAt;
  final String userID;

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'bank': bank,
      'type': type.name,
      'number': number,
      'titular': titular,
      'createdAt': Timestamp.fromDate(createdAt),
      'userID': userID,
    };
  }

  Future<void> add() async {
    final ref = await banksAccounts.add(this);
    await ref.update({'id': ref.id});
  }

  Future<void> delete() async {
    await banksAccounts.doc(id).delete();
  }

  static Future<List<BankAccount>> getMyList() async {
    final snapshot = await banksAccounts
        .where(
          'userID',
          isEqualTo: FirebaseAuth.instance.currentUser!.uid,
        )
        .get();

    return List<BankAccount>.from(
      snapshot.docs.map(
        (doc) => doc.data(),
      ),
    );
  }

  Future<Map<String, dynamic>?> payment({
    required int amountInCents,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final getAcceptance = await dio.get<Map<String, dynamic>>(
        'https://sandbox.wompi.co/v1/merchants/${Env.testPublicKey}',
      );

      if (getAcceptance.statusCode != 200) {
        throw Exception('Error getting acceptance');
      }

      final reference = '${user.uid}-${DateTime.now().millisecondsSinceEpoch}';

      final signature = generateSignatureWompi(
        reference,
        amountInCents.toString(),
        'COP',
        Env.testIntegrity,
      );

      final response = await dio.post<Map<String, dynamic>>(
        'https://sandbox.wompi.co/v1/transactions',
        options: Options(
          headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Env.testSecretKey}',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
        data: {
          'acceptance_token': getAcceptance.data!['data']
              ['presigned_acceptance']['acceptance_token'],
          'accept_personal_auth': getAcceptance.data!['data']
              ['presigned_personal_data_auth']['acceptance_token'],
          'signature': signature,
          'amount_in_cents': amountInCents,
          'currency': 'COP',
          'customer_email': user.email,
          'payment_method': {
            'type': 'NEQUI',
            'phone_number': number,
          },
          'reference': reference,
        },
      );

      if (response.statusCode == 201 && response.data != null) {
        await Future.delayed(
          const Duration(seconds: 5),
          () {},
        );
        final transactionRes = await dio.get<Map<String, dynamic>>(
          'https://sandbox.wompi.co/v1/transactions/${response.data!['data']['id']}',
          options: Options(
            headers: {
              'accept': '*/*',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${Env.testSecretKey}',
            },
          ),
        );
        return transactionRes.data!['data'];
      }

      if (response.statusCode == 422 && response.data != null) {
        throw Exception(response.data!['error']);
      }
      return null;
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}

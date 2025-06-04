import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/core/utils/generate_signature.dart';
import 'package:basetime/env.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final dio = Dio();

class PaymentMethod {
  const PaymentMethod({
    required this.id,
    required this.token,
    required this.brand,
    required this.name,
    required this.lastFour,
    required this.bin,
    required this.expYear,
    required this.expMonth,
    required this.cardHolder,
    required this.expiresAt,
    required this.userUID,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'] as String,
      token: json['token'] as String,
      brand: json['brand'] as String,
      name: json['name'] as String,
      lastFour: json['last_four'] as String,
      bin: json['bin'] as String,
      expYear: json['exp_year'] as String,
      expMonth: json['exp_month'] as String,
      cardHolder: json['card_holder'] as String,
      expiresAt: DateTime.parse(json['expires_at'] as String),
      userUID: json['user_uid'] as String,
    );
  }

  factory PaymentMethod.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final json = doc.data()!;
    return PaymentMethod(
      id: doc.id,
      token: json['id'] as String,
      brand: json['brand'] as String,
      name: json['name'] as String,
      lastFour: json['lastFour'] as String,
      bin: json['bin'] as String,
      expYear: json['expYear'] as String,
      expMonth: json['expMonth'] as String,
      cardHolder: json['cardHolder'] as String,
      expiresAt: (json['expiresAt'] as Timestamp).toDate(),
      userUID: json['userUID'] as String,
    );
  }

  final String id;
  final String token;
  final String brand;
  final String name;
  final String lastFour;
  final String bin;
  final String expYear;
  final String expMonth;
  final String cardHolder;
  final DateTime expiresAt;
  final String userUID;

  Map<String, Object> toJson() {
    return {
      'id': token,
      'brand': brand,
      'name': name,
      'lastFour': lastFour,
      'bin': bin,
      'expYear': expYear,
      'expMonth': expMonth,
      'cardHolder': cardHolder,
      'expiresAt': Timestamp.fromDate(expiresAt),
      'userUID': userUID,
    };
  }

  CollectionReference get collection {
    return FirebaseFirestore.instance
        .collection(
      'paymentMethods',
    )
        .withConverter<PaymentMethod>(
      fromFirestore: (doc, _) {
        return PaymentMethod.fromDocument(doc);
      },
      toFirestore: (object, _) {
        return object.toJson();
      },
    );
  }

  static Future<List<PaymentMethod>> fetch() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    final snapshot = await FirebaseFirestore.instance
        .collection(
          'paymentMethods',
        )
        .withConverter<PaymentMethod>(
          fromFirestore: (doc, _) {
            return PaymentMethod.fromDocument(doc);
          },
          toFirestore: (object, _) {
            return object.toJson();
          },
        )
        .where('userUID', isEqualTo: user.uid)
        .get();

    return List<PaymentMethod>.from(
      snapshot.docs.map((doc) => doc.data()),
    );
  }

  static Future<DocumentReference<Object?>> create({
    required String number,
    required String cvc,
    required String expMonth,
    required String expYear,
    required String cardHolder,
  }) async {
    final user = FirebaseAuth.instance.currentUser!;
    final response = await dio.post<Map<String, dynamic>>(
      'https://sandbox.wompi.co/v1/tokens/cards',
      options: Options(
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Env.testPublicKey}',
        },
      ),
      data: {
        'number': number,
        'cvc': cvc,
        'exp_month': expMonth,
        'exp_year': expYear,
        'card_holder': cardHolder,
      },
    );

    final json = response.data;

    if (json != null && json['status'] == 'CREATED') {
      json.remove('status');
      final paymentMethod = PaymentMethod.fromJson({
        ...json['data'],
        'token': json['data']['id'],
        'user_uid': user.uid,
      });
      return paymentMethod.collection.add(paymentMethod);
    } else {
      throw Exception('Error creating payment method');
    }
  }

  Future<void> delete() async {
    await collection.doc(id).delete();
  }

  Future<Map<String, dynamic>?> payment({
    required int amountInCents,
    required int installments,
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
            'type': 'CARD',
            'token': token,
            'installments': installments,
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

enum PaymentMethodType {
  creditCard,
  debitCard,
}

extension PaymentMethodTypeExtencion on PaymentMethodType {
  String langName(BuildContext context) {
    return switch (this) {
      PaymentMethodType.creditCard => context.lang!.creditCard,
      PaymentMethodType.debitCard => context.lang!.debitCard,
    };
  }
}

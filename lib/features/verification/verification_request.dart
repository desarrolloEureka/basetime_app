import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final collection = FirebaseFirestore.instance
    .collection('verifications')
    .withConverter<VerificationRequest>(
      fromFirestore: (doc, _) => VerificationRequest.fromDocument(doc),
      toFirestore: (object, _) => object.toJson(),
    );

class VerificationRequest {
  VerificationRequest({
    required this.id,
    required this.frontURL,
    required this.backURL,
    required this.selfieURL,
    required this.email,
    required this.status,
    required this.createdAt,
    this.displayName,
    this.rejectedReason,
    this.updatedAt,
  });

  factory VerificationRequest.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final json = doc.data()!;
    return VerificationRequest(
      id: doc.id,
      frontURL: json['frontURL'] as String,
      backURL: json['backURL'] as String,
      selfieURL: json['selfieURL'] as String,
      email: json['email'] as String,
      status: VerificationStatus.values.firstWhere(
        (e) => e.name == (json['status'] as String),
      ),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      displayName: json['displayName'] as String?,
      rejectedReason: json['rejectedReason'] as String?,
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  final String id;
  final String frontURL;
  final String backURL;
  final String selfieURL;
  final String email;
  final VerificationStatus status;
  final DateTime createdAt;
  final String? displayName;
  final String? rejectedReason;
  final DateTime? updatedAt;

  bool get isApproved => status == VerificationStatus.approved;
  bool get isPending => status == VerificationStatus.pending;
  bool get isRejected => status == VerificationStatus.rejected;

  Map<String, dynamic> toJson() => {
        'frontURL': frontURL,
        'backURL': backURL,
        'selfieURL': selfieURL,
        'email': email,
        'status': status.name,
        'createdAt': Timestamp.fromDate(createdAt),
        'displayName': displayName,
        'rejectedReason': rejectedReason,
      };

  static Stream<VerificationRequest?> stream() {
    final snapshot = collection
        .doc(
          FirebaseAuth.instance.currentUser!.uid,
        )
        .snapshots();
    return snapshot.map(
      (doc) {
        if (!doc.exists) {
          return null;
        }
        return doc.data()!;
      },
    );
  }

  static Future<void> sendVerifyAccountRequest({
    required File front,
    required File back,
    required File selfie,
  }) async {
    final storage = FirebaseStorage.instance;
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      final frontRef = storage.ref().child('/user/${user.uid}/dni/front.png');
      final backRef = storage.ref().child('/user/${user.uid}/dni/back.png');
      final selfieRef = storage.ref().child('/user/${user.uid}/dni/selfie.png');
      final uploadFront = await frontRef.putFile(front);
      final uploadBack = await backRef.putFile(back);
      final uploadSelfie = await selfieRef.putFile(selfie);
      final frontUrl = await uploadFront.ref.getDownloadURL();
      final backUrl = await uploadBack.ref.getDownloadURL();
      final selfieUrl = await uploadSelfie.ref.getDownloadURL();

      await collection.doc(user.uid).set(
            VerificationRequest(
              id: '',
              email: auth.currentUser?.email ?? '',
              backURL: backUrl,
              frontURL: frontUrl,
              selfieURL: selfieUrl,
              createdAt: DateTime.now(),
              displayName: auth.currentUser?.displayName,
              status: VerificationStatus.pending,
            ),
          );
    }
  }
}

enum VerificationStatus {
  pending,
  approved,
  rejected,
}

extension VerificationStatusExtension on VerificationStatus {
  String get displayName {
    return switch (this) {
      VerificationStatus.pending => 'Pendiente',
      VerificationStatus.approved => 'Aprobado',
      VerificationStatus.rejected => 'Rechazado',
    };
  }
}

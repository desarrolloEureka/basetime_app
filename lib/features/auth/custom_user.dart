import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomUser {
  CustomUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
    this.createdAt,
  });

  factory CustomUser.fromUser(User user) {
    return CustomUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
      createdAt: user.metadata.creationTime,
    );
  }

  factory CustomUser.fromJson(Map<String, dynamic> json) {
    return CustomUser(
      uid: json['uid'] as String,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      createdAt: json['createdAt'] as DateTime?,
    );
  }

  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final DateTime? createdAt;

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseRepository {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  Query users = FirebaseFirestore.instance.collection('users');
}

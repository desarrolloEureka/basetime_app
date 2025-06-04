import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class Instances<T> {
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  CollectionReference<T> collection(
    String path, {
    required T Function(Map<String, dynamic> json) fromJson,
    required Map<String, dynamic> Function(T object) toJson,
  }) {
    return FirebaseFirestore.instance.collection(path).withConverter<T>(
      fromFirestore: (snapshot, _) {
        final data = snapshot.data()!;
        return fromJson({
          ...data,
          'id': snapshot.id,
        });
      },
      toFirestore: (object, _) {
        final json = toJson(object)..remove('id');
        return json;
      },
    );
  }
}

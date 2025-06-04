import 'package:cloud_firestore/cloud_firestore.dart';

final banks =
    FirebaseFirestore.instance.collection('banks').withConverter<Bank>(
          fromFirestore: (doc, _) => Bank.fromFirestore(doc),
          toFirestore: (bank, _) => bank.toFirestore(),
        );

class Bank {
  Bank({
    required this.id,
    required this.name,
  });

  factory Bank.fromFirestore(DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data() as Map<String, dynamic>;
    return Bank(
      id: document.id,
      name: json['name'] as String,
    );
  }

  final String id;
  final String name;

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
    };
  }

  static Future<List<Bank>> getList() async {
    final snapshot = await banks.get();
    return List<Bank>.from(
      snapshot.docs.map(
        (element) => element.data(),
      ),
    );
  }
}

import 'package:basetime/core/abstracts/instances.dart';
import 'package:basetime/features/settings/legal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LegalReposiory extends Instances<Legal> {
  final path = 'settings';

  DocumentReference get document {
    return FirebaseFirestore.instance.collection('settings').doc('legal');
  }

  Future<Legal> fetch() async {
    final legalDocument = await document.get();
    if (!legalDocument.exists) {
      throw Exception('Legal document not found');
    }
    return Legal.fromJson(legalDocument.data() as Map<String, dynamic>);
  }
}

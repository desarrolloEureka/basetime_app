import 'package:basetime/core/abstracts/instances.dart';
import 'package:basetime/features/settings/commissions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommissionsRepository extends Instances<Commissions> {
  final path = 'settings';

  DocumentReference get document {
    return FirebaseFirestore.instance.collection(path).doc('commissions');
  }

  Future<Commissions> fetch() async {
    final results = await document.get();
    return Commissions.fromJson(results.data() as Map<String, dynamic>);
  }
}

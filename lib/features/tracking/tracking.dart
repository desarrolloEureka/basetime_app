import 'package:cloud_firestore/cloud_firestore.dart';

final tracking =
    FirebaseFirestore.instance.collection('tracking').withConverter(
          fromFirestore: (doc, _) => Tracking.fromFirestore(doc),
          toFirestore: (tracking, _) => tracking.toFirestore(),
        );

class Tracking {
  Tracking({
    required this.id,
    required this.geoPoint,
    required this.updatedAt,
  });

  factory Tracking.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Tracking(
      id: doc.id,
      geoPoint: data['geoPoint'] as GeoPoint,
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  final String id;
  final GeoPoint geoPoint;
  final DateTime updatedAt;

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'geoPoint': geoPoint,
      'updatedAt': updatedAt,
    };
  }
}

import 'dart:io';

import 'package:basetime/core/utils/dynamic_to_entity.dart';
import 'package:basetime/features/categories/category_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final skills = FirebaseFirestore.instance
    .collection(
      'skills',
    )
    .withConverter<Skill>(
      fromFirestore: (doc, _) => Skill.fromFirestore(doc),
      toFirestore: (object, _) => object.toJson(),
    );

class Skill {
  Skill({
    required this.userID,
    required this.id,
    required this.imageURL,
    required this.title,
    required this.pricePerHour,
    required this.categories,
    required this.saved,
    required this.favorites,
    this.description,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      userID: json['userID'] as String,
      id: json['id'] as String,
      imageURL: json['imageURL'] as String,
      title: json['title'] as String,
      pricePerHour: json['pricePerHour'] as num,
      categories: List<CategoryEntity>.from(
        dynamicToMap(json['categories']).map(
          CategoryEntity.fromJson,
        ),
      ),
      saved: json['saved'].cast<String>(),
      favorites: json['favorites'].cast<String>(),
      description: json['description'] as String?,
    );
  }

  factory Skill.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final json = doc.data()!;
    return Skill(
      userID: json['userID'] as String,
      id: doc.id,
      imageURL: json['imageURL'] as String,
      title: json['title'] as String,
      pricePerHour: json['pricePerHour'] as num,
      categories: List<CategoryEntity>.from(
        dynamicToMap(json['categories']).map(
          CategoryEntity.fromJson,
        ),
      ),
      description: json['description'] as String?,
      saved: json['saved'].cast<String>(),
      favorites: json['favorites'].cast<String>(),
    );
  }

  final String userID;
  final String id;
  final String imageURL;
  final String title;
  final num pricePerHour;
  final List<CategoryEntity> categories;
  final List<String> saved;
  final List<String> favorites;
  final String? description;

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'imageURL': imageURL,
      'title': title,
      'pricePerHour': pricePerHour,
      'categories': categories.map((e) => e.toJson()).toList(),
      'description': description,
      'saved': saved,
      'favorites': favorites,
    };
  }

  Skill copyWith({
    String? userID,
    String? id,
    String? imageURL,
    String? title,
    num? pricePerHour,
    List<CategoryEntity>? categories,
    String? description,
    List<String>? saved,
    List<String>? favorites,
  }) {
    return Skill(
      userID: userID ?? this.userID,
      id: id ?? this.id,
      imageURL: imageURL ?? this.imageURL,
      title: title ?? this.title,
      pricePerHour: pricePerHour ?? this.pricePerHour,
      categories: categories ?? this.categories,
      description: description ?? this.description,
      saved: saved ?? this.saved,
      favorites: favorites ?? this.favorites,
    );
  }

  bool get isSaved {
    return saved.contains(FirebaseAuth.instance.currentUser!.uid);
  }

  bool get isFavorite {
    return favorites.contains(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> toggleSave() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      if (isSaved) {
        await skills.doc(id).update({
          'saved': FieldValue.arrayRemove([user.uid]),
        });
      } else {
        await skills.doc(id).update({
          'saved': FieldValue.arrayUnion([user.uid]),
        });
      }
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    } catch (e, s) {
      throw Exception('$e: $s');
    }
  }

  Future<void> toggleLike() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      if (isFavorite) {
        await skills.doc(id).update({
          'favorites': FieldValue.arrayRemove([user.uid]),
        });
      } else {
        await skills.doc(id).update({
          'favorites': FieldValue.arrayUnion([user.uid]),
        });
      }
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    } catch (e, s) {
      throw Exception('$e: $s');
    }
  }

  Future<void> update(Map<String, dynamic> json) async {
    try {
      if (json['image'] != null) {
        final ref = FirebaseStorage.instance.ref().child(
              'skills/${FirebaseAuth.instance.currentUser?.uid}/${Timestamp.now().millisecondsSinceEpoch}.png',
            );
        final uploadTask = await ref.putFile(json['image']);
        json['imageURL'] = await uploadTask.ref.getDownloadURL();
      }
      json.remove('image');
      await skills.doc(id).update(json);
    } on FirebaseException catch (error) {
      throw Exception(error.toString());
    } catch (error, stackTrace) {
      throw Exception('$error: $stackTrace');
    }
  }

  static Stream<List<Skill>> streamSkills(String uid) {
    final snapshot = skills.where('userID', isEqualTo: uid).snapshots();
    return snapshot.map(
      (query) {
        return List<Skill>.from(
          query.docs.map(
            (doc) => doc.data(),
          ),
        );
      },
    );
  }

  static Future<List<Skill>> getSaved() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final snapshot = await skills
          .where(
            'saved',
            arrayContains: user.uid,
          )
          .get();

      return List<Skill>.from(
        snapshot.docs.map(
          (doc) => doc.data(),
        ),
      );
    } on FirebaseException catch (error) {
      throw Exception(error.toString());
    } catch (error, stackTrace) {
      throw Exception('$error: $stackTrace');
    }
  }

  static Future<void> add({
    required String title,
    required num pricePerHour,
    required File image,
    required List<CategoryEntity> categories,
    String? description,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final ref = FirebaseStorage.instance.ref().child(
            'skills/${FirebaseAuth.instance.currentUser?.uid}/${Timestamp.now().millisecondsSinceEpoch}.png',
          );
      final uploadTask = await ref.putFile(image);
      final imageURL = await uploadTask.ref.getDownloadURL();
      final skill = Skill(
        userID: user.uid,
        id: '',
        title: title,
        pricePerHour: pricePerHour,
        imageURL: imageURL,
        categories: categories,
        description: description,
        saved: [],
        favorites: [],
      );
      await skills.add(skill);
    } on FirebaseException catch (error) {
      throw Exception(error.toString());
    } catch (error, stackTrace) {
      throw Exception('$error: $stackTrace');
    }
  }
}

import 'dart:io';

import 'package:basetime/core/firebase/auth.dart';
import 'package:basetime/features/auth/custom_user.dart';
import 'package:basetime/features/categories/category_entity.dart';
import 'package:basetime/features/payments/payment_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final users = FirebaseFirestore.instance.collection('users');
final dio = Dio();

class UserEntity {
  const UserEntity({
    required this.data,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.id,
    this.promoterId,
    this.categories,
    this.subCategories,
    this.paymentMethods,
    this.instagram,
    this.tiktok,
    this.location,
    this.updatedAt,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      data: CustomUser.fromJson(json['data'] as Map<String, dynamic>),
      username: json['username'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      id: json['id'] as num,
      promoterId: json['promoterId'] as num?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      subCategories: (json['subCategories'] as List<dynamic>?)
          ?.map((e) => CategoryEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentMethods: (json['paymentMethods'] as List<dynamic>?)
          ?.map((e) => PaymentMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
      instagram: json['instagram'] as String?,
      tiktok: json['tiktok'] as String?,
      location: json['location'] as GeoPoint?,
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  factory UserEntity.fromAuthJson(Map<String, dynamic> json) {
    final user = auth.currentUser!;
    return UserEntity(
      data: CustomUser.fromUser(user),
      username: json['username'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      id: json['id'] as num,
      promoterId: json['promoterId'] as num?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      subCategories: (json['subCategories'] as List<dynamic>?)
          ?.map((e) => CategoryEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentMethods: (json['paymentMethods'] as List<dynamic>?)
          ?.map((e) => PaymentMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
      instagram: json['instagram'] as String?,
      tiktok: json['tiktok'] as String?,
      location: json['location'] as GeoPoint?,
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  final CustomUser data;
  final String username;
  final String firstName;
  final String lastName;
  final num id;
  final num? promoterId;
  final List<CategoryEntity>? categories;
  final List<CategoryEntity>? subCategories;
  final List<PaymentMethod>? paymentMethods;
  final String? instagram;
  final String? tiktok;
  final GeoPoint? location;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'data': data,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'id': id,
      'promoterId': promoterId,
      'categories': categories != null
          ? List<Map<String, dynamic>>.from(
              categories!.map(
                (e) => e.toJson(),
              ),
            )
          : null,
      'subCategories': subCategories != null
          ? List<Map<String, dynamic>>.from(
              subCategories!.map(
                (e) => e.toJson(),
              ),
            )
          : null,
      'paymentMethods': paymentMethods != null
          ? List<Map<String, dynamic>>.from(
              paymentMethods!.map(
                (e) => e.toJson(),
              ),
            )
          : null,
      'instagram': instagram,
      'tiktok': tiktok,
      'location': location,
    };
  }

  Future<void> update({
    String? firstName,
    String? lastName,
    int? id,
    String? username,
    String? instagram,
    String? tiktok,
    int? promoterId,
    File? avatar,
    GeoPoint? location,
    DateTime? updatedAt,
  }) async {
    try {
      final json = <String, dynamic>{};

      if (firstName != null) {
        json['firstName'] = firstName;
      }

      if (lastName != null) {
        json['lastName'] = lastName;
      }

      if (id != null) {
        json['id'] = id;
      }

      if (this.username != username) {
        json['username'] = username;
      }

      if (promoterId != null) {
        json['promoterId'] = promoterId;
      }

      if (instagram != null) {
        json['instagram'] = instagram;
      }

      if (tiktok != null) {
        json['tiktok'] = tiktok;
      }

      if (location != null) {
        json['location'] = location;
      }

      if (updatedAt != null) {
        json['updatedAt'] = updatedAt;
      }

      if (avatar != null) {
        var ref = FirebaseStorage.instance
            .ref()
            .child('users/${data.uid}/avatar.png');
        if (data.photoURL != null) {
          ref = FirebaseStorage.instance.refFromURL(data.photoURL!);
          await ref.delete();
        }
        final uploadTask = await ref.putFile(avatar);
        final avatarURL = await uploadTask.ref.getDownloadURL();
        await FirebaseAuth.instance.currentUser!.updatePhotoURL(avatarURL);
      }

      await users.doc(data.uid).update(json);
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    } catch (error, stackTrace) {
      throw Exception('$error: $stackTrace');
    }
  }

  Future<void> softDelete() async {
    final user = auth.currentUser;
    if (user != null) {
      await users.doc(data.uid).update({
        'softDelete': Timestamp.now(),
      });
    }
  }

  /// Stream Users List
  static Stream<List<UserEntity>> stream() {
    final snapshot =
        users.where('roles', isEqualTo: null).orderBy('username').snapshots();
    return snapshot.asyncMap(
      (query) async {
        final authUser = FirebaseAuth.instance.currentUser!;
        final accessToken = await authUser.getIdToken();
        final docs = query.docs.where((e) => e.id != authUser.uid);
        if (docs.isNotEmpty) {
          final uids = List<String>.from(
            docs.map((e) => e.id),
          );
          final response = await dio.post<Map<String, dynamic>>(
            'https://api-hrgux4jeyq-uc.a.run.app/search-user',
            options: Options(
              headers: {
                'Authorization': 'Bearer $accessToken',
              },
              contentType: 'application/json',
            ),
            data: <String, dynamic>{
              'uids': uids,
            },
          );

          if (response.statusCode == 200) {
            final users = response.data!['users'] as List<dynamic>;

            return List<UserEntity>.from(
              docs.map((document) {
                final authUser = users.firstWhere(
                  (e) => e['uid'] == document.id,
                );

                final json = <String, dynamic>{
                  'data': authUser as Map<String, dynamic>,
                  ...document.data(),
                };

                return UserEntity.fromJson(json);
              }),
            );
          }
        }

        return <UserEntity>[];
      },
    );
  }

  static Future<bool> availableUsername(String username) async {
    final coincidences = await users
        .where(
          'username',
          isEqualTo: username,
        )
        .get();
    return coincidences.docs.isEmpty;
  }

  static Future<List<UserEntity>> search(String searchQuery) async {
    final accessToken = await FirebaseAuth.instance.currentUser!.getIdToken();

    final snapshots = await users
        .orderBy('username')
        .startAt([searchQuery]).endAt(['$searchQuery\uf8ff']).get();

    final response = await dio.post<Map<String, dynamic>>(
      'https://api-hrgux4jeyq-uc.a.run.app/search-user',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
        contentType: 'application/json',
      ),
      data: <String, dynamic>{
        'uids': List<String>.from(
          snapshots.docs
              .where((element) => element.id != auth.currentUser!.uid)
              .map((doc) => doc.id),
        ),
      },
    );

    if (response.statusCode == 200) {
      return List<UserEntity>.from(
        snapshots.docs
            .where((element) => element.id != auth.currentUser!.uid)
            .map(
          (DocumentSnapshot<Map<String, dynamic>> document) {
            final data = (response.data!['users'] as List<dynamic>).firstWhere(
              (e) => e['uid'] == document.id,
            );
            final json = <String, dynamic>{
              'data': data as Map<String, dynamic>,
              ...document.data()!,
            };
            return UserEntity.fromJson(json);
          },
        ),
      );
    }

    return [];
  }
}

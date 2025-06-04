import 'package:basetime/core/firebase/handle_errors.dart';
import 'package:basetime/core/firebase/repository.dart';
import 'package:basetime/core/utils/dynamic_to_entity.dart';
import 'package:basetime/features/auth/custom_user.dart';
import 'package:basetime/features/auth/user_entity.dart';
import 'package:basetime/features/categories/category_entity.dart';
import 'package:basetime/features/wallet/wallet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository extends FirebaseRepository {
  Stream<UserEntity?> stream() {
    return auth.authStateChanges().asyncMap(
      (user) async {
        if (user == null) {
          return null;
        }
        final userDocument = await firestore
            .collection(
              'users',
            )
            .doc(user.uid)
            .get();

        if (!userDocument.exists) {
          return null;
        }

        final data = userDocument.data()!;

        return UserEntity(
          data: CustomUser.fromUser(user),
          username: data['username'] as String,
          firstName: data['firstName'] as String,
          lastName: data['lastName'] as String,
          id: data['id'] as num,
          promoterId: data['promoterId'] as num?,
          instagram: data['instagram'] as String?,
          tiktok: data['tiktok'] as String?,
          categories:
              data.containsKey('categories') && data['categories'] != null
                  ? List<CategoryEntity>.from(
                      dynamicToMap(data['categories']).map(
                        CategoryEntity.fromJson,
                      ),
                    )
                  : null,
          subCategories:
              data.containsKey('subCategories') && data['subCategories'] != null
                  ? List<CategoryEntity>.from(
                      dynamicToMap(data['subCategories']).map(
                        CategoryEntity.fromJson,
                      ),
                    )
                  : null,
        );
      },
    );
  }

  Future<Either<FirebaseError, UserCredential>> signInAnonymously() async {
    try {
      final UserCredential userCredential = await auth.signInAnonymously();
      return Right(userCredential);
    } on FirebaseAuthException catch (error) {
      return left(
        FirebaseError(
          code: error.code,
          message: error.message,
        ),
      );
    }
  }

  Future<Either<FirebaseError, UserCredential>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(userCredential);
    } on FirebaseAuthException catch (error) {
      return left(
        FirebaseError(
          code: error.code,
          message: error.message,
        ),
      );
    }
  }

  /// Sign up
  Future<void> signUp({
    required String firstname,
    required String lastname,
    required String email,
    required int id,
    required String password,
    int? promoterId,
  }) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (UserCredential credential) async {
          if (credential.user != null) {
            final username = 'user${DateTime.now().microsecondsSinceEpoch}';
            await credential.user!.updateDisplayName('$firstname $lastname');
            await FirebaseFirestore.instance
                .collection('users')
                .doc(credential.user!.uid)
                .set({
              'firstName': firstname,
              'lastName': lastname,
              'username': username,
              'email': email,
              'id': id,
              'instagram': null,
              'tiktok': null,
              'promoterId': promoterId,
            });
            await Wallet.init(credential.user!.uid);
          }
          return credential;
        },
      );
      return Future.value();
    } on FirebaseAuthException catch (error) {
      return Future.error(error);
    }
  }

  Future<void> addCategories(
    List<CategoryEntity> categories,
    List<CategoryEntity> subCategories,
  ) async {
    final currentUser = auth.currentUser;

    if (currentUser == null) {
      return;
    }

    final json = {
      'categories': FieldValue.arrayUnion(
        categories
            .map(
              (e) => e.toJson(),
            )
            .toList(),
      ),
    };

    if (subCategories.isNotEmpty) {
      json['subCategories'] = FieldValue.arrayUnion(
        subCategories.map(
          (e) {
            return {
              ...e.toJson(),
              'parent': e.parent!.toJson(),
            };
          },
        ).toList(),
      );
    }

    await firestore.collection('users').doc(currentUser.uid).update(json);
  }

  /// Check unique ID
  Future<bool> uniqueID(
    int id, {
    int? compareID,
  }) async {
    try {
      final snapshots = await firestore
          .collection(
            'users',
          )
          .where('id', isEqualTo: id)
          .get();
      if (compareID != null) {
        return snapshots.docs
            .where((item) => item.data()['id'] != compareID)
            .isEmpty;
      }
      return snapshots.docs.isEmpty;
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    }
  }
}

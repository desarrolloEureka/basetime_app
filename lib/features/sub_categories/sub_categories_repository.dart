import 'package:basetime/core/firebase/repository.dart';
import 'package:basetime/features/categories/category_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubCategoriesRepository extends FirebaseRepository {
  Future<List<CategoryEntity>> fetch(List<CategoryEntity> categories) async {
    try {
      final snapshot = await firestore
          .collection('subCategories')
          .where(
            'parent.id',
            whereIn: categories.map((e) => e.id).toList(),
          )
          .get();
      return List<CategoryEntity>.from(
        snapshot.docs.map(
          (e) => CategoryEntity.fromJson(
            {
              ...e.data(),
              'id': e.id,
            },
          ),
      ),
      );
    } on FirebaseException catch (e) {
      throw Exception('${e.code}: ${e.message}');
    } catch (e) {
      throw Exception(e);
    }
  }
}

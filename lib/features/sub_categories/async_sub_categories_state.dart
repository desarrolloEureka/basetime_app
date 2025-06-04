import 'package:basetime/features/categories/category_entity.dart';
import 'package:basetime/features/sub_categories/sub_categories_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_sub_categories_state.g.dart';

@riverpod
class AsyncSubCategoriesState extends _$AsyncSubCategoriesState {
  final repository = SubCategoriesRepository();
  @override
  FutureOr<List<CategoryEntity>> build(List<CategoryEntity> categories) async {
    return repository.fetch(categories);
  }
}

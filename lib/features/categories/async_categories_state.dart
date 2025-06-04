import 'package:basetime/features/categories/categories_repository.dart';
import 'package:basetime/features/categories/category_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_categories_state.g.dart';

@riverpod
class AsyncCategoriesState extends _$AsyncCategoriesState {
  final repository = CategoriesRepository();
  @override
  FutureOr<List<CategoryEntity>> build() {
    return repository.fetch();
  }
}

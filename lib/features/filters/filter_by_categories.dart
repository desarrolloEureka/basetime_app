import 'package:basetime/features/categories/category_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_by_categories.g.dart';

@riverpod
class FilterByCategories extends _$FilterByCategories {
  @override
  List<CategoryEntity> build() {
    return <CategoryEntity>[];
  }

  // ignore: use_setters_to_change_properties
  void change(List<CategoryEntity> value) {
    state = value;
  }

  void add(CategoryEntity category) {
    state.add(category);
  }

  void remove(CategoryEntity category) {
    final newList = state.where((e) => e.id != category.id).toList();
    state = newList;
  }

  void clean() {
    state = <CategoryEntity>[];
  }
}

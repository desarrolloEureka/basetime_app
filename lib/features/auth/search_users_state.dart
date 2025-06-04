import 'package:basetime/features/auth/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_users_state.g.dart';

@riverpod
class SearchState extends _$SearchState {
  @override
  Future<List<UserEntity>> build() {
    return UserEntity.search('');
  }

  Future<void> search(String searchQuery) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return UserEntity.search(searchQuery);
    });
  }
}

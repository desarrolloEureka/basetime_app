import 'package:basetime/features/auth/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stream_users_state.g.dart';

@riverpod
Stream<List<UserEntity>> streamUsers(Ref ref) {
  return UserEntity.stream();
}

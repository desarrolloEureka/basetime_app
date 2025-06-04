import 'package:basetime/features/auth/auth_repository.dart';
import 'package:basetime/features/auth/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_changes_state.g.dart';

@riverpod
Stream<UserEntity?> authChangesState(AuthChangesStateRef ref) {
  final repository = AuthRepository();
  return repository.stream();
}

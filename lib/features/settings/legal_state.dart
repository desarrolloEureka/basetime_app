import 'package:basetime/features/settings/legal.dart';
import 'package:basetime/features/settings/legal_reposiory.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'legal_state.g.dart';

@riverpod
class LegalState extends _$LegalState {
  final repository = LegalReposiory();

  @override
  FutureOr<Legal> build() {
    return repository.fetch();
  }
}

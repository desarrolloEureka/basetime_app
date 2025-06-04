import 'package:basetime/features/skills/skill_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saved_state.g.dart';

@riverpod
class SavedState extends _$SavedState {
  @override
  FutureOr<List<Skill>> build() {
    return Skill.getSaved();
  }
}

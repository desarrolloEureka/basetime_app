import 'package:basetime/features/skills/skill_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stream_skill_state.g.dart';

@riverpod
Stream<List<Skill>> streamSkills(Ref ref, String userID) {
  return Skill.streamSkills(userID);
}

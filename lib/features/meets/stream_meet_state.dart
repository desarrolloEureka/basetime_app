import 'package:basetime/features/meets/meet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stream_meet_state.g.dart';

@riverpod
Stream<Meet?> streamMeetState(Ref ref, String id, {bool allStatus = false}) {
  return Meet.stream(id, allStatus: allStatus);
}

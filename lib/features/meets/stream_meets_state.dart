import 'package:basetime/features/matches/match.dart';
import 'package:basetime/features/meets/meet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stream_meets_state.g.dart';

@riverpod
Future<List<Meet>> getMyMeets(Ref ref) async {
  final matches = await MatchModel.getMyMatches();
  final meets = <Meet>[];

  for (final match in matches) {
    final meet = await Meet.getMeetbyMatchId(match.id);
    if (meet != null) {
      meets.add(meet);
    }
  }

  return meets;
}

import 'package:basetime/features/matches/match.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_my_matches_state.g.dart';

@riverpod
Stream<List<MatchModel>> streamMyMatches(Ref ref) {
  return MatchModel.streamMyMatches();
}

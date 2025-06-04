import 'package:basetime/features/settings/commissions.dart';
import 'package:basetime/features/settings/commissions_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'commissions_state.g.dart';

@riverpod
class CommissionsState extends _$CommissionsState {
  final repository = CommissionsRepository();
  @override
  FutureOr<Commissions> build() async {
    return repository.fetch();
  }
}

import 'package:basetime/features/verification/verification_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'verification_state.g.dart';

@riverpod
Stream<VerificationRequest?> verificationState(Ref ref) {
  return VerificationRequest.stream();
}

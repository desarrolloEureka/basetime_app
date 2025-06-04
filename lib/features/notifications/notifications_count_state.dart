import 'package:basetime/features/notifications/notification_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications_count_state.g.dart';

@riverpod
Stream<int> streamNewsCount(Ref ref) {
  return NotificationEntity.streamNewsCount();
}

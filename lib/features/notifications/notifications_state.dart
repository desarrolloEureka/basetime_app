import 'package:basetime/features/notifications/notification_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications_state.g.dart';

@riverpod
Stream<List<NotificationEntity>> streamNotifications(Ref ref) {
  return NotificationEntity.stream();
}

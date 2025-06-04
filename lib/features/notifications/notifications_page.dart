import 'dart:developer';

import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/notifications/notifications_state.dart';
import 'package:basetime/widgets/loader.dart';
import 'package:basetime/widgets/show_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

/// Notifications Page
class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  static String name = 'notifications';
  static String path = '/notifications';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context, ref),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: context.pop,
        icon: const Icon(Icons.arrow_circle_left_outlined),
      ),
      title: Text(
        context.lang!.notifications,
        style: GoogleFonts.ubuntu(
          color: Colors.red,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _body(BuildContext context, WidgetRef ref) {
    final streamNotifications = ref.watch(streamNotificationsProvider);
    return streamNotifications.when(
      data: (notifications) {
        if (notifications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: FaIcon(
                    FontAwesomeIcons.folderOpen,
                    size: 64,
                    color: Colors.white,
                  ),
                ),
                Text(
                  context.lang?.youHaveNoNotifications ??
                      '{{youHaveNoNotifications}}',
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            final notification = notifications[index];
            return ListTile(
              onTap: () {
                // context.push(const NotificationDetailsPage());
              },
              leading: SizedBox(
                width: 64,
                height: 64,
                child: CircleAvatar(
                  foregroundImage: NetworkImage(
                    notification.image,
                  ),
                ),
              ),
              title: notification.title != null
                  ? Text(
                      notification.title!,
                      style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : null,
              subtitle: Text(
                notification.content,
                style: GoogleFonts.ubuntu(
                  color: Colors.white,
                ),
              ),
              trailing: Wrap(
                children: [
                  IconButton(
                    onPressed: () async {
                      final result = await context.showConfirm<bool>(
                        content: '¿Borrar Notificación?',
                        onConfirm: () => context.pop(true),
                      );

                      if (result ?? false) {
                        await notification.destroy();
                      }
                    },
                    icon: const Icon(Icons.delete_forever_rounded),
                    color: Colors.red,
                  ),
                  Checkbox(
                    value: notification.read,
                    onChanged: (value) async {},
                    activeColor: Colors.yellow,
                    checkColor: Theme.of(context).colorScheme.surface,
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: notifications.length,
        );
      },
      error: (Object error, StackTrace stackTrace) {
        log('notifications error', error: error, stackTrace: stackTrace);
        return ShowError(
          error: error,
          stackTrace: stackTrace,
        );
      },
      loading: () => const Loader(),
    );
  }
}

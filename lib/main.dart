import 'package:basetime/core/routes/router.dart';
import 'package:basetime/firebase_options.dart';
import 'package:basetime/l10n/locale_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.onMessage.listen((message) {});
  FirebaseMessaging.onMessageOpenedApp.listen((message) {});

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  final _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _setupPushNotifications();
  }

  Future<void> _setupPushNotifications() async {
    final settings = await _firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Suscribers
      await _firebaseMessaging.subscribeToTopic('notifications');

      // Primer plano
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null && context.mounted) {
          final ctx = context;
          _showNotificationBanner(
            ctx,
            title: message.notification?.title ?? 'Nueva notificación',
            message: message.notification?.body ?? 'Tienes un nuevo mensaje',
          );
        }
      });
    }
  }

  void _showNotificationBanner(BuildContext context,
      {required String title, required String message}) {
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: NotificationBanner(title: title, message: message),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry?.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeStateProvider);

    const ColorScheme colorScheme = ColorScheme(
      primary: Colors.red,
      onPrimary: Colors.white,
      secondary: Color(0xFFFF4747),
      onSecondary: Colors.white,
      surface: Color(0xFF232323),
      onSurface: Colors.white,
      brightness: Brightness.light,
      error: Colors.red,
      onError: Colors.white,
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      title: 'BaseTime',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        textTheme: GoogleFonts.getTextTheme(
          'Ubuntu',
        ).apply(bodyColor: Colors.white),
        sliderTheme: const SliderThemeData(
          activeTrackColor: Colors.red,
          inactiveTrackColor: Colors.white12,
          thumbColor: Colors.white,
        ),
        primaryTextTheme: GoogleFonts.getTextTheme('Ubuntu'),
      ),
    );
  }
}

class NotificationBanner extends StatelessWidget {
  const NotificationBanner({
    super.key,
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

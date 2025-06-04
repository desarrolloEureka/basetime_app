import 'dart:async';

import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/auth/auth_changes_state.dart';
import 'package:basetime/features/auth/user_entity.dart';
import 'package:basetime/features/categories/async_categories_state.dart';
import 'package:basetime/features/categories/category_entity.dart';
import 'package:basetime/features/feed/feed_page.dart';
import 'package:basetime/features/filters/filters_modal.dart';
import 'package:basetime/features/home/index_page_state.dart';
import 'package:basetime/features/matches/matches_page.dart';
import 'package:basetime/features/notifications/notifications_count_state.dart';
import 'package:basetime/features/notifications/notifications_page.dart';
import 'package:basetime/features/saved/saved_page.dart';
import 'package:basetime/features/search_users/search_users_page.dart';
import 'package:basetime/features/sub_categories/sub_categories_page.dart';
import 'package:basetime/widgets/drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  static String name = 'home';
  static String path = '/$name';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<CategoryEntity> selectedCategories = [];

  late StreamSubscription<Position> _streamPosition;

  final _auth = FirebaseAuth.instance;
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final pages = [
    Container(),
    const MatchesPage(),
    const FeedPage(),
    const SavedPage(),
    const SearchUsersPage(),
  ];

  @override
  void initState() {
    super.initState();
    _saveFCMToken();
    _requestLocationPermissions();
    _streamPosition = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 15,
      ),
    ).listen((Position position) {
      final user = _auth.currentUser!;
      users.doc(user.uid).update({
        'location': GeoPoint(position.latitude, position.longitude),
        'updateAt': Timestamp.now(),
      });
    });
  }

  @override
  void dispose() {
    _streamPosition.cancel();
    super.dispose();
  }

  Future<void> _saveFCMToken() async {
    final settings = await _firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final String? token = await _firebaseMessaging.getToken();

      // Suscribe
      await _firebaseMessaging.subscribeToTopic('users');

      // save fcm token
      await users.doc(_auth.currentUser!.uid).update({
        'fcm': token,
      });
    }
  }

  Future<void> _requestLocationPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.unableToDetermine ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        if (context.mounted) {
          final ctx = context;
          await showDialog<void>(
            context: ctx,
            builder: (context) {
              return AlertDialog(
                title: Text(context.lang!.requiredLocation),
                content: Text(context.lang!.locationDeniedForever),
                actions: [
                  TextButton(
                    onPressed: openAppSettings,
                    child: Text(context.lang!.openSettings),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final indexPage = ref.watch(indexPageProvider);
    final indexPageNotifier = ref.read(indexPageProvider.notifier);
    final authChanges = ref.watch(authChangesStateProvider);
    final asyncCategories = ref.watch(asyncCategoriesStateProvider);
    final streamNewsCountState = ref.watch(streamNewsCountProvider);

    if (!authChanges.isLoading && authChanges.value != null) {
      if ((authChanges.value!.categories ?? []).isEmpty) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Text(
                    context.lang!.aboutYourself,
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    context.lang!.selectCategoryDescription,
                    style: GoogleFonts.ubuntu(
                      color: Colors.white60,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: asyncCategories.when(
                        data: (categories) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, // number of items in each row
                              mainAxisSpacing: 16, // spacing between rows
                              crossAxisSpacing: 16, // spacing between columns
                            ),
                            padding: const EdgeInsets.all(8),
                            itemCount: categories.length,
                            itemBuilder: (BuildContext context, int index) {
                              final category = categories[index];
                              final icon = IconData(
                                category.icon,
                                fontFamily: 'MaterialIcons',
                              );
                              return MaterialButton(
                                color: selectedCategories.contains(category)
                                    ? Colors.red
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(200),
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (selectedCategories.contains(category)) {
                                      selectedCategories.remove(category);
                                    } else {
                                      selectedCategories.add(category);
                                    }
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      context.lang!.localeName == 'en'
                                          ? category.nameEn
                                          : category.nameEs,
                                      style: GoogleFonts.ubuntu(
                                        color: selectedCategories
                                                .contains(category)
                                            ? Colors.white
                                            : Colors.red,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(
                                        icon,
                                        color: selectedCategories.contains(
                                          category,
                                        )
                                            ? Colors.white
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        error: (error, stackTrace) {
                          return Text('$error: $stackTrace');
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: FilledButton(
                  onPressed: selectedCategories.isEmpty
                      ? null
                      : () {
                          context.push(
                            SubCategoriesPage.path,
                            extra: selectedCategories,
                          );
                        },
                  child: Text(context.lang!.next),
                ),
              ),
            ],
          ),
        );
      }
    }

    return Stack(
      children: [
        Image.asset(
          'assets/sign-in-bg.png',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: indexPage != 1 && indexPage != 3
              ? AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Theme.of(context).colorScheme.surface,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    icon: const Icon(Icons.menu_rounded),
                  ),
                  actions: [
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Theme.of(context).colorScheme.surface,
                      ),
                      onPressed: () {
                        context.push(NotificationsPage.path);
                      },
                      icon: Badge(
                        isLabelVisible: (streamNewsCountState.value ?? 0) > 0,
                        padding: const EdgeInsets.all(2),
                        label: Text(
                          streamNewsCountState.value?.toString() ?? '0',
                          style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        child: const Icon(Icons.notifications_rounded),
                      ),
                    ),
                  ],
                )
              : null,
          drawer: indexPage != 1 && indexPage != 3
              ? DrawerBT(
                  onClose: () {
                    _scaffoldKey.currentState!.closeDrawer();
                  },
                )
              : null,
          body: pages[indexPage],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: indexPage,
            backgroundColor: indexPage == 1 || indexPage == 3
                ? Theme.of(context).colorScheme.surface
                : Colors.transparent,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: (int index) {
              if (index == 0) {
                _scaffoldKey.currentState!.showBottomSheet(
                  (context) => const FiltersModal(),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  elevation: 15,
                  constraints: BoxConstraints.tight(
                    Size(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height - 88,
                    ),
                  ),
                );
                indexPageNotifier.setIndex(2);
              } else {
                indexPageNotifier.setIndex(index);
              }
            },
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                backgroundColor: indexPage == 1 || indexPage == 3
                    ? Theme.of(context).colorScheme.surface
                    : Colors.transparent,
                activeIcon: SvgPicture.asset(
                  'assets/icons/filter.svg',
                  height: 28,
                  colorFilter: const ColorFilter.mode(
                    Colors.red,
                    BlendMode.srcIn,
                  ),
                ),
                icon: SvgPicture.asset(
                  'assets/icons/filter.svg',
                  height: 28,
                ),
                label: context.lang!.filters,
              ),
              BottomNavigationBarItem(
                backgroundColor: indexPage == 1 || indexPage == 3
                    ? Theme.of(context).colorScheme.surface
                    : Colors.transparent,
                activeIcon: SvgPicture.asset(
                  'assets/icons/match.svg',
                  height: 28,
                  colorFilter: const ColorFilter.mode(
                    Colors.red,
                    BlendMode.srcIn,
                  ),
                ),
                icon: SvgPicture.asset(
                  'assets/icons/match.svg',
                  height: 28,
                ),
                label: context.lang!.matches,
              ),
              BottomNavigationBarItem(
                backgroundColor: indexPage == 1 || indexPage == 3
                    ? Theme.of(context).colorScheme.surface
                    : Colors.transparent,
                activeIcon: Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    'assets/icons/rokect.svg',
                    height: 28,
                  ),
                ),
                icon: Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    'assets/icons/rokect.svg',
                    height: 28,
                    colorFilter: const ColorFilter.mode(
                      Colors.red,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                label: context.lang!.home,
              ),
              BottomNavigationBarItem(
                backgroundColor: indexPage == 1 || indexPage == 3
                    ? Theme.of(context).colorScheme.surface
                    : Colors.transparent,
                activeIcon: SvgPicture.asset(
                  'assets/icons/favorites.svg',
                  height: 28,
                  colorFilter: const ColorFilter.mode(
                    Colors.red,
                    BlendMode.srcIn,
                  ),
                ),
                icon: SvgPicture.asset(
                  'assets/icons/favorites.svg',
                  height: 28,
                ),
                label: context.lang!.favorites,
              ),
              BottomNavigationBarItem(
                backgroundColor: indexPage == 1 || indexPage == 3
                    ? Theme.of(context).colorScheme.surface
                    : Colors.transparent,
                activeIcon: SvgPicture.asset(
                  'assets/icons/search.svg',
                  height: 28,
                  colorFilter: const ColorFilter.mode(
                    Colors.red,
                    BlendMode.srcIn,
                  ),
                ),
                icon: SvgPicture.asset(
                  'assets/icons/search.svg',
                  height: 28,
                ),
                label: context.lang!.search,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

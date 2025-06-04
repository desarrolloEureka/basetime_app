import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/auth/auth_changes_state.dart';
import 'package:basetime/features/auth/auth_page.dart';
import 'package:basetime/features/categories/async_categories_state.dart';
import 'package:basetime/features/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  static String name = 'Welcome';
  static String path = '/';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  final _pageController = PageController();

  final List<Map<String, String>> texts = [
    {
      'title': 'Contecta',
      'description':
          'Con profesionales y expertos en todas tus areas de interes',
    },
    {
      'title': 'Monetiza',
      'description': 'Gana dinero mientras haces lo que más te gusta',
    },
    {
      'title': 'Aprende',
      'description': 'Desde las pasiones de los demás',
    }
  ];

  @override
  Widget build(BuildContext context) {
    final authChanges = ref.watch(authChangesStateProvider);
    final asyncCategoriesState = ref.watch(asyncCategoriesStateProvider);
    return authChanges.when(
      data: (user) {
        if (user != null) {
          return const HomePage();
        }
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: List<Widget>.generate(3, (index) {
                    return Stack(
                      children: [
                        Image.asset(
                          'assets/onboarding-bg-${index + 1}.png',
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.cover,
                        ),
                        Scaffold(
                          backgroundColor: Colors.transparent,
                          appBar: AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            scrolledUnderElevation: 0,
                            actions: [
                              TextButton(
                                onPressed: () {
                                  context.replaceNamed(AuthPage.name);
                                },
                                child: Text(
                                  context.lang?.skip ?? 'Skip',
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 20,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          body: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (index == 2)
                                asyncCategoriesState.when(
                                  data: (categories) {
                                    return Stack(
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              267,
                                        ),
                                        Positioned(
                                          top: 16,
                                          right: 16,
                                          child: Container(
                                            width: 86,
                                            height: 86,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(200),
                                            ),
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    context.lang!.localeName ==
                                                            'en'
                                                        ? categories
                                                            .first.nameEn
                                                        : categories
                                                            .first.nameEs,
                                                    style: GoogleFonts.ubuntu(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Icon(
                                                      IconData(
                                                        categories.first.icon,
                                                        fontFamily:
                                                            'MaterialIcons',
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 120,
                                          left: 32,
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(200),
                                            ),
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    context.lang!.localeName ==
                                                            'en'
                                                        ? categories[1].nameEn
                                                        : categories[1].nameEs,
                                                    style: GoogleFonts.ubuntu(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Icon(
                                                      IconData(
                                                        categories[1].icon,
                                                        fontFamily:
                                                            'MaterialIcons',
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 16,
                                          left: 16,
                                          child: Container(
                                            width: 120,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(200),
                                            ),
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    context.lang!.localeName ==
                                                            'en'
                                                        ? categories.last.nameEn
                                                        : categories
                                                            .last.nameEs,
                                                    style: GoogleFonts.ubuntu(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Icon(
                                                      IconData(
                                                        categories.last.icon,
                                                        fontFamily:
                                                            'MaterialIcons',
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  error: (error, stackTrace) {
                                    return Text('$error: $stackTrace');
                                  },
                                  loading: Container.new,
                                ),
                              Container(
                                width: MediaQuery.of(context).size.width - 16,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black87,
                                      Colors.transparent,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                  border: const Border(
                                    top: BorderSide(
                                      color: Colors.white,
                                    ),
                                    left: BorderSide(
                                      color: Colors.white,
                                    ),
                                    right: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                margin: const EdgeInsets.all(16),
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            context.onboardingTitle(index),
                                            style: GoogleFonts.ubuntu(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            context
                                                .onboardingDescriptions(index),
                                            style: GoogleFonts.ubuntu(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    FilledButton(
                                      onPressed: () {
                                        if (index < 2) {
                                          _pageController.animateToPage(
                                            index + 1,
                                            duration: const Duration(
                                              milliseconds: 500,
                                            ),
                                            curve: Curves.easeInOut,
                                          );
                                          return;
                                        }
                                        context.replaceNamed(AuthPage.name);
                                      },
                                      child: Text(context.lang!.next),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return Text('$error: $stackTrace');
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

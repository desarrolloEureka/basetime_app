import 'dart:developer';

import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/auth/auth_changes_state.dart';
import 'package:basetime/features/skills/add_skill_form.dart';
import 'package:basetime/features/skills/edit_skill_form.dart';
import 'package:basetime/features/skills/stream_skill_state.dart';
import 'package:basetime/widgets/loader.dart';
import 'package:basetime/widgets/show_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

/// Skills Page
class SkillsPage extends ConsumerStatefulWidget {
  const SkillsPage({super.key});

  static String name = 'skills';
  static String path = '/skills';

  @override
  ConsumerState createState() => _SkillsPageState();
}

class _SkillsPageState extends ConsumerState<SkillsPage> {
  /// Controller
  final pageController = PageController();

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(authChangesStateProvider);
    final user = userState.value;

    if (user == null) {
      return Container();
    }

    final streamSkills = ref.watch(
      streamSkillsProvider(user.data.uid),
    );

    return streamSkills.when(
      data: (skills) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: context.pop,
              icon: const Icon(Icons.arrow_circle_left_outlined),
            ),
            title: Text(
              context.lang!.completeProfile,
              style: GoogleFonts.ubuntu(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: skills.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.sentiment_dissatisfied,
                        size: 64,
                        color: Colors.white,
                      ),
                      Text(
                        context.lang!.emptyTokens,
                        style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                )
              : PageView.builder(
                  controller: pageController,
                  itemCount: skills.length,
                  itemBuilder: (context, index) {
                    final skill = skills[index];
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned.fill(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: const GradientBoxBorder(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white,
                                    Colors.white38,
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white54,
                                  Colors.white38,
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          left: 0,
                          right: 0,
                          bottom: 16,
                          child: Column(
                            children: [
                              /// Price per hour
                              Text(
                                context.lang!.dollarsXHour(
                                  skill.pricePerHour,
                                ),
                                style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                ),
                              ),

                              /// Display name
                              Text(
                                user.data.displayName ?? '',
                                style: GoogleFonts.ubuntu(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 16),

                              /// Image
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    skill.imageURL,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.35,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              /// dots
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  skills.length,
                                  (index2) {
                                    return AnimatedContainer(
                                      width: 8,
                                      height: 8,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      decoration: BoxDecoration(
                                        color: index2 == index
                                            ? Colors.red
                                            : Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    );
                                  },
                                ),
                              ),

                              /// Show title
                              Container(
                                width: MediaQuery.of(context).size.width - 48,
                                margin: const EdgeInsets.only(top: 16),
                                child: Text(
                                  skill.title,
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),

                              /// Show description
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth:
                                      MediaQuery.of(context).size.width - 48,
                                  maxWidth:
                                      MediaQuery.of(context).size.width - 48,
                                  minHeight: 16,
                                  maxHeight: 74,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context.lang!.description,
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      skill.description ?? '',
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.white70,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),

                              /// Show categories
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 48,
                                height: 16,
                                child: Wrap(
                                  children: List<Widget>.from(
                                    skill.categories.map(
                                      (e) {
                                        return Icon(
                                          IconData(
                                            e.icon,
                                            fontFamily: 'MaterialIcons',
                                          ),
                                          color: Colors.red.shade900,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              /// Social Networks
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 48,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (userState.value?.instagram != null)
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 8,
                                        ),
                                        child: Row(
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.instagram,
                                              color: Colors.red.shade900,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '@${userState.value?.instagram ?? ''}',
                                              style: GoogleFonts.ubuntu(
                                                color: Colors.red.shade900,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (userState.value?.tiktok != null)
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 8,
                                        ),
                                        child: Row(
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.tiktok,
                                              color: Colors.red.shade900,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '@${userState.value?.tiktok ?? ''}',
                                              style: GoogleFonts.ubuntu(
                                                color: Colors.red.shade900,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),

                              /// Iteractions
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 48,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      spacing: 4,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.bookmark_rounded,
                                          color: Colors.red.shade900,
                                          size: 32,
                                        ),
                                        Text(
                                          skill.saved.length.toString(),
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      spacing: 4,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.favorite_rounded,
                                          color: Colors.red.shade900,
                                          size: 32,
                                        ),
                                        Text(
                                          skill.favorites.length.toString(),
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      spacing: 4,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/match.svg',
                                          width: 32,
                                          height: 32,
                                          colorFilter: ColorFilter.mode(
                                            Colors.red.shade900,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        Text(
                                          skill.favorites.length.toString(),
                                        ),
                                      ],
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
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: skills.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.red,
                        minimumSize: const Size(140, 34),
                      ),
                      onPressed: () {
                        final editToken =
                            skills[pageController.page?.toInt() ?? 0];
                        context.push(
                          EditSkillForm.path,
                          extra: editToken,
                        );
                      },
                      child: Text(context.lang!.editToken),
                    ),
                  ),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    minimumSize: const Size(140, 34),
                  ),
                  onPressed: () {
                    context.push(AddSkillForm.path);
                  },
                  child: Text(context.lang!.addToken),
                ),
              ],
            ),
          ),
        );
      },
      error: (Object error, StackTrace stackTrace) {
        log(
          'error: $error',
          error: error,
          stackTrace: stackTrace,
        );
        return ShowError(
          error: error,
          stackTrace: stackTrace,
        );
      },
      loading: () => const Loader(),
    );
  }
}

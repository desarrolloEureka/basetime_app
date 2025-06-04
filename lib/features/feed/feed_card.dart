import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/auth/auth_changes_state.dart';
import 'package:basetime/features/chats/chat_page.dart';
import 'package:basetime/features/feed/feed_content.dart';
import 'package:basetime/features/matches/match.dart';
import 'package:basetime/widgets/match_select.dart';
import 'package:basetime/widgets/rate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedCard extends ConsumerStatefulWidget {
  const FeedCard({
    super.key,
    required this.feed,
    required this.position,
    this.machesServices,
  });

  final FeedContent feed;
  final List<String>? machesServices;
  final Position position;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedCardState();
}

class _FeedCardState extends ConsumerState<FeedCard> {
  int value = 1;
  int currentIndex = 0;

  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentIndex = _pageController.page!.toInt();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String getKms(Position? position, GeoPoint? userGeoPoint) {
    if (position != null && userGeoPoint != null) {
      final double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        userGeoPoint.latitude,
        userGeoPoint.longitude,
      );
      return '${(distance / 1000).toStringAsFixed(1)}Km';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(authChangesStateProvider);
    final feed = widget.feed;

    return PageView.builder(
      controller: _pageController,
      itemCount: feed.skills.length + 1,
      itemBuilder: (context, index) {
        if (index == feed.skills.length) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                  border: const GradientBoxBorder(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white38,
                        Colors.white12,
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
              Positioned(
                top: 16,
                left: 32,
                right: 32,
                bottom: 16,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        feed.user.data.displayName ?? '',
                        style: GoogleFonts.ubuntu(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '@${feed.user.username}',
                        style: GoogleFonts.ubuntu(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            context.lang!.classifications,
                            style: GoogleFonts.ubuntu(
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.separated(
                          itemCount: feed.comments.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 8);
                          },
                          itemBuilder: (context, index) {
                            final comment = feed.comments[index];
                            return SizedBox(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 64,
                                    height: 64,
                                    child: comment.author.photoURL != null
                                        ? CircleAvatar(
                                            foregroundImage: NetworkImage(
                                              comment.author.photoURL!,
                                            ),
                                          )
                                        : Container(
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Center(
                                              child: Icon(Icons.person),
                                            ),
                                          ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        comment.content,
                                        style: GoogleFonts.ubuntu(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Rate(
                                            readOnly: true,
                                            value: comment.rate.toDouble(),
                                          ),
                                          const Text(' - '),
                                          Text(
                                            DateFormat(
                                              'dd/MM/yyyy',
                                            ).format(comment.createdAt),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        final skill = feed.skills[index];
        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
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
                    Colors.white38,
                    Colors.white12,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 0,
              right: 0,
              bottom: 16,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      feed.user.data.displayName ?? '',
                      style: GoogleFonts.ubuntu(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '@${feed.user.username} - ${context.lang!.dollarsXHour(
                        skill.pricePerHour,
                      )}',
                      style: GoogleFonts.ubuntu(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(getKms(widget.position, feed.user.location)),
                    const SizedBox(height: 8),
                    if (feed.skills.indexOf(skill) % 2 == 1)
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 64,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              skill.title,
                              style: GoogleFonts.ubuntu(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              context.lang!.description,
                              style: GoogleFonts.ubuntu(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              skill.description ?? '',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    if (feed.skills.indexOf(skill) % 2 == 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 8,
                        ),
                        child: Row(
                          children: List<Widget>.from(
                            skill.categories.map(
                              (category) {
                                return Icon(
                                  IconData(
                                    category.icon,
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  color: Colors.red.shade900,
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                    /// Social Networks
                    if (feed.skills.indexOf(skill) % 2 == 1)
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 48,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (feed.user.instagram != null)
                              FilledButton.icon(
                                style: FilledButton.styleFrom(
                                  minimumSize: const Size(16, 16),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                ),
                                onPressed: () async {
                                  await launchUrl(
                                    Uri.parse(
                                      'https://instagram.com/${feed.user.instagram}',
                                    ),
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.instagram,
                                  color: Colors.red.shade900,
                                  size: 24,
                                ),
                                label: Text(
                                  '@${feed.user.instagram ?? ''}',
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.red.shade900,
                                  ),
                                ),
                              ),
                            if (feed.user.tiktok != null)
                              FilledButton.icon(
                                style: FilledButton.styleFrom(
                                  minimumSize: const Size(16, 16),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                ),
                                onPressed: () async {
                                  await launchUrl(
                                    Uri.parse(
                                      'https://tiktok.com/${feed.user.tiktok}',
                                    ),
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.tiktok,
                                  color: Colors.red.shade900,
                                  size: 24,
                                ),
                                label: Text(
                                  '@${feed.user.tiktok ?? ''}',
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.red.shade900,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    if (feed.skills.indexOf(skill) % 2 == 1)
                      const SizedBox(height: 16),
                    Expanded(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: widget.machesServices != null &&
                                      widget.machesServices!.contains(skill.id)
                                  ? 24
                                  : 40,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                skill.imageURL,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    IconButton.filled(
                                      onPressed: skill.toggleSave,
                                      icon: Icon(
                                        skill.isSaved
                                            ? Icons.bookmark_rounded
                                            : Icons.bookmark_border,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton.filled(
                                      onPressed: skill.toggleLike,
                                      icon: Icon(
                                        skill.isFavorite
                                            ? Icons.favorite_rounded
                                            : Icons.favorite_border,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                if (widget.machesServices != null &&
                                    widget.machesServices!.contains(skill.id))
                                  FilledButton.icon(
                                    onPressed: () async {
                                      final match =
                                          await MatchModel.getMatch(skill);
                                      if (context.mounted) {
                                        await context.push(
                                          ChatPage.path,
                                          extra: match,
                                        );
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.chat_rounded,
                                      color: Colors.white,
                                    ),
                                    label: const Text('Chat'),
                                  ),
                                if (widget.machesServices != null &&
                                    !widget.machesServices!.contains(skill.id))
                                  MatchSelect(
                                    value: value,
                                    onChanged: (value) {
                                      setState(() {
                                        this.value = value;
                                      });
                                    },
                                    onSubmit: () async {
                                      final result =
                                          await context.showConfirm<bool>(
                                        content: context.lang!.confirmMatch(
                                          value,
                                          skill.pricePerHour * value,
                                        ),
                                        onCancel: context.pop,
                                        onConfirm: () => context.pop(true),
                                      );

                                      if (result ?? false) {
                                        if (userState.value != null) {
                                          final client = userState.value!;
                                          await MatchModel(
                                            id: '',
                                            client: chat.User(
                                              id: client.data.uid,
                                              firstName: client.firstName,
                                              lastName: client.lastName,
                                              imageUrl: client.data.photoURL,
                                            ),
                                            supplier: chat.User(
                                              id: feed.user.data.uid,
                                              firstName: feed.user.firstName,
                                              lastName: feed.user.lastName,
                                              imageUrl: feed.user.data.photoURL,
                                            ),
                                            status: MatchStatus.notPayed,
                                            createdAt: DateTime.now(),
                                            hours: value,
                                            service: skill,
                                          ).match();
                                        }
                                      }
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.from(
                        feed.skills.map(
                          (card) {
                            final index = feed.skills.indexOf(card);
                            return Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: index == currentIndex
                                    ? Colors.red.shade900
                                    : Colors.white38,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    if (feed.skills.indexOf(skill) % 2 == 0)
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 64,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              skill.title,
                              style: GoogleFonts.ubuntu(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              context.lang!.description,
                              style: GoogleFonts.ubuntu(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              skill.description ?? '',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    if (feed.skills.indexOf(skill) % 2 == 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 8,
                        ),
                        child: Row(
                          children: List<Widget>.from(
                            skill.categories.map(
                              (category) {
                                return Icon(
                                  IconData(
                                    category.icon,
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  color: Colors.red.shade900,
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                    /// Social Networks
                    if (feed.skills.indexOf(skill) % 2 == 0)
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 48,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (feed.user.instagram != null)
                              FilledButton.icon(
                                style: FilledButton.styleFrom(
                                  minimumSize: const Size(16, 16),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                ),
                                onPressed: () async {
                                  await launchUrl(
                                    Uri.parse(
                                      'https://instagram.com/${feed.user.instagram}',
                                    ),
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.instagram,
                                  color: Colors.red.shade900,
                                  size: 24,
                                ),
                                label: Text(
                                  '@${feed.user.instagram ?? ''}',
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.red.shade900,
                                  ),
                                ),
                              ),
                            if (feed.user.tiktok != null)
                              FilledButton.icon(
                                style: FilledButton.styleFrom(
                                  minimumSize: const Size(16, 16),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                ),
                                onPressed: () async {
                                  await launchUrl(
                                    Uri.parse(
                                      'https://tiktok.com/${feed.user.tiktok}',
                                    ),
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.tiktok,
                                  color: Colors.red.shade900,
                                  size: 24,
                                ),
                                label: Text(
                                  '@${feed.user.tiktok ?? ''}',
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.red.shade900,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    if (feed.skills.indexOf(skill) % 2 == 0)
                      const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/feed/feed_card.dart';
import 'package:basetime/features/feed/feed_content.dart';
import 'package:basetime/features/feed/stream_feeds_state.dart';
import 'package:basetime/features/filters/distance_state.dart';
import 'package:basetime/features/filters/filter_by_categories.dart';
import 'package:basetime/features/filters/global_search_state.dart';
import 'package:basetime/features/filters/price_state.dart';
import 'package:basetime/features/matches/get_my_matches_state.dart';
import 'package:basetime/widgets/loader.dart';
import 'package:basetime/widgets/show_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class FeedPage extends ConsumerStatefulWidget {
  const FeedPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  Position? _position;

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  Future<void> getCurrentPosition() async {
    final currentPosition = await Geolocator.getCurrentPosition();
    setState(() {
      _position = currentPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filters
    final globalSearch = ref.watch(globalSearchStateProvider);
    final distanceInKm = ref.watch(distanceStateProvider);
    final priceRange = ref.watch(priceRangeProvider);
    final streamFeeds = ref.watch(streamFeedsStateProvider);
    final streamMatches = ref.watch(streamMyMatchesProvider);
    final matches = streamMatches.value ?? [];
    final filterByCategories = ref.watch(filterByCategoriesProvider);
    return streamFeeds.when(
      data: (feeds) {
        if (_position == null) {
          return const Loader();
        }
        List<FeedContent> list = feeds;
        if (!globalSearch) {
          list = feeds.where((e) {
            if (e.user.location != null) {
              final distanceInMetters = Geolocator.distanceBetween(
                _position!.latitude,
                _position!.longitude,
                e.user.location!.latitude,
                e.user.location!.longitude,
              );

              final distanceInKilometters = distanceInMetters / 1000;
              return distanceInKilometters <= distanceInKm;
            }
            return false;
          }).toList();
        }

        final filterCostList = list.where(
          (e) {
            final mayorPrice = double.parse(
              (e.skills.reduce((a, b) {
                        return a.pricePerHour > b.pricePerHour ? a : b;
                      }).pricePerHour /
                      400000)
                  .toStringAsFixed(2),
            );

            return mayorPrice >= priceRange.start &&
                mayorPrice <= priceRange.end;
          },
        ).toList();

        final filterList = filterByCategories.isEmpty
            ? filterCostList
            : filterCostList.where((feed) {
                final skills = feed.skills.where((skill) {
                  final categories =
                      skill.categories.where(filterByCategories.contains);

                  return categories.isNotEmpty;
                });

                return skills.isNotEmpty;
              }).toList();

        if (filterList.isEmpty) {
          return Center(
            child: Text(context.lang!.emptyFeedMessage),
          );
        } else if (filterList.length == 1) {
          final feed = filterList.first;
          if (_position == null) {
            return Container();
          }
          return FeedCard(
            feed: feed,
            machesServices: matches.map((e) => e.service.id).toList(),
            position: _position!,
          );
        } else {
          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: filterList.length,
            itemBuilder: (context, index) {
              final feed = filterList[index];
              return FeedCard(
                feed: feed,
                machesServices: matches.map((e) => e.service.id).toList(),
                position: _position!,
              );
            },
          );
        }
      },
      error: (error, stackTrace) {
        return ShowError(
          error: error,
          stackTrace: stackTrace,
        );
      },
      loading: () => const Loader(),
    );
  }
}

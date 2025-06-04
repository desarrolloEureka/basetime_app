import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/categories/async_categories_state.dart';
import 'package:basetime/features/categories/category_entity.dart';
import 'package:basetime/features/feed/stream_feeds_state.dart';
import 'package:basetime/features/filters/distance_state.dart';
import 'package:basetime/features/filters/filter_by_categories.dart';
import 'package:basetime/features/filters/global_search_state.dart';
import 'package:basetime/features/filters/price_state.dart';
// import 'package:basetime/features/filters/price_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FiltersModal extends ConsumerStatefulWidget {
  const FiltersModal({super.key});

  @override
  ConsumerState createState() => _FiltersModalState();
}

class _FiltersModalState extends ConsumerState<FiltersModal> {
  bool globalSearch = false;
  int distance = 100;
  RangeValues priceRange = const RangeValues(0, 1);
  List<CategoryEntity> selectedCategories = [];
  List<CategoryEntity> subCategories = [];
  List<CategoryEntity> selectedSubCategories = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final globalSearchInit = ref.read(globalSearchStateProvider);
      final distanceInit = ref.read(distanceStateProvider);
      final priceRangeInit = ref.read(priceRangeProvider);
      final filterByCategoriesInit = ref.read(filterByCategoriesProvider);
      setState(() {
        globalSearch = globalSearchInit;
        distance = distanceInit;
        priceRange = priceRangeInit;
        selectedCategories = filterByCategoriesInit;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final globalSearchNotifier = ref.read(globalSearchStateProvider.notifier);
    final distanceNotifier = ref.read(distanceStateProvider.notifier);
    final priceRangeNotifier = ref.read(priceRangeProvider.notifier);
    final categories = ref.watch(asyncCategoriesStateProvider);
    final filterByCategoriesNotifier = ref.read(
      filterByCategoriesProvider.notifier,
    );
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(Icons.close_rounded),
          ),
          title: Text(context.lang!.filters),
          centerTitle: true,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(8),
            child: Divider(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                children: [
                  /// Geolocation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.lang!.geolocation,
                              style: GoogleFonts.ubuntu(
                                color: Colors.red[900],
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              context.lang!.geoDescription,
                              style: GoogleFonts.ubuntu(
                                fontSize: 12,
                                fontWeight: FontWeight.w100,
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Switch(
                            value: globalSearch,
                            onChanged: (_) {
                              setState(() {
                                globalSearch = !globalSearch;
                              });
                            },
                          ),
                          Text(context.lang!.globalSearch),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (!globalSearch)
                    Slider(
                      value: distance / 100,
                      divisions: 10,
                      label: '${distance}Km',
                      onChanged: (value) {
                        setState(() {
                          distance = (value * 100).toInt();
                        });
                      },
                    ),
                  if (!globalSearch)
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('0Km'),
                        Text('50Km'),
                        Text('100Km'),
                      ],
                    ),

                  /// Price range
                  const Divider(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.lang!.valueHour,
                              style: GoogleFonts.ubuntu(
                                color: Colors.red[900],
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              context.lang!.valueHourDescription,
                              style: GoogleFonts.ubuntu(
                                fontSize: 12,
                                fontWeight: FontWeight.w100,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  RangeSlider(
                    values: priceRange,
                    inactiveColor: Colors.white12,
                    divisions: 10,
                    labels: RangeLabels(
                      '${(priceRange.start * 400).toStringAsFixed(0)}k',
                      '${(priceRange.end * 400).toStringAsFixed(0)}k',
                    ),
                    onChanged: (value) {
                      setState(() {
                        priceRange = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(r'$0K'),
                      Text(r'$200K'),
                      Text(r'$400K'),
                    ],
                  ),

                  /// Categories
                  const Divider(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.lang!.categories,
                              style: GoogleFonts.ubuntu(
                                color: Colors.red[900],
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              context.lang!.categoriesDescription,
                              style: GoogleFonts.ubuntu(
                                fontSize: 12,
                                fontWeight: FontWeight.w100,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  categories.when(
                    data: (data) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Text(
                            context.lang!.categories,
                            style: GoogleFonts.ubuntu(
                              fontSize: 12,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          GridView.count(
                            crossAxisCount: 4,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            shrinkWrap: true,
                            childAspectRatio: 2.75,
                            children: List<Widget>.from(
                              data.map((e) {
                                return MaterialButton(
                                  onPressed: () => _toggleCategory(e),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  color: selectedCategories.contains(e)
                                      ? Colors.red
                                      : Colors.white,
                                  padding: EdgeInsets.zero,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    child: Center(
                                      child: Row(
                                        spacing: 4,
                                        children: [
                                          Icon(
                                            IconData(
                                              e.icon,
                                              fontFamily: 'MaterialIcons',
                                            ),
                                            size: 16,
                                            color:
                                                selectedCategories.contains(e)
                                                    ? Colors.white
                                                    : Colors.red,
                                          ),
                                          Expanded(
                                            child: Text(
                                              e.langName(context),
                                              style: TextStyle(
                                                fontSize: 9,
                                                color: selectedCategories
                                                        .contains(e)
                                                    ? Colors.white
                                                    : Colors.red,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FilledButton(
                                onPressed: () {
                                  setState(() {
                                    distance = 100;
                                    priceRange = const RangeValues(0, 1);
                                    selectedCategories.clear();
                                    subCategories.clear();
                                    selectedSubCategories.clear();
                                  });
                                  globalSearchNotifier.clean();
                                  distanceNotifier.clean();
                                  priceRangeNotifier.clean();
                                  filterByCategoriesNotifier.clean();
                                },
                                child: const Text('Limpiar filtros'),
                              ),
                              FilledButton(
                                onPressed: () async {
                                  globalSearchNotifier.change(globalSearch);
                                  distanceNotifier.change(distance);
                                  priceRangeNotifier.change(priceRange);
                                  filterByCategoriesNotifier.change(
                                    selectedCategories,
                                  );
                                  // ignore: unused_result
                                  ref.refresh(streamFeedsStateProvider);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Aplicar filtros'),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: () => const Text('Loading...'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> _toggleCategory(CategoryEntity category) async {
    final newList = selectedCategories;
    if (newList.contains(category)) {
      newList.remove(category);
    } else {
      newList.add(category);
    }

    setState(() {
      selectedCategories = newList;
    });
  }
}

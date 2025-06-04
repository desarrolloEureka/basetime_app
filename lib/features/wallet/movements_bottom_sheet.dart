import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/pay_movements/movement.dart';
import 'package:basetime/features/pay_movements/movement_details.dart';
import 'package:basetime/features/pay_movements/my_movements_state.dart';
import 'package:basetime/widgets/loader.dart';
import 'package:basetime/widgets/show_error.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MovementsBottomSheet extends ConsumerStatefulWidget {
  const MovementsBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MovementsBottomSheetState();
}

class _MovementsBottomSheetState extends ConsumerState<MovementsBottomSheet> {
  Section _section = Section.today;
  @override
  Widget build(BuildContext context) {
    final myMovements = ref.watch(myMovementsStateProvider);
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        leadingWidth: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: GoogleFonts.ubuntu(
          color: Colors.red,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
        title: Text(context.lang!.movements),
        actions: [
          IconButton(
            onPressed: context.pop,
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
      body: Center(
        child: myMovements.when(
          data: (movements) {
            if (movements.isEmpty) {
              return Column(
                children: [
                  Icon(
                    Icons.money_off,
                    size: 100,
                    color: Colors.red[900],
                  ),
                  Text(context.lang!.notMovements),
                ],
              );
            }
            List<Movement> list = movements;
            if (_section == Section.today) {
              list = movements.where((movement) {
                final createdAt = DateFormat.yMMMd().format(movement.createdAt);
                final today = DateFormat.yMMMd().format(DateTime.now());
                return createdAt == today;
              }).toList();
            }
            list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            final groupByDate = groupBy<Movement, String>(
              list,
              (movement) => DateFormat('dd/MM/yyyy').format(movement.createdAt),
            ).values.toList();
            return Column(
              children: [
                SegmentedButton<Section>(
                  selectedIcon: Container(),
                  segments: List<ButtonSegment<Section>>.from(
                    Section.values.map((section) {
                      return ButtonSegment<Section>(
                        value: section,
                        label: Text(section.displayName),
                      );
                    }),
                  ),
                  selected: {_section},
                  onSelectionChanged: (Set<Section> value) {
                    setState(() {
                      _section = value.first;
                    });
                  },
                ),
                Expanded(
                  child: groupByDate.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.money_off,
                              size: 100,
                              color: Colors.red[900],
                            ),
                            Text(context.lang!.notMovements),
                          ],
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: groupByDate.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 16);
                          },
                          itemBuilder: (context, index) {
                            final group = groupByDate[index];
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8,
                              children: [
                                Text(
                                  DateFormat.EEEE(
                                          context.getLocale.toLanguageTag())
                                      .format(group.first.createdAt)
                                      .toUpperCase(),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 8,
                                  children: List<Widget>.from(
                                    group.map(
                                      (movement) => ListTile(
                                        onTap: () {
                                          context.push(
                                            MovementDetails.path,
                                            extra: group.first,
                                          );
                                        },
                                        tileColor: Colors.grey.withValues(
                                          alpha: 0.2,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        leading: movement.type.icon,
                                        title:
                                            Text(movement.titular ?? 'Sistema'),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              movement.description,
                                              style: GoogleFonts.ubuntu(
                                                color: Colors.grey,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              'Fecha: ${DateFormat('dd/MM/yyyy').format(movement.createdAt)}',
                                              style: GoogleFonts.ubuntu(
                                                fontSize: 10,
                                                color: Colors.grey,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        trailing: Text(
                                          '${movement.type == MovementType.payment ? '-' : ''}\$${NumberFormat.currency(
                                            locale: 'es_CO',
                                            symbol: '',
                                            decimalDigits: 0,
                                          ).format(movement.total)}',
                                          style: GoogleFonts.ubuntu(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: movement.type.color,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                ),
              ],
            );
          },
          error: (error, stackTrace) => ShowError(
            error: error,
            stackTrace: stackTrace,
          ),
          loading: () => const Loader(),
        ),
      ),
    );
  }
}

enum Section {
  today,
  daily,
}

extension SectionExtension on Section {
  String get displayName => switch (this) {
        Section.today => 'Hoy',
        Section.daily => 'Diario',
      };
}

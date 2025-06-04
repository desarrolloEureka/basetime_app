import 'package:basetime/core/context/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchSelect extends ConsumerWidget {
  const MatchSelect({
    super.key,
    required this.value,
    required this.onChanged,
    required this.onSubmit,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 178,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.red.shade900,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 12,
                  ),
                  child: Text(
                    context.lang!.matchHours,
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.local_fire_department,
                      color: Colors.white,
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: value == 1
                          ? null
                          : () {
                              if (value > 1) {
                                onChanged(value - 1);
                              }
                            },
                      icon: const Icon(Icons.remove_rounded),
                    ),
                    Text(
                      value.toString(),
                      style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: value == 12
                          ? null
                          : () {
                              if (value < 12) {
                                onChanged(value + 1);
                              }
                            },
                      icon: const Icon(Icons.add_rounded),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 40,
            height: MediaQuery.of(context).size.height,
            child: MaterialButton(
              onPressed: onSubmit,
              color: Colors.red,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_circle_right_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

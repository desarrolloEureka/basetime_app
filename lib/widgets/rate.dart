import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Rate extends ConsumerWidget {
  const Rate({
    super.key,
    this.value = 0,
    this.readOnly = false,
    this.onChange,
  });

  final double value;
  final bool readOnly;
  final ValueChanged<int>? onChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: List<Widget>.generate(5, (index) {
        if (readOnly) {
          return Icon(
            value == index + 1 || value > index + 1
                ? Icons.star_rounded
                : value > index && value < (index + 1)
                    ? Icons.star_half_rounded
                    : Icons.star_outline_rounded,
            color: Colors.red,
            size: 24,
          );
        }
        return IconButton(
          onPressed: onChange != null ? () => onChange!(index + 1) : null,
          icon: Icon(
            value == index + 1 || value > index + 1
                ? Icons.star_rounded
                : value > index && value < (index + 1)
                    ? Icons.star_half_rounded
                    : Icons.star_outline_rounded,
            color: Colors.red,
            size: 32,
          ),
        );
      }),
    );
  }
}

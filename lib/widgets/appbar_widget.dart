import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarBT extends AppBar {
  AppBarBT({
    super.key,
    super.leading,
    super.title,
    super.actions,
    super.titleTextStyle,
    super.centerTitle,
    super.automaticallyImplyLeading = true,
    super.toolbarHeight,
    super.toolbarOpacity,
    super.backgroundColor,
    super.elevation,
    super.scrolledUnderElevation,
    super.shadowColor,
    super.shape,
    super.bottom,
    super.toolbarTextStyle,
  });

  @override
  double? get leadingWidth => 32;

  @override
  Widget? get leading => Builder(
        builder: (BuildContext context) {
          if (context.canPop()) {
            return IconButton(
              icon: const Icon(Icons.arrow_circle_left_outlined),
              onPressed: () {
                context.pop();
              },
            );
          } else {
            return super.leading ?? const SizedBox.shrink();
          }
        },
      );
}

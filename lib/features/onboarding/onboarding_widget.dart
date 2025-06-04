import 'package:basetime/core/context/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingWidget extends ConsumerWidget {
  const OnboardingWidget({
    super.key,
    required this.number,
    required this.title,
    required this.description,
    this.onNext,
    this.onSkip,
  });

  final int number;
  final String title;
  final String description;
  final VoidCallback? onNext;
  final VoidCallback? onSkip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Image.asset(
          'assets/onboarding-bg-$number.png',
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
              if (onSkip != null)
                TextButton(
                  onPressed: onSkip,
                  child: Text(
                    context.lang!.skip,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: Text(description),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (onNext != null)
                      FilledButton(
                        onPressed: onNext,
                        child: Text(context.lang?.next ?? 'Next'),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../extensions/app_localization_extension.dart';
import 'app_cupertino_button.dart';

class AppAsyncWidget<T> extends StatelessWidget {
  const AppAsyncWidget({
    required this.asyncValue,
    required this.child,
    super.key,
    this.onErrorRetry,
  });

  final AsyncValue<T> asyncValue;
  final VoidCallback? onErrorRetry;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return switch (asyncValue) {
      AsyncData() => child,
      AsyncError(:final error) => Center(
          key: const ValueKey('error'),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (onErrorRetry != null)
                CupertinoButton(
                  onPressed: onErrorRetry,
                  child: Text(context.loc.retry),
                ),
            ],
          ),
        ),
      AsyncLoading() => const Center(
          key: ValueKey('loading'),
          child: Center(
            child: SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ),
    };
  }
}

class AppAsyncSliver<T> extends StatelessWidget {
  const AppAsyncSliver({
    required this.asyncValue,
    required this.child,
    this.onErrorRetry,
    super.key,
  });

  final AsyncValue<T> asyncValue;
  final VoidCallback? onErrorRetry;
  final Widget Function(T) child;

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedSwitcher(
      duration: kThemeAnimationDuration,
      child: switch (asyncValue) {
        AsyncData(:final value) => child(value),
        AsyncError(:final error) => SliverFillRemaining(
            key: const ValueKey('error'),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      error.toString(),
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    if (onErrorRetry != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: AppCupertinoButton.tinted(
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: onErrorRetry,
                          icon: const Icon(Icons.refresh),
                          child: Text(context.loc.retry),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        AsyncLoading() => const SliverFillRemaining(
            key: ValueKey('loading'),
            child: Center(
              child: SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ),
      },
    );
  }
}

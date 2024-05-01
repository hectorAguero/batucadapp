import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../core/extensions/app_localization_extension.dart';
import 'app_cupertino_button.dart';
import 'app_infinite_rotation_animation.dart';

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

class AppAsyncSliverWidget<T> extends StatefulWidget {
  const AppAsyncSliverWidget({
    required this.asyncValue,
    required this.child,
    this.onErrorRetry,
    super.key,
  });

  final AsyncValue<T> asyncValue;
  final VoidCallback? onErrorRetry;
  final Widget Function(T) child;

  @override
  State<AppAsyncSliverWidget<T>> createState() =>
      _AppAsyncSliverWidgetState<T>();
}

class _AppAsyncSliverWidgetState<T> extends State<AppAsyncSliverWidget<T>> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isRefreshing = widget.asyncValue.isRefreshing;

    return SliverAnimatedSwitcher(
      duration: kThemeAnimationDuration,
      child: switch (widget.asyncValue) {
        AsyncData(:final value) => widget.child(value),
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
                    if (widget.onErrorRetry != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: AppCupertinoButton.tinted(
                          color: Theme.of(context).colorScheme.primary,
                          onPressed:
                              !isRefreshing && !isLoading ? errorRetry : null,
                          icon: AppInfiniteRotationAnimation(
                            isLoading: isRefreshing || isLoading,
                            child: const Icon(Icons.refresh),
                          ),
                          child: Text(context.loc.retry),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
      },
    );
  }

  Future<void> errorRetry() async {
    setState(() => isLoading = true);
    widget.onErrorRetry?.call();
    await Future<void>.delayed(const Duration(milliseconds: 700));
    setState(() => isLoading = false);
  }
}

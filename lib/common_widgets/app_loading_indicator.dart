// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    required this.showLoading,
    this.sliver = false,
    super.key,
  });

  final bool showLoading;
  final bool sliver;
  @override
  Widget build(BuildContext context) {
    if (sliver) {
      return SliverToBoxAdapter(
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: !showLoading
              ? const SizedBox.shrink()
              : const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: SizedBox(
                        height: 32,
                        width: 32,
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                  ],
                ),
        ),
      );
    }

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: !showLoading
          ? const SizedBox.shrink()
          : const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                height: 32,
                width: 32,
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';

class AppInfiniteRotationAnimation extends StatefulWidget {
  const AppInfiniteRotationAnimation({
    required this.isLoading,
    required this.child,
    this.duration = const Duration(milliseconds: 700),
    super.key,
  });
  final bool isLoading;
  final Widget child;
  final Duration duration;

  @override
  State<AppInfiniteRotationAnimation> createState() =>
      _AppInfiniteRotationAnimationState();
}

class _AppInfiniteRotationAnimationState
    extends State<AppInfiniteRotationAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(covariant AppInfiniteRotationAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading != oldWidget.isLoading) {
      if (widget.isLoading) {
        _controller.repeat();
      } else {
        _controller.animateTo(0).then((_) => _controller.stop());
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }
}

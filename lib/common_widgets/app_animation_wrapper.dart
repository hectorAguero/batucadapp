import 'package:flutter/material.dart';

class AppAnimationWrapper extends StatefulWidget {
  const AppAnimationWrapper({
    required this.child,
    super.key,
    this.keepAlive = false,
    this.duration = const Duration(milliseconds: 350),
    this.start = 0.6,
    this.end = 1.0,
  });

  final bool keepAlive;
  final Widget child;
  final Duration duration;
  final double start;
  final double end;

  @override
  State<AppAnimationWrapper> createState() => _AppAnimationWrapperState();
}

class _AppAnimationWrapperState extends State<AppAnimationWrapper>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..forward();
  late final Animation<double> _animation = Tween<double>(
    begin: widget.start,
    end: widget.end,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ),
  );

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}

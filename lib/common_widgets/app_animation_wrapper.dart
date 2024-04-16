import 'package:flutter/material.dart';

class AppAnimationWrapper extends StatefulWidget {
  const AppAnimationWrapper({
    required this.child,
    super.key,
    this.keepAlive = false,
  });

  final bool keepAlive;
  final Widget child;

  @override
  State<AppAnimationWrapper> createState() => _AppAnimationWrapperState();
}

class _AppAnimationWrapperState extends State<AppAnimationWrapper>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();
    _animation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}

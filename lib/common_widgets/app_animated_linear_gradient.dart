import 'package:flutter/material.dart';

class AppAnimatedLinearGradient extends StatefulWidget {
  const AppAnimatedLinearGradient({
    required this.colors,
    required this.child,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    super.key,
    this.duration = const Duration(seconds: 3),
  });
  final List<Color> colors;
  final Duration duration;
  final Widget child;
  final Alignment begin;
  final Alignment end;

  @override
  State<AppAnimatedLinearGradient> createState() =>
      _AppAnimatedLinearGradientState();
}

class _AppAnimatedLinearGradientState extends State<AppAnimatedLinearGradient>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: LinearGradientPainter(
            colors: widget.colors,
            percent: _animation.value,
          ),
          child: widget.child,
        );
      },
    );
  }
}

class LinearGradientPainter extends CustomPainter {
  LinearGradientPainter({
    required this.colors,
    required this.percent,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  });
  final List<Color> colors;
  final double percent;
  final Alignment begin;
  final Alignment end;

  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      colors: colors,
      begin: begin,
      end: end,
    );
    final rect = Offset.zero & size;

    // Create a shader that shifts the gradient's position based on 'percent'
    final shaderRect = Rect.fromLTWH(
      -size.width * percent, // Shift the left boundary of the gradient
      0,
      size.width * 2, // Double the width to allow for a continuous flow
      size.height,
    );

    final paint = Paint()..shader = gradient.createShader(shaderRect);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

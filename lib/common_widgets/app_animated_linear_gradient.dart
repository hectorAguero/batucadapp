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
  late final _controller =
      AnimationController(duration: widget.duration, vsync: this);
  late final _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

  @override
  void initState() {
    super.initState();
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class LinearGradientPainter extends CustomPainter {
  final List<Color> colors;
  final double percent;
  final Alignment begin;
  final Alignment end;

  // Double the width to allow for a continuous flow
  static const widthMultiplier = 2;

  LinearGradientPainter({
    required this.colors,
    required this.percent,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  });

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
      size.width * widthMultiplier,
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

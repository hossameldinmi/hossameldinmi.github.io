import 'dart:math' show cos, sin;
import 'package:flutter/material.dart';

/// Animated gradient border for profile image
class AnimatedGradientBorder extends StatefulWidget {
  final double size;

  const AnimatedGradientBorder({super.key, required this.size});

  @override
  State<AnimatedGradientBorder> createState() => _AnimatedGradientBorderState();
}

class _AnimatedGradientBorderState extends State<AnimatedGradientBorder> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 6.28,
          child: Container(
            width: widget.size * 1.1,
            height: widget.size * 1.1,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: const [
                  Color(0xFF00FFC8),
                  Color(0xFF00E5FF),
                  Color(0xFF7C4DFF),
                  Color(0xFFFF4081),
                  Color(0xFF00FFC8),
                ],
                stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
                transform: GradientRotation(_controller.value * 6.28),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00FFC8).withOpacity(0.7),
                  blurRadius: 50,
                  spreadRadius: 8,
                ),
                BoxShadow(
                  color: const Color(0xFF7C4DFF).withOpacity(0.5),
                  blurRadius: 35,
                  spreadRadius: 4,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Floating icon widget for profile image
class FloatingIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final double angle;
  final double radius;

  const FloatingIcon({
    super.key,
    required this.icon,
    required this.color,
    required this.angle,
    required this.radius,
  });

  @override
  State<FloatingIcon> createState() => _FloatingIconState();
}

class _FloatingIconState extends State<FloatingIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final animatedAngle = widget.angle + (_controller.value * 0.2);
        return Transform.translate(
          offset: Offset(
            widget.radius * cos(animatedAngle),
            widget.radius * sin(animatedAngle),
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A2744) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? const Color(0xFF233554) : const Color(0xFFE2E8F0),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              widget.icon,
              color: widget.color,
              size: 24,
            ),
          ),
        );
      },
    );
  }
}

/// Blinking cursor widget for typewriter effect
class BlinkingCursor extends StatefulWidget {
  final double fontSize;

  const BlinkingCursor({super.key, required this.fontSize});

  @override
  State<BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<BlinkingCursor> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FadeTransition(
      opacity: _controller,
      child: Text(
        '_',
        style: TextStyle(
          fontSize: widget.fontSize,
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}

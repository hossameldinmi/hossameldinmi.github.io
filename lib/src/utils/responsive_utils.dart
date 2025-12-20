import 'package:flutter/material.dart';

/// Responsive design utilities
class ResponsiveUtils {
  const ResponsiveUtils._();

  static bool isMobile(BuildContext context) => MediaQuery.sizeOf(context).width < 600;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= 600 && width < 1024;
  }

  static double getMaxContentWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 600) return width;
    if (width < 1024) return 900;
    if (width < 1440) return 1000;
    return 1200;
  }

  static EdgeInsets getResponsivePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.all(20);
    } else if (isTablet(context)) {
      return const EdgeInsets.all(30);
    }
    return const EdgeInsets.all(50);
  }

  static double getResponsiveFontSize(BuildContext context, double base) {
    if (isMobile(context)) {
      return base * 0.7;
    } else if (isTablet(context)) {
      return base * 0.85;
    }
    return base;
  }
}

/// Section header widget
class SectionHeader extends StatelessWidget {
  final String title;
  final bool isDark;
  final double fontSize;

  const SectionHeader({
    super.key,
    required this.title,
    required this.isDark,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.displayLarge?.color,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            height: 1,
            color: isDark ? const Color(0xFF233554) : const Color(0xFFE2E8F0),
          ),
        ),
      ],
    );
  }
}

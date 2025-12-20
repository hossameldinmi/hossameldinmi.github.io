import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/resume_data.dart';
import '../../utils/responsive_utils.dart';
import '../widgets/animations/fade_in_up_animation.dart';
import '../widgets/common/calendly_widget.dart';

class CalendlySection extends StatelessWidget {
  const CalendlySection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      color: theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 60 : 100,
            ),
            child: Column(
              children: [
                FadeInUpAnimation(
                  delay: const Duration(milliseconds: 200),
                  child: Column(
                    children: [
                      Text(
                        'Schedule a Meeting',
                        style: GoogleFonts.roboto(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, 32),
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.displayLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Let\'s connect and discuss your project',
                        style: GoogleFonts.roboto(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          FadeInUpAnimation(
            delay: const Duration(milliseconds: 400),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: isMobile ? 600 : 700,
              ),
              color: theme.cardColor,
              child: CalendlyWidget(
                id: ResumeData.profile.calendlyId ?? '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

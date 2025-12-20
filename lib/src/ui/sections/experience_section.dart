import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/resume_data.dart';
import '../../utils/responsive_utils.dart';
import '../widgets/animations/fade_in_up_animation.dart';
import '../widgets/animations/animated_company_card.dart';

class ExperienceSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const ExperienceSection({
    super.key,
    required this.sectionKey,
  });

  @override
  Widget build(BuildContext context) {
    final companies = ResumeData.profile.experience;

    final isMobile = ResponsiveUtils.isMobile(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      key: sectionKey,
      padding: ResponsiveUtils.getResponsivePadding(context).copyWith(
        top: isMobile ? 60 : 100,
        bottom: isMobile ? 60 : 100,
      ),
      color: theme.scaffoldBackgroundColor,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: ResponsiveUtils.getMaxContentWidth(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInUpAnimation(
                delay: const Duration(milliseconds: 200),
                child: Row(
                  children: [
                    Text(
                      'Work Experience',
                      style: GoogleFonts.roboto(
                        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 32),
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.displayLarge?.color,
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
                ),
              ),
              const SizedBox(height: 40),
              ...companies.asMap().entries.map((entry) {
                final index = entry.key;
                final company = entry.value;
                return AnimatedCompanyExperienceCard(
                  delay: Duration(milliseconds: 400 + (index * 100)),
                  company: company,
                  isMobile: isMobile,
                  titleFontSize: ResponsiveUtils.getResponsiveFontSize(context, 22),
                  textFontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

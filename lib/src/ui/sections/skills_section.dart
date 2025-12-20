import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/resume_data.dart';
import '../../utils/responsive_utils.dart';
import '../widgets/animations/fade_in_up_animation.dart';
import '../widgets/animations/animated_skill_card.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = ResumeData.profile.skills;

    final isMobile = ResponsiveUtils.isMobile(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: ResponsiveUtils.getResponsivePadding(context).copyWith(
        top: isMobile ? 60 : 100,
        bottom: isMobile ? 60 : 100,
      ),
      color: theme.cardColor,
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
                      'Skills',
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: skills.asMap().entries.map((entry) {
                  final index = entry.key;
                  final skillGroup = entry.value;

                  return Padding(
                    padding: EdgeInsets.only(bottom: isMobile ? 30.0 : 40.0),
                    child: AnimatedSkillCard(
                      delay: Duration(milliseconds: 400 + (index * 100)),
                      width: double.infinity,
                      skillGroup: skillGroup,
                      fontSize: ResponsiveUtils.getResponsiveFontSize(context, 20),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

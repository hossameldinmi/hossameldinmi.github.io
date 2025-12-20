import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/skill.dart';
import '../../../models/skill_section.dart';
import 'fade_in_up_animation.dart';

class AnimatedSkillCard extends StatefulWidget {
  final Duration delay;
  final double width;
  final SkillSection skillGroup;
  final double fontSize;

  const AnimatedSkillCard({
    super.key,
    required this.delay,
    required this.width,
    required this.skillGroup,
    required this.fontSize,
  });

  @override
  State<AnimatedSkillCard> createState() => _AnimatedSkillCardState();
}

class _AnimatedSkillCardState extends State<AnimatedSkillCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return FadeInUpAnimation(
      delay: widget.delay,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.skillGroup.category,
            style: GoogleFonts.roboto(
              fontSize: widget.fontSize,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.displayLarge?.color,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.skillGroup.skills.map((skill) {
              return SkillPill(skill: skill, isDark: isDark);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class SkillPill extends StatefulWidget {
  final Skill skill;
  final bool isDark;

  const SkillPill({
    super.key,
    required this.skill,
    required this.isDark,
  });

  @override
  State<SkillPill> createState() => _SkillPillState();
}

class _SkillPillState extends State<SkillPill> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Color based on proficiency
    Color dotColor;
    Color dotGlowColor;
    Color bgColor;
    Color borderColor;
    Color textColor;
    String proficiencyText;

    // Theme-appropriate backgrounds for skill pills
    bgColor = widget.isDark ? const Color(0xFF181A20) : const Color(0xFFF8FAFC);
    borderColor = widget.isDark ? const Color(0xFF00FFC8).withOpacity(0.25) : const Color(0xFF0891E5).withOpacity(0.35);
    textColor = widget.isDark ? const Color(0xFFF1F5F9) : const Color(0xFF1E293B);

    switch (widget.skill.proficiency) {
      case SkillProficiency.expert:
        dotColor = const Color(0xFF00E676);
        dotGlowColor = const Color(0xFF69F0AE);
        proficiencyText = '80%+';
        break;
      case SkillProficiency.advanced:
        dotColor = const Color(0xFFFF6D00);
        dotGlowColor = const Color(0xFFFFAB40);
        proficiencyText = '60%';
        break;
      case SkillProficiency.intermediate:
        dotColor = const Color(0xFF00E5FF);
        dotGlowColor = const Color(0xFF84FFFF);
        proficiencyText = '40%';
        break;
      case SkillProficiency.beginner:
        dotColor = const Color(0xFFFF4081);
        dotGlowColor = const Color(0xFFFF80AB);
        proficiencyText = '20%';
        break;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _isHovered ? Color.lerp(bgColor, dotColor, 0.12) : bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? dotColor.withOpacity(0.6) : borderColor,
            width: _isHovered ? 1.5 : 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: dotGlowColor.withOpacity(0.6),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 0),
                  ),
                  BoxShadow(
                    color: dotColor.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: dotGlowColor.withOpacity(0.15),
                    blurRadius: 6,
                    spreadRadius: 0,
                  ),
                ],
        ),
        transform: Matrix4.translationValues(0.0, _isHovered ? -2.0 : 0.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: _isHovered ? 10 : 7,
              height: _isHovered ? 10 : 7,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: dotGlowColor.withOpacity(0.9),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                        BoxShadow(
                          color: dotColor.withOpacity(0.8),
                          blurRadius: 8,
                          spreadRadius: 0,
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: dotGlowColor.withOpacity(0.4),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              widget.skill.name,
              style: GoogleFonts.inter(
                color: _isHovered ? dotColor : textColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (_isHovered) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: dotColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  proficiencyText,
                  style: GoogleFonts.inter(
                    color: textColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

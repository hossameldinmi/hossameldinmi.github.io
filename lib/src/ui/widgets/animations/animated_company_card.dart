import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/company.dart';
import 'fade_in_up_animation.dart';

class AnimatedCompanyExperienceCard extends StatefulWidget {
  final Duration delay;
  final Company company;
  final bool isMobile;
  final double titleFontSize;
  final double textFontSize;

  const AnimatedCompanyExperienceCard({
    super.key,
    required this.delay,
    required this.company,
    required this.isMobile,
    required this.titleFontSize,
    required this.textFontSize,
  });

  @override
  State<AnimatedCompanyExperienceCard> createState() => _AnimatedCompanyExperienceCardState();
}

class _AnimatedCompanyExperienceCardState extends State<AnimatedCompanyExperienceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return FadeInUpAnimation(
      delay: widget.delay,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 30),
          padding: EdgeInsets.all(widget.isMobile ? 20 : 28),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color:
                  _isHovered ? theme.colorScheme.primary : (isDark ? const Color(0xFF233554) : const Color(0xFFE2E8F0)),
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 2,
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.15),
                      blurRadius: 40,
                      spreadRadius: 0,
                      offset: const Offset(0, 15),
                    ),
                  ]
                : [],
          ),
          transform: Matrix4.translationValues(0.0, _isHovered ? -4.0 : 0.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company Header
              Row(
                children: [
                  if (widget.company.logo != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 48,
                          height: 48,
                          color: Colors.white,
                          child: widget.company.logo!.fold(
                            network: (n) => CachedNetworkImage(
                              imageUrl: n.uri.toString(),
                              fit: BoxFit.cover,
                              errorWidget: (context, error, stackTrace) {
                                return Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: isDark ? const Color(0xFF1A2744) : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.business,
                                    color: theme.colorScheme.primary,
                                    size: 24,
                                  ),
                                );
                              },
                            ),
                            asset: (a) => Image.asset(
                              a.assetPath,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: isDark ? const Color(0xFF1A2744) : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.business,
                                    color: theme.colorScheme.primary,
                                    size: 24,
                                  ),
                                );
                              },
                            ),
                            orElse: () => const SizedBox(),
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.company.name,
                          style: GoogleFonts.roboto(
                            fontSize: widget.titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.displayLarge?.color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${widget.company.location} · ${widget.company.totalDuration}',
                          style: GoogleFonts.roboto(
                            fontSize: widget.textFontSize * 0.9,
                            color: theme.textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Timeline logic

              ...widget.company.experiences.asMap().entries.map((entry) {
                final index = entry.key;
                final exp = entry.value;
                final isLast = index == widget.company.experiences.length - 1;
                final hasMultipleExperiences = widget.company.experiences.length > 1;

                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (hasMultipleExperiences) ...[
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 7),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: !isLast ? theme.colorScheme.primary : Colors.transparent,
                                border: !isLast
                                    ? null
                                    : Border.all(
                                        color: theme.colorScheme.primary,
                                        width: 1.5,
                                      ),
                              ),
                            ),
                            if (!isLast)
                              Expanded(
                                child: Container(
                                  width: 1.5,
                                  color: theme.colorScheme.primary.withOpacity(0.3),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 16),
                      ],
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      exp.title,
                                      style: GoogleFonts.roboto(
                                        fontSize: widget.titleFontSize * 0.9,
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    exp.dateRange.forResume,
                                    style: GoogleFonts.roboto(
                                      fontSize: widget.textFontSize * 0.9,
                                      color: theme.textTheme.bodyMedium?.color,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${exp.locationType} · ${exp.employmentType}',
                                style: GoogleFonts.roboto(
                                  fontSize: widget.textFontSize * 0.85,
                                  color: theme.textTheme.bodyMedium?.color,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                exp.description,
                                style: GoogleFonts.roboto(
                                  fontSize: widget.textFontSize,
                                  height: 1.6,
                                  color: theme.textTheme.bodyMedium?.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

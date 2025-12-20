import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:media_source/media_source.dart';
import '../../data/resume_data.dart';
import '../../models/media.dart';
import '../../utils/responsive_utils.dart';
import '../widgets/animations/fade_in_up_animation.dart';
import '../widgets/animations/animated_project_card.dart';

class ProjectsSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const ProjectsSection({
    super.key,
    required this.sectionKey,
  });

  @override
  Widget build(BuildContext context) {
    final projects = ResumeData.profile.projects;

    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    int getColumnCount() {
      if (isMobile) return 1;
      if (isTablet) return 2;
      return 3;
    }

    return Container(
      key: sectionKey,
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
                      'Projects',
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
              LayoutBuilder(
                builder: (context, constraints) {
                  final columnCount = getColumnCount();
                  final spacing = isMobile ? 15.0 : 20.0;
                  final itemWidth = (constraints.maxWidth - (spacing * (columnCount - 1))) / columnCount;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: projects.asMap().entries.map((entry) {
                      final index = entry.key;
                      final project = entry.value;

                      return AnimatedProjectCard(
                        delay: Duration(milliseconds: 400 + (index * 100)),
                        width: isMobile ? double.infinity : itemWidth,
                        project: project,
                        titleFontSize: ResponsiveUtils.getResponsiveFontSize(context, 20),
                        descFontSize: ResponsiveUtils.getResponsiveFontSize(context, 15),
                        onTap: () {
                          final link = project.media
                              .firstWhere((m) => m.type == MediaType.link, orElse: () => project.media.first);
                          if (link.media is UrlMedia) {
                            _launchURL((link.media as UrlMedia).uri.toString());
                          }
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:media_source/media_source.dart';
import '../../../models/project.dart';
import '../../../models/media.dart';
import '../../../utils/responsive_utils.dart';

class ProjectDetailsDialog extends StatelessWidget {
  final Project project;

  const ProjectDetailsDialog({
    super.key,
    required this.project,
  });

  IconData _getMediaIcon(Media media) {
    if (media.media is! UrlMedia) return FontAwesomeIcons.link;

    final url = (media.media as UrlMedia).uri.toString().toLowerCase();

    if (url.contains('play.google.com')) return FontAwesomeIcons.googlePlay;
    if (url.contains('apps.apple.com')) return FontAwesomeIcons.appStore;
    if (url.contains('appgallery.huawei.com'))
      return FontAwesomeIcons.appStoreIos; // Using iOS App Store icon as placeholder for Huawei
    if (url.contains('pub.dev')) return FontAwesomeIcons.cube;
    if (url.contains('github.com')) return FontAwesomeIcons.github;
    return FontAwesomeIcons.link;
  }

  Widget _getMediaIconWidget(Media media, Color color) {
    if (media.media is! UrlMedia) {
      return Icon(FontAwesomeIcons.link, size: 20, color: color);
    }

    final url = (media.media as UrlMedia).uri.toString().toLowerCase();

    // For Huawei AppGallery, use a custom styled icon
    if (url.contains('appgallery.huawei.com')) {
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF0000), Color(0xFFCC0000)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Center(
          child: Icon(
            Icons.shopping_bag,
            color: Colors.white,
            size: 13,
          ),
        ),
      );
    }

    return Icon(_getMediaIcon(media), size: 20, color: color);
  }

  String _getMediaLabel(Media media) {
    if (media.media is! UrlMedia) return media.title;

    final url = (media.media as UrlMedia).uri.toString().toLowerCase();

    if (url.contains('play.google.com')) return 'Google Play';
    if (url.contains('apps.apple.com')) return 'App Store';
    if (url.contains('appgallery.huawei.com')) return 'AppGallery';
    if (url.contains('pub.dev')) return 'pub.dev';
    if (url.contains('github.com')) return 'GitHub';
    return media.title;
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }

  void _showFullImage(BuildContext context, Media logo) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: logo.media.fold(
                asset: (a) => Image.asset(
                  a.assetPath,
                  fit: BoxFit.contain,
                ),
                network: (n) => Image.network(
                  n.uri.toString(),
                  fit: BoxFit.contain,
                ),
                orElse: () => const SizedBox(),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    final maxWidth = isMobile ? double.infinity : (isTablet ? 600.0 : 800.0);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: MediaQuery.of(context).size.height * 0.9),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? const Color(0xFF233554) : const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? const Color(0xFF233554) : const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  if (project.logo != null)
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => _showFullImage(context, project.logo!),
                        child: Tooltip(
                          message: 'View full size',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: 32,
                              height: 32,
                              color: Colors.white,
                              child: project.logo!.media.fold(
                                asset: (a) => Image(
                                  image: AssetImage(a.assetPath),
                                  width: 32,
                                  height: 32,
                                  fit: BoxFit.cover,
                                ),
                                network: (n) => Image.network(
                                  n.uri.toString(),
                                  width: 32,
                                  height: 32,
                                  fit: BoxFit.cover,
                                ),
                                orElse: () => Icon(
                                  Icons.image,
                                  color: theme.colorScheme.primary,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    Icon(
                      Icons.folder_open,
                      color: theme.colorScheme.primary,
                      size: 32,
                    ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      project.title,
                      style: GoogleFonts.roboto(
                        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 24),
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.displayLarge?.color,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ],
              ),
            ),
            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Description
                    Text(
                      project.description,
                      style: GoogleFonts.roboto(
                        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
                        height: 1.6,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Media Links
                    if (project.media.isNotEmpty) ...[
                      Text(
                        'Available On',
                        style: GoogleFonts.roboto(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.displayLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: project.media.map((media) {
                          return InkWell(
                            onTap: () {
                              if (media.media is UrlMedia) {
                                _launchURL((media.media as UrlMedia).uri.toString());
                              }
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: theme.cardColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isDark ? const Color(0xFF233554) : const Color(0xFFE2E8F0),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _getMediaIconWidget(media, theme.colorScheme.primary),
                                  const SizedBox(width: 8),
                                  Text(
                                    _getMediaLabel(media),
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: theme.textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.open_in_new,
                                    size: 14,
                                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 32),
                    ],
                    // Skills
                    if (project.skills.isNotEmpty) ...[
                      Text(
                        'Technologies & Skills',
                        style: GoogleFonts.roboto(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.displayLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: project.skills.map((skill) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: theme.colorScheme.primary.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              skill.name,
                              style: GoogleFonts.firaCode(
                                fontSize: 13,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 32),
                    ],
                    // Experiences
                    if (project.experiences.isNotEmpty) ...[
                      Text(
                        'Related Experience',
                        style: GoogleFonts.roboto(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.displayLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...project.experiences.map((experience) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.work_outline,
                                size: 16,
                                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: theme.textTheme.bodyMedium?.color,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: experience.title,
                                        style: const TextStyle(fontWeight: FontWeight.w500),
                                      ),
                                      TextSpan(
                                        text: ' at ',
                                        style: TextStyle(
                                          color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                                        ),
                                      ),
                                      TextSpan(
                                        text: experience.company.name,
                                        style: TextStyle(
                                          color: theme.colorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

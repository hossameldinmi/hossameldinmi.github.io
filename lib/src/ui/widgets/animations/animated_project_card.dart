import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_source/media_source.dart';
import '../../../models/project.dart';
import '../../../models/media.dart';
import 'fade_in_up_animation.dart';

class AnimatedProjectCard extends StatefulWidget {
  final Duration delay;
  final double width;
  final Project project;
  final double titleFontSize;
  final double descFontSize;
  final VoidCallback? onTap;

  const AnimatedProjectCard({
    super.key,
    required this.delay,
    required this.width,
    required this.project,
    required this.titleFontSize,
    required this.descFontSize,
    this.onTap,
  });

  @override
  State<AnimatedProjectCard> createState() => _AnimatedProjectCardState();
}

class _AnimatedProjectCardState extends State<AnimatedProjectCard> {
  bool _isHovered = false;

  IconData _getMediaIcon(Media media) {
    if (media.media is! UrlMedia) return FontAwesomeIcons.link;

    final url = (media.media as UrlMedia).uri.toString().toLowerCase();

    if (url.contains('play.google.com')) return FontAwesomeIcons.googlePlay;
    if (url.contains('apps.apple.com')) return FontAwesomeIcons.appStore;
    if (url.contains('appgallery.huawei.com')) return FontAwesomeIcons.mobile;
    if (url.contains('pub.dev')) return FontAwesomeIcons.cube;
    if (url.contains('github.com')) return FontAwesomeIcons.github;
    return FontAwesomeIcons.link;
  }

  String _getMediaTooltip(Media media) {
    if (media.media is! UrlMedia) return media.title;

    final url = (media.media as UrlMedia).uri.toString().toLowerCase();

    if (url.contains('play.google.com')) return 'Google Play Store';
    if (url.contains('apps.apple.com')) return 'App Store';
    if (url.contains('appgallery.huawei.com')) return 'Huawei AppGallery';
    if (url.contains('pub.dev')) return 'pub.dev';
    if (url.contains('github.com')) return 'GitHub';
    return media.title;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return FadeInUpAnimation(
      delay: widget.delay,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.width,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _isHovered
                    ? theme.colorScheme.primary
                    : (isDark ? const Color(0xFF233554) : const Color(0xFFE2E8F0)),
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
            transform: Matrix4.translationValues(0.0, _isHovered ? -8.0 : 0.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.project.logo != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 40,
                          height: 40,
                          color: Colors.white,
                          child: widget.project.logo!.media.fold(
                            asset: (a) => Image(
                              image: AssetImage(a.assetPath),
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                            network: (n) => Image.network(
                              n.uri.toString(),
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                            orElse: () => Icon(
                              Icons.image,
                              color: theme.colorScheme.primary,
                              size: 40,
                            ),
                          ),
                        ),
                      )
                    else
                      Icon(
                        Icons.folder_open,
                        color: theme.colorScheme.primary,
                        size: 40,
                      ),
                    if (widget.onTap != null)
                      Icon(
                        Icons.open_in_new,
                        color: theme.textTheme.bodyMedium?.color,
                        size: 20,
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  widget.project.title,
                  style: GoogleFonts.roboto(
                    fontSize: widget.titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.displayLarge?.color,
                  ),
                ),
                const SizedBox(height: 12),
                // Platform/Source Icons
                if (widget.project.media.isNotEmpty)
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: widget.project.media.map((media) {
                      return Tooltip(
                        message: _getMediaTooltip(media),
                        child: Icon(
                          _getMediaIcon(media),
                          size: 18,
                          color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                        ),
                      );
                    }).toList(),
                  ),
                const SizedBox(height: 16),
                Text(
                  widget.project.description,
                  style: GoogleFonts.roboto(
                    fontSize: widget.descFontSize,
                    height: 1.6,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/resume_data.dart';
import '../../utils/responsive_utils.dart';
import '../widgets/animations/fade_in_up_animation.dart';
import '../widgets/common/animated_buttons.dart';

class ContactSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const ContactSection({
    super.key,
    required this.sectionKey,
  });

  @override
  Widget build(BuildContext context) {
    final contact = ResumeData.profile.contact;
    final isMobile = ResponsiveUtils.isMobile(context);
    final theme = Theme.of(context);

    return Container(
      key: sectionKey,
      padding: ResponsiveUtils.getResponsivePadding(context).copyWith(
        top: isMobile ? 60 : 100,
        bottom: isMobile ? 60 : 100,
      ),
      color: theme.cardColor,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInUpAnimation(
                delay: const Duration(milliseconds: 200),
                child: Column(
                  children: [
                    Text(
                      'Get In Touch',
                      style: GoogleFonts.roboto(
                        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 48),
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.displayLarge?.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              FadeInUpAnimation(
                delay: const Duration(milliseconds: 400),
                child: Text(
                  'I\'m currently looking for new opportunities and collaborations. Whether you have a question or just want to say hi, I\'ll try my best to get back to you!',
                  style: GoogleFonts.roboto(
                    fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
                    height: 1.6,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              FadeInUpAnimation(
                delay: const Duration(milliseconds: 600),
                child: AnimatedOutlinedButton(
                  onPressed: () {
                    if (contact.email != null) {
                      _launchURL('mailto:${contact.email}');
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: theme.colorScheme.primary, width: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'Say Hello',
                    style: GoogleFonts.firaCode(
                      color: theme.colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
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

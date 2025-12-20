import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../data/resume_data.dart';
import '../../utils/responsive_utils.dart';
import '../widgets/common/animated_buttons.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveUtils.isMobile(context) ? 40 : 50,
        horizontal: 20,
      ),
      color: theme.scaffoldBackgroundColor,
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (ResumeData.profile.contact.linkedinUrl != null)
                  AnimatedIconButton(
                    icon: FontAwesomeIcons.linkedin,
                    onPressed: () => _launchURL(ResumeData.profile.contact.linkedinUrl!),
                    size: 24,
                  ),
                if (ResumeData.profile.contact.githubUrl != null)
                  AnimatedIconButton(
                    icon: FontAwesomeIcons.github,
                    onPressed: () => _launchURL(ResumeData.profile.contact.githubUrl!),
                    size: 24,
                  ),
                if (ResumeData.profile.contact.email != null)
                  AnimatedIconButton(
                    icon: Icons.mail_outline,
                    onPressed: () => _launchURL('mailto:${ResumeData.profile.contact.email}'),
                    size: 24,
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Built with Flutter',
              style: GoogleFonts.firaCode(
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'With help from Claude, GitHub Copilot & Antigravity',
              style: GoogleFonts.roboto(
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              '© ${DateTime.now().year} ${ResumeData.profile.firstName}',
              style: GoogleFonts.roboto(
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
                color: theme.textTheme.bodyMedium?.color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
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

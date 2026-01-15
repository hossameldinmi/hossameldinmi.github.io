import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:web/web.dart' as web;
import 'dart:js_interop';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../data/resume_data.dart';
import '../sections/skills_section.dart';
import '../sections/experience_section.dart';
import '../sections/projects_section.dart';
import '../sections/blogs_section.dart';
import '../sections/contact_section.dart';
import '../sections/calendly_section.dart';
import '../sections/footer_section.dart';
import '../sections/summary_section.dart';
import '../widgets/animations/fade_in_up_animation.dart';
import '../widgets/common/profile_widgets.dart';
import '../widgets/common/animated_buttons.dart';

class CVHomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final ThemeMode currentThemeMode;

  const CVHomePage({
    super.key,
    required this.onThemeToggle,
    required this.currentThemeMode,
  });

  @override
  State<CVHomePage> createState() => _CVHomePageState();
}

class _CVHomePageState extends State<CVHomePage> {
  // GlobalKeys for section navigation
  static final GlobalKey aboutKey = GlobalKey();
  static final GlobalKey experienceKey = GlobalKey();
  static final GlobalKey projectsKey = GlobalKey();
  static final GlobalKey contactKey = GlobalKey();

  // Additional keys for lazy loading
  static final GlobalKey summaryKey = GlobalKey();
  static final GlobalKey skillsKey = GlobalKey();
  static final GlobalKey blogsKey = GlobalKey();
  static final GlobalKey calendlyKey = GlobalKey();
  static final GlobalKey footerKey = GlobalKey();

  // Section configuration
  static final List<Map<String, dynamic>> _sections = [
    {'title': 'About', 'key': aboutKey},
    {'title': 'Experience', 'key': experienceKey},
    {'title': 'Projects', 'key': projectsKey},
    {'title': 'Contact', 'key': contactKey},
  ];

  final ScrollController _scrollController = ScrollController();
  String _activeSection = 'About';
  final Set<String> _loadedSections = {'header'}; // Start with header loaded
  static const double _loadThreshold = 300.0; // Load sections 300px before they enter viewport

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Trigger initial load check after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _onScroll();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final scrollPosition = _scrollController.position.pixels;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final viewportEnd = scrollPosition + screenHeight;

    String newActiveSection = _sections.first['title'];
    bool shouldUpdate = false;

    // Check sections in reverse order (bottom to top) to find the active one
    for (var i = _sections.length - 1; i >= 0; i--) {
      final section = _sections[i];
      final position = _getSectionPosition(section['key'] as GlobalKey);

      if (position != null && scrollPosition >= position - screenHeight / 3) {
        newActiveSection = section['title'] as String;
        break;
      }
    }

    // Lazy load sections that are approaching the viewport
    final sectionsToCheck = [
      {'name': 'summary', 'key': summaryKey},
      {'name': 'skills', 'key': skillsKey},
      {'name': 'experience', 'key': experienceKey},
      {'name': 'projects', 'key': projectsKey},
      {'name': 'blogs', 'key': blogsKey},
      {'name': 'contact', 'key': contactKey},
      {'name': 'calendly', 'key': calendlyKey},
      {'name': 'footer', 'key': footerKey},
    ];

    for (final section in sectionsToCheck) {
      final sectionName = section['name'] as String;
      if (!_loadedSections.contains(sectionName)) {
        final key = section['key'] as GlobalKey;
        final position = _getSectionPosition(key);

        // Load section if it's within threshold of viewport
        if (position != null && position < viewportEnd + _loadThreshold) {
          _loadedSections.add(sectionName);
          shouldUpdate = true;
        }
      }
    }

    if (newActiveSection != _activeSection || shouldUpdate) {
      setState(() {
        _activeSection = newActiveSection;
      });
    }
  }

  double? _getSectionPosition(GlobalKey key) {
    final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      return position.dy + _scrollController.position.pixels;
    }
    return null;
  }

  // Helper method to determine if screen is mobile
  bool _isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 600;
  }

  // Helper method to determine if screen is tablet
  bool _isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= 600 && width < 1024;
  }

  // Get responsive max width for content
  double _getMaxContentWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 600) return width;
    if (width < 1024) return 900;
    if (width < 1440) return 1000;
    return 1200;
  }

  // Get responsive padding
  EdgeInsets _getResponsivePadding(BuildContext context) {
    if (_isMobile(context)) {
      return const EdgeInsets.all(20);
    } else if (_isTablet(context)) {
      return const EdgeInsets.all(30);
    }
    return const EdgeInsets.all(50); // Increased padding for desktop
  }

  // Get responsive font size
  double _getResponsiveFontSize(BuildContext context, double base) {
    if (_isMobile(context)) {
      return base * 0.7;
    } else if (_isTablet(context)) {
      return base * 0.85;
    }
    return base;
  }

  // Scroll to section method
  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = _isMobile(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      extendBodyBehindAppBar: isMobile,
      appBar: isMobile
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: theme.colorScheme.primary),
            )
          : PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                color: theme.scaffoldBackgroundColor.withOpacity(0.9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '<${ResumeData.profile.firstName}/>',
                      style: GoogleFonts.firaCode(
                        color: theme.colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        ..._sections.map((section) => _navBarItem(
                              section['title'] as String,
                              () => _scrollToSection(section['key'] as GlobalKey),
                              _activeSection == section['title'],
                            )),
                        const SizedBox(width: 20),
                        AnimatedIconButton(
                          icon: widget.currentThemeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
                          onPressed: widget.onThemeToggle,
                          color: theme.colorScheme.primary,
                          tooltip: widget.currentThemeMode == ThemeMode.dark
                              ? 'Switch to Light Mode'
                              : 'Switch to Dark Mode',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      drawer: isMobile
          ? Drawer(
              backgroundColor: theme.cardColor,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '<${ResumeData.profile.firstName}/>',
                          style: GoogleFonts.firaCode(
                            color: theme.colorScheme.primary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Menu',
                          style: GoogleFonts.roboto(
                            color: theme.textTheme.bodyMedium?.color,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ..._sections.map((section) => ListTile(
                        leading: Icon(
                          Icons.chevron_right,
                          color: _activeSection == section['title']
                              ? theme.colorScheme.primary
                              : theme.textTheme.bodyMedium?.color,
                        ),
                        title: Text(
                          section['title'] as String,
                          style: GoogleFonts.firaCode(
                            color: _activeSection == section['title']
                                ? theme.colorScheme.primary
                                : theme.textTheme.displayLarge?.color,
                            fontSize: 16,
                            fontWeight: _activeSection == section['title'] ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        selected: _activeSection == section['title'],
                        selectedTileColor: theme.scaffoldBackgroundColor,
                        onTap: () {
                          Navigator.pop(context);
                          _scrollToSection(section['key'] as GlobalKey);
                        },
                      )),
                  const Divider(),
                  ListTile(
                    leading: Icon(
                      widget.currentThemeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
                      color: theme.colorScheme.primary,
                    ),
                    title: Text(
                      widget.currentThemeMode == ThemeMode.dark ? 'Light Mode' : 'Dark Mode',
                      style: GoogleFonts.firaCode(
                        color: theme.textTheme.displayLarge?.color,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      widget.onThemeToggle();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildHeader(context),
            _loadedSections.contains('summary')
                ? SummarySection(sectionKey: aboutKey)
                : _buildPlaceholder(context, 400, key: summaryKey),
            _loadedSections.contains('skills')
                ? const SkillsSection()
                : _buildPlaceholder(context, 600, key: skillsKey),
            _loadedSections.contains('experience')
                ? ExperienceSection(sectionKey: experienceKey)
                : _buildPlaceholder(context, 800, key: experienceKey),
            _loadedSections.contains('projects')
                ? ProjectsSection(sectionKey: projectsKey)
                : _buildPlaceholder(context, 700, key: projectsKey),
            _loadedSections.contains('blogs')
                ? const BlogsSection()
                : (ResumeData.profile.blogs.isNotEmpty
                    ? _buildPlaceholder(context, 600, key: blogsKey)
                    : const SizedBox.shrink()),
            _loadedSections.contains('contact')
                ? ContactSection(sectionKey: contactKey)
                : _buildPlaceholder(context, 500, key: contactKey),
            if (ResumeData.profile.calendlyUrl != null)
              _loadedSections.contains('calendly')
                  ? const CalendlySection()
                  : _buildPlaceholder(context, 800, key: calendlyKey),
            _loadedSections.contains('footer')
                ? const FooterSection()
                : _buildPlaceholder(context, 200, key: footerKey),
          ],
        ),
      ),
    );
  }

  Widget _navBarItem(String title, VoidCallback onTap, bool isActive) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: AnimatedButton(
            onPressed: onTap,
            child: Text(
              title,
              style: GoogleFonts.firaCode(
                color: isActive ? theme.colorScheme.primary : theme.textTheme.displayLarge?.color,
                fontSize: 14,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = _isMobile(context);
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: isMobile ? null : screenHeight * 0.95,
      padding: isMobile ? const EdgeInsets.symmetric(vertical: 60) : null,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF0A192F), const Color(0xFF1A2744)]
              : [const Color(0xFFE0F2FE), const Color(0xFFF5F7FA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Animated background particles
          ...List.generate(20, (index) => _buildFloatingParticle(index)),

          // Main content
          SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60),
                child: isMobile ? _buildMobileHeroContent(context) : _buildDesktopHeroContent(context, screenWidth),
              ),
            ),
          ),

          // Scroll indicator
          if (!isMobile)
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: FadeInUpAnimation(
                delay: const Duration(milliseconds: 1800),
                child: _buildScrollIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMobileHeroContent(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        // Profile image with animation
        FadeInUpAnimation(
          delay: const Duration(milliseconds: 200),
          child: _buildAnimatedProfileImage(
            MediaQuery.sizeOf(context).width * 0.35,
          ),
        ),
        const SizedBox(height: 40),

        // Greeting text
        FadeInUpAnimation(
          delay: const Duration(milliseconds: 400),
          child: Text(
            'Hello, I\'m',
            style: GoogleFonts.roboto(
              fontSize: _getResponsiveFontSize(context, 24),
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Name with animation
        FadeInUpAnimation(
          delay: const Duration(milliseconds: 600),
          child: Text(
            ResumeData.profile.firstName,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: _getResponsiveFontSize(context, 40),
              fontWeight: FontWeight.bold,
              color: theme.textTheme.displayLarge?.color,
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Title with typewriter effect
        FadeInUpAnimation(
          delay: const Duration(milliseconds: 800),
          child: _buildAnimatedTitle(context, 24),
        ),
        const SizedBox(height: 30),

        // Brief intro
        FadeInUpAnimation(
          delay: const Duration(milliseconds: 1000),
          child: Text(
            ResumeData.profile.subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: _getResponsiveFontSize(context, 16),
              color: theme.textTheme.bodyMedium?.color,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 30),

        // Social icons
        FadeInUpAnimation(
          delay: const Duration(milliseconds: 1200),
          child: _buildSocialIcons(context),
        ),
        const SizedBox(height: 40),

        // CTA Buttons
        FadeInUpAnimation(
          delay: const Duration(milliseconds: 1400),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildCTAButton(
                'View CV',
                () async {
                  if (ResumeData.profile.resume != null) {
                    await ResumeData.profile.resume!.fold(
                      network: (n) async {
                        await _launchURL(n.uri.toString());
                      },
                      asset: (a) async {
                        await _downloadAssetFile(a.assetPath, a.name);
                      },
                      orElse: () async {},
                    );
                  }
                },
                isPrimary: true,
              ),
              _buildCTAButton(
                'View Projects',
                () => _scrollToSection(projectsKey),
                isPrimary: false,
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildFloatingParticle(int index) {
    final random = index * 17 % 100;
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return Positioned(
          top: (random % 30) * 10.0,
          left: ((random * 7) % 90) * 10.0,
          child: TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 2000 + (random % 10) * 200),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(
                  20 * (value - 0.5),
                  30 * (value - 0.5),
                ),
                child: Opacity(
                  opacity: 0.1 + (0.2 * value),
                  child: Container(
                    width: 4 + (random % 6).toDouble(),
                    height: 4 + (random % 6).toDouble(),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              );
            },
            onEnd: () {
              // Loop animation
            },
          ),
        );
      },
    );
  }

  Widget _buildCTAButton(String text, VoidCallback onPressed, {required bool isPrimary}) {
    return AnimatedCTAButton(
      text: text,
      onPressed: onPressed,
      isPrimary: isPrimary,
      isMobile: _isMobile(context),
    );
  }

  Widget _buildSocialIcons(BuildContext context) {
    final contact = ResumeData.profile.contact;
    final socialItems = <Map<String, dynamic>>[];

    if (contact.linkedinUrl != null) {
      socialItems.add({'icon': FontAwesomeIcons.linkedin, 'url': contact.linkedinUrl!});
    }
    if (contact.githubUrl != null) {
      socialItems.add({'icon': FontAwesomeIcons.github, 'url': contact.githubUrl!});
    }
    if (contact.email != null) {
      socialItems.add({'icon': Icons.mail_outline, 'url': 'mailto:${contact.email}'});
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: socialItems.map((item) {
        return AnimatedSocialIcon(
          icon: item['icon'] as IconData,
          onTap: () => _launchURL(item['url'] as String),
        );
      }).toList(),
    );
  }

  Widget _buildScrollIndicator() {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return Column(
          children: [
            Text(
              'Scroll Down',
              style: GoogleFonts.firaCode(
                fontSize: 12,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 10),
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 1500),
              tween: Tween(begin: 0.0, end: 20.0),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: theme.colorScheme.primary,
                    size: 30,
                  ),
                );
              },
              onEnd: () {
                // Loop would go here
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDesktopHeroContent(BuildContext context, double screenWidth) {
    final isLargeDesktop = screenWidth > 1440;
    final imageSize = screenWidth < 1024 ? screenWidth * 0.25 : (screenWidth < 1440 ? screenWidth * 0.2 : 280.0);
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: isLargeDesktop ? 6 : 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInUpAnimation(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  'Hello, I\'m',
                  style: GoogleFonts.roboto(
                    fontSize: _getResponsiveFontSize(context, 28),
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeInUpAnimation(
                delay: const Duration(milliseconds: 400),
                child: Text(
                  ResumeData.profile.firstName,
                  style: GoogleFonts.roboto(
                    fontSize: _getResponsiveFontSize(context, 64),
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.displayLarge?.color,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeInUpAnimation(
                delay: const Duration(milliseconds: 600),
                child: _buildAnimatedTitle(context, 32),
              ),
              const SizedBox(height: 40),
              FadeInUpAnimation(
                delay: const Duration(milliseconds: 800),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Text(
                    ResumeData.profile.subtitle,
                    style: GoogleFonts.roboto(
                      fontSize: _getResponsiveFontSize(context, 18),
                      color: theme.textTheme.bodyMedium?.color,
                      height: 1.6,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              FadeInUpAnimation(
                delay: const Duration(milliseconds: 1000),
                child: _buildSocialIcons(context),
              ),
              const SizedBox(height: 50),
              FadeInUpAnimation(
                delay: const Duration(milliseconds: 1200),
                child: Row(
                  children: [
                    _buildCTAButton(
                      'View CV',
                      () async {
                        if (ResumeData.profile.resume != null) {
                          await ResumeData.profile.resume!.fold(
                            network: (n) async {
                              await _launchURL(n.uri.toString());
                            },
                            asset: (a) async {
                              await _downloadAssetFile(a.assetPath, a.name);
                            },
                            orElse: () async {},
                          );
                        }
                      },
                      isPrimary: true,
                    ),
                    const SizedBox(width: 20),
                    _buildCTAButton('View Projects', () => _scrollToSection(projectsKey), isPrimary: false),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 80),
        Expanded(
          flex: isLargeDesktop ? 5 : 4,
          child: FadeInUpAnimation(
            delay: const Duration(milliseconds: 400),
            child: _buildAnimatedProfileImage(imageSize),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedProfileImage(double size) {
    return SizedBox(
      width: size * 1.4,
      height: size * 1.4,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedGradientBorder(size: size),
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF0A192F),
              border: Border.all(color: const Color(0xFF0A192F), width: 8),
              image: const DecorationImage(
                image: AssetImage('assets/photo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ..._buildFloatingTechIcons(size),
        ],
      ),
    );
  }

  List<Widget> _buildFloatingTechIcons(double profileSize) {
    final icons = [
      {'icon': Icons.android, 'angle': 0.0, 'color': const Color(0xFF3DDC84)},
      {'icon': Icons.flutter_dash, 'angle': 1.57, 'color': const Color(0xFF02569B)},
      {'icon': Icons.phone_iphone, 'angle': 3.14, 'color': const Color(0xFF64FFDA)},
      {'icon': Icons.apple, 'angle': 4.71, 'color': const Color(0xFF555555)},
    ];

    return icons.map((iconData) {
      return FloatingIcon(
        icon: iconData['icon'] as IconData,
        color: iconData['color'] as Color,
        angle: iconData['angle'] as double,
        radius: profileSize * 0.7,
      );
    }).toList();
  }

  Widget _buildAnimatedTitle(BuildContext context, double fontSize) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title - types once and stays
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              ResumeData.profile.title,
              textStyle: GoogleFonts.roboto(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: isDark ? const Color(0xFF8B93FF) : const Color(0xFF6366F1),
              ),
              speed: const Duration(milliseconds: 100),
            ),
          ],
          totalRepeatCount: 1,
          displayFullTextOnTap: false,
          stopPauseOnTap: false,
        ),
        // Separator
        const SizedBox(height: 8),

        // Focus list - cycles through items
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: AnimatedTextKit(
                animatedTexts: ResumeData.profile.focusList
                    .map(
                      (focus) => TypewriterAnimatedText(
                        focus,
                        textStyle: GoogleFonts.roboto(
                          fontSize: fontSize - 6,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.primary,
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                    )
                    .toList(),
                repeatForever: true,
                pause: const Duration(milliseconds: 2000),
                displayFullTextOnTap: false,
                stopPauseOnTap: false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlaceholder(BuildContext context, double height, {GlobalKey? key}) {
    final isMobile = _isMobile(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      key: key,
      padding: _getResponsivePadding(context).copyWith(
        top: isMobile ? 60 : 100,
        bottom: isMobile ? 60 : 100,
      ),
      color: theme.scaffoldBackgroundColor,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: _getMaxContentWidth(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInUpAnimation(
                delay: const Duration(milliseconds: 200),
                child: Row(
                  children: [
                    Text(
                      'About Me',
                      style: GoogleFonts.roboto(
                        fontSize: _getResponsiveFontSize(context, 32),
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
              FadeInUpAnimation(
                delay: const Duration(milliseconds: 400),
                child: Text(
                  ResumeData.profile.about,
                  style: GoogleFonts.roboto(
                    fontSize: _getResponsiveFontSize(context, 18),
                    height: 1.8,
                    color: theme.textTheme.bodyMedium?.color,
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

  Future<void> _downloadAssetFile(String assetPath, String fileName) async {
    try {
      final byteData = await rootBundle.load(assetPath);
      final bytes = byteData.buffer.asUint8List();

      final blob = web.Blob([bytes.toJS].toJS);
      final url = web.URL.createObjectURL(blob);

      final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
      anchor.href = url;
      anchor.download = fileName;
      anchor.click();

      web.URL.revokeObjectURL(url);
    } catch (e) {
      debugPrint('Could not download asset file: $e');
    }
  }
}

import 'dart:math' show cos, sin;
import 'package:cv_website/src/models/skill.dart';
import 'package:cv_website/src/models/skill_section.dart';
import 'package:cv_website/src/models/company.dart';
import 'package:cv_website/src/models/project.dart';
import 'package:cv_website/src/models/media.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:media_source/media_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:web/web.dart' as web;
import 'dart:js_interop';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'src/data/resume_data.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(const CVWebsite());
}

class CVWebsite extends StatefulWidget {
  const CVWebsite({super.key});

  @override
  State<CVWebsite> createState() => _CVWebsiteState();
}

class _CVWebsiteState extends State<CVWebsite> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.system) {
        // Get current system brightness to toggle correctly from system mode
        final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
        _themeMode = brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
      } else {
        _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
      }
    });
  }

  ThemeData get _darkTheme => ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF00FFC8), // More vibrant teal
        scaffoldBackgroundColor: const Color(0xFF0A192F), // Deep Navy
        cardColor: const Color(0xFF112240), // Lighter Navy
        textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme).apply(
          bodyColor: const Color(0xFF94A3B8), // Brighter gray-blue
          displayColor: const Color(0xFFE2E8F0), // Brighter white
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FFC8), // More vibrant teal
          secondary: Color(0xFF00FFC8),
          surface: Color(0xFF112240),
        ),
        useMaterial3: true,
      );

  ThemeData get _lightTheme => ThemeData.light().copyWith(
        primaryColor: const Color(0xFF0891E5), // More vibrant blue
        scaffoldBackgroundColor: const Color(0xFFF5F7FA), // Light gray
        cardColor: Colors.white,
        textTheme: GoogleFonts.robotoTextTheme(ThemeData.light().textTheme).apply(
          bodyColor: const Color(0xFF475569), // Slightly brighter
          displayColor: const Color(0xFF0F172A),
        ),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0891E5), // More vibrant blue
          secondary: Color(0xFF0891E5),
          surface: Colors.white,
        ),
        useMaterial3: true,
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${ResumeData.profile.name} - ${ResumeData.profile.title}',
      debugShowCheckedModeBanner: false,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: _themeMode,
      home: Banner(
        message: 'BETA',
        location: BannerLocation.topStart,
        color: const Color(0xFFFF4081),
        textStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        child: SelectionArea(
          child: CVHomePage(onThemeToggle: _toggleTheme, currentThemeMode: _themeMode),
        ),
      ),
    );
  }
}

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
    {'title': 'Work', 'key': projectsKey},
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
                        _AnimatedIconButton(
                          icon: widget.currentThemeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
                          onPressed: widget.onThemeToggle,
                          color: theme.colorScheme.primary,
                          tooltip: widget.currentThemeMode == ThemeMode.dark
                              ? 'Switch to Light Mode'
                              : 'Switch to Dark Mode',
                        ),
                        // OutlinedButton(
                        //   onPressed: () {
                        //     _launchURL(
                        //         'https://drive.google.com/file/d/1DxheH3eOao1tRIEwB1TWJQaDtm1SBOaj/view?usp=sharing');
                        //   },
                        //   style: OutlinedButton.styleFrom(
                        //     side: const BorderSide(color: Color(0xFF64FFDA)),
                        //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        //   ),
                        //   child: Text(
                        //     'Resume',
                        //     style: GoogleFonts.firaCode(
                        //       color: const Color(0xFF64FFDA),
                        //     ),
                        //   ),
                        // ),
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
                ? _buildSummarySection(context)
                : _buildPlaceholder(context, 400, key: summaryKey),
            _loadedSections.contains('skills')
                ? _buildSkillsSection(context)
                : _buildPlaceholder(context, 600, key: skillsKey),
            _loadedSections.contains('experience')
                ? _buildExperienceSection(context)
                : _buildPlaceholder(context, 800, key: experienceKey),
            _loadedSections.contains('projects')
                ? _buildProjectsSection(context)
                : _buildPlaceholder(context, 700, key: projectsKey),
            _loadedSections.contains('blogs')
                ? _buildBlogSection(context)
                : (ResumeData.profile.blogs.isNotEmpty
                    ? _buildPlaceholder(context, 600, key: blogsKey)
                    : const SizedBox.shrink()),
            _loadedSections.contains('contact')
                ? _buildContactsSection(context)
                : _buildPlaceholder(context, 500, key: contactKey),
            if (ResumeData.profile.calendlyId != null)
              _loadedSections.contains('calendly')
                  ? _buildCalendlySection(context)
                  : _buildPlaceholder(context, 800, key: calendlyKey),
            _loadedSections.contains('footer')
                ? _buildFooter(context)
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
          child: _AnimatedButton(
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
    return _AnimatedCTAButton(
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
        return _AnimatedSocialIcon(
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
          _AnimatedGradientBorder(size: size),
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
      return _FloatingIcon(
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
            _BlinkingCursor(fontSize: fontSize),
          ],
        ),
      ],
    );
  }

  Widget _buildSummarySection(BuildContext context) {
    final isMobile = _isMobile(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      key: aboutKey,
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

  Widget _buildSkillsSection(BuildContext context) {
    final skills = ResumeData.profile.skills;

    final isMobile = _isMobile(context);
    final isTablet = _isTablet(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Determine grid column count based on screen size
    // Removed unused getColumnCount()

    return Container(
      padding: _getResponsivePadding(context).copyWith(
        top: isMobile ? 60 : 100,
        bottom: isMobile ? 60 : 100,
      ),
      color: theme.cardColor,
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
                      'Skills',
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
                      fontSize: _getResponsiveFontSize(context, 20),
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

  Widget _buildExperienceSection(BuildContext context) {
    final companies = ResumeData.profile.experience;

    final isMobile = _isMobile(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      key: experienceKey,
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
                      'Work Experience',
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
              ...companies.asMap().entries.map((entry) {
                final index = entry.key;
                final company = entry.value;
                return AnimatedCompanyExperienceCard(
                  delay: Duration(milliseconds: 400 + (index * 100)),
                  company: company,
                  isMobile: isMobile,
                  titleFontSize: _getResponsiveFontSize(context, 22),
                  textFontSize: _getResponsiveFontSize(context, 16),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    final projects = ResumeData.profile.projects;

    final isMobile = _isMobile(context);
    final isTablet = _isTablet(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    int getColumnCount() {
      if (isMobile) return 1;
      if (isTablet) return 2;
      return 3;
    }

    return Container(
      key: projectsKey,
      padding: _getResponsivePadding(context).copyWith(
        top: isMobile ? 60 : 100,
        bottom: isMobile ? 60 : 100,
      ),
      color: theme.cardColor,
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
                      'Projects',
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
                        titleFontSize: _getResponsiveFontSize(context, 20),
                        descFontSize: _getResponsiveFontSize(context, 15),
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

  Widget _buildBlogSection(BuildContext context) {
    if (ResumeData.profile.blogs.isEmpty) return const SizedBox.shrink();

    final blogs = ResumeData.profile.blogs;
    final isMobile = _isMobile(context);
    final isTablet = _isTablet(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    int getColumnCount() {
      if (isMobile) return 1;
      if (isTablet) return 2;
      return 3;
    }

    return Container(
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
                      'Blog & Articles',
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
              LayoutBuilder(
                builder: (context, constraints) {
                  final columnCount = getColumnCount();
                  final spacing = isMobile ? 15.0 : 20.0;
                  final itemWidth = (constraints.maxWidth - (spacing * (columnCount - 1))) / columnCount;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: blogs.asMap().entries.map((entry) {
                      final index = entry.key;
                      final blog = entry.value;

                      // Reusing AnimatedProjectCard as a template for Blog for now
                      // In a real scenario, we'd create a specific AnimatedBlogCard
                      return AnimatedProjectCard(
                        delay: Duration(milliseconds: 400 + (index * 100)),
                        width: isMobile ? double.infinity : itemWidth,
                        project: Project(
                          title: blog.title,
                          description: blog.description,
                          media: [
                            Media(
                              media: blog.url,
                              title: blog.title,
                              type: MediaType.link,
                            )
                          ],
                          skills: blog.skills, // Mapping skills to technologies for display
                        ),
                        titleFontSize: _getResponsiveFontSize(context, 20),
                        descFontSize: _getResponsiveFontSize(context, 15),
                        onTap: () {
                          if (blog.url is UrlMedia) {
                            _launchURL((blog.url as UrlMedia).uri.toString());
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

  Widget _buildContactsSection(BuildContext context) {
    final contact = ResumeData.profile.contact;
    final isMobile = _isMobile(context);
    final theme = Theme.of(context);

    return Container(
      key: contactKey,
      padding: _getResponsivePadding(context).copyWith(
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
                        fontSize: _getResponsiveFontSize(context, 48),
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
                    fontSize: _getResponsiveFontSize(context, 18),
                    height: 1.6,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              FadeInUpAnimation(
                delay: const Duration(milliseconds: 600),
                child: _AnimatedOutlinedButton(
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

  Widget _buildCalendlySection(BuildContext context) {
    final isMobile = _isMobile(context);
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      color: theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 60 : 100,
            ),
            child: Column(
              children: [
                FadeInUpAnimation(
                  delay: const Duration(milliseconds: 200),
                  child: Column(
                    children: [
                      Text(
                        'Schedule a Meeting',
                        style: GoogleFonts.roboto(
                          fontSize: _getResponsiveFontSize(context, 32),
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.displayLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Let\'s connect and discuss your project',
                        style: GoogleFonts.roboto(
                          fontSize: _getResponsiveFontSize(context, 18),
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          FadeInUpAnimation(
            delay: const Duration(milliseconds: 400),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: isMobile ? 600 : 700,
              ),
              color: theme.cardColor,
              child: CalendlyWidget(
                id: ResumeData.profile.calendlyId ?? '',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context, double height, {GlobalKey? key}) {
    final theme = Theme.of(context);
    return Container(
      key: key,
      height: height,
      color: theme.scaffoldBackgroundColor,
      child: Center(
        child: SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              theme.colorScheme.primary.withOpacity(0.3),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: _isMobile(context) ? 40 : 50,
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
                  _buildFooterIcon(FontAwesomeIcons.linkedin, ResumeData.profile.contact.linkedinUrl!),
                if (ResumeData.profile.contact.githubUrl != null)
                  _buildFooterIcon(FontAwesomeIcons.github, ResumeData.profile.contact.githubUrl!),
                if (ResumeData.profile.contact.email != null)
                  _buildFooterIcon(Icons.mail_outline, 'mailto:${ResumeData.profile.contact.email}'),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Built with Flutter',
              style: GoogleFonts.firaCode(
                fontSize: _getResponsiveFontSize(context, 14),
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'With help from Claude, GitHub Copilot & Antigravity',
              style: GoogleFonts.roboto(
                fontSize: _getResponsiveFontSize(context, 12),
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              '© ${DateTime.now().year} ${ResumeData.profile.firstName}',
              style: GoogleFonts.roboto(
                fontSize: _getResponsiveFontSize(context, 14),
                color: theme.textTheme.bodyMedium?.color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterIcon(IconData icon, String url) {
    return _AnimatedIconButton(
      icon: icon,
      onPressed: () => _launchURL(url),
      size: 24,
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

// Animation Widget Components

class FadeInUpAnimation extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const FadeInUpAnimation({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  State<FadeInUpAnimation> createState() => _FadeInUpAnimationState();
}

class _FadeInUpAnimationState extends State<FadeInUpAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _offset = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _offset,
        child: widget.child,
      ),
    );
  }
}

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
              return _SkillPill(skill: skill, isDark: isDark);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _SkillPill extends StatefulWidget {
  final Skill skill;
  final bool isDark;

  const _SkillPill({
    required this.skill,
    required this.isDark,
  });

  @override
  State<_SkillPill> createState() => _SkillPillState();
}

class _SkillPillState extends State<_SkillPill> {
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
        dotColor = const Color(0xFF00E676); // More vibrant green
        dotGlowColor = const Color(0xFF69F0AE); // Brighter green glow
        proficiencyText = '80%+';
        break;
      case SkillProficiency.advanced:
        dotColor = const Color(0xFFFF6D00); // More vibrant orange
        dotGlowColor = const Color(0xFFFFAB40); // Brighter orange glow
        proficiencyText = '60%';
        break;
      case SkillProficiency.intermediate:
        dotColor = const Color(0xFF00E5FF); // More vibrant cyan
        dotGlowColor = const Color(0xFF84FFFF); // Brighter cyan glow
        proficiencyText = '40%';
        break;
      case SkillProficiency.beginner:
        dotColor = const Color(0xFFFF4081); // More vibrant pink
        dotGlowColor = const Color(0xFFFF80AB); // Brighter pink glow
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
    // If company has no experiences, we might still want to show it or hide it.
    // Assuming company always has at least one experience or we show empty card.
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
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: widget.project.skills.take(5).map((s) {
                    return Text(
                      s.name,
                      style: GoogleFonts.firaCode(
                        fontSize: 13,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Animated Gradient Border for Profile Image
class _AnimatedGradientBorder extends StatefulWidget {
  final double size;

  const _AnimatedGradientBorder({required this.size});

  @override
  State<_AnimatedGradientBorder> createState() => _AnimatedGradientBorderState();
}

class _AnimatedGradientBorderState extends State<_AnimatedGradientBorder> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 6.28,
          child: Container(
            width: widget.size * 1.1,
            height: widget.size * 1.1,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: const [
                  Color(0xFF00FFC8), // Vibrant teal
                  Color(0xFF00E5FF), // Vibrant cyan
                  Color(0xFF7C4DFF), // Vibrant purple
                  Color(0xFFFF4081), // Vibrant pink
                  Color(0xFF00FFC8), // Back to teal
                ],
                stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
                transform: GradientRotation(_controller.value * 6.28),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00FFC8).withOpacity(0.7),
                  blurRadius: 50,
                  spreadRadius: 8,
                ),
                BoxShadow(
                  color: const Color(0xFF7C4DFF).withOpacity(0.5),
                  blurRadius: 35,
                  spreadRadius: 4,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Floating Icon Widget
class _FloatingIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final double angle;
  final double radius;

  const _FloatingIcon({
    required this.icon,
    required this.color,
    required this.angle,
    required this.radius,
  });

  @override
  State<_FloatingIcon> createState() => _FloatingIconState();
}

class _FloatingIconState extends State<_FloatingIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final animatedAngle = widget.angle + (_controller.value * 0.2);
        return Transform.translate(
          offset: Offset(
            widget.radius * cos(animatedAngle),
            widget.radius * sin(animatedAngle),
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A2744) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? const Color(0xFF233554) : const Color(0xFFE2E8F0),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              widget.icon,
              color: widget.color,
              size: 24,
            ),
          ),
        );
      },
    );
  }
}

// Blinking Cursor Widget
class _BlinkingCursor extends StatefulWidget {
  final double fontSize;

  const _BlinkingCursor({required this.fontSize});

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FadeTransition(
      opacity: _controller,
      child: Text(
        '_',
        style: GoogleFonts.roboto(
          fontSize: widget.fontSize,
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}

// Animated Button Widgets
class _AnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;

  const _AnimatedButton({
    required this.child,
    required this.onPressed,
  });

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: TextButton(
          onPressed: widget.onPressed,
          child: widget.child,
        ),
      ),
    );
  }
}

class _AnimatedIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double? size;
  final Color? color;
  final String? tooltip;

  const _AnimatedIconButton({
    required this.icon,
    required this.onPressed,
    this.size,
    this.color,
    this.tooltip,
  });

  @override
  State<_AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<_AnimatedIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedScale(
          scale: _isHovered ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: IconButton(
            onPressed: widget.onPressed,
            icon: Icon(widget.icon),
            color: widget.color ?? theme.textTheme.bodyMedium?.color,
            iconSize: widget.size,
            tooltip: widget.tooltip,
          ),
        ),
      ),
    );
  }
}

class _AnimatedOutlinedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final ButtonStyle? style;

  const _AnimatedOutlinedButton({
    required this.onPressed,
    required this.child,
    this.style,
  });

  @override
  State<_AnimatedOutlinedButton> createState() => _AnimatedOutlinedButtonState();
}

class _AnimatedOutlinedButtonState extends State<_AnimatedOutlinedButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: OutlinedButton(
          onPressed: widget.onPressed,
          style: widget.style,
          child: widget.child,
        ),
      ),
    );
  }
}

class _AnimatedSocialIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _AnimatedSocialIcon({
    required this.icon,
    required this.onTap,
  });

  @override
  State<_AnimatedSocialIcon> createState() => _AnimatedSocialIconState();
}

class _AnimatedSocialIconState extends State<_AnimatedSocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isMobile = MediaQuery.sizeOf(context).width < 600;

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedScale(
          scale: _isHovered ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(isMobile ? 12 : 14),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1A2744) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isHovered
                      ? theme.colorScheme.primary
                      : (isDark ? const Color(0xFF233554) : const Color(0xFFE2E8F0)),
                  width: 1,
                ),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: theme.colorScheme.primary.withOpacity(0.7),
                          blurRadius: 20,
                          spreadRadius: 4,
                        ),
                        BoxShadow(
                          color: theme.colorScheme.primary.withOpacity(0.4),
                          blurRadius: 30,
                          spreadRadius: 2,
                        ),
                      ]
                    : [],
              ),
              child: Icon(
                widget.icon,
                color: _isHovered ? theme.colorScheme.primary : theme.textTheme.bodyMedium?.color,
                size: isMobile ? 20 : 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedCTAButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isMobile;

  const _AnimatedCTAButton({
    required this.text,
    required this.onPressed,
    required this.isPrimary,
    required this.isMobile,
  });

  @override
  State<_AnimatedCTAButton> createState() => _AnimatedCTAButtonState();
}

class _AnimatedCTAButtonState extends State<_AnimatedCTAButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
              horizontal: widget.isMobile ? 24 : 32,
              vertical: widget.isMobile ? 14 : 18,
            ),
            decoration: BoxDecoration(
              gradient: widget.isPrimary
                  ? LinearGradient(
                      colors: isDark
                          ? [const Color(0xFF5A9FFF), const Color(0xFF64FFDA)]
                          : [const Color(0xFF0EA5E9), const Color(0xFF06B6D4)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : null,
              borderRadius: BorderRadius.circular(50),
              border: widget.isPrimary
                  ? null
                  : Border.all(
                      color:
                          _isHovered ? theme.colorScheme.primary : (theme.textTheme.bodyMedium?.color ?? Colors.grey),
                      width: 2,
                    ),
              boxShadow: _isHovered && widget.isPrimary
                  ? [
                      BoxShadow(
                        color: (isDark ? const Color(0xFF64FFDA) : const Color(0xFF0EA5E9)).withOpacity(0.4),
                        blurRadius: 16,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.text,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: widget.isPrimary
                        ? Colors.white
                        : (_isHovered ? theme.colorScheme.primary : theme.textTheme.displayLarge?.color),
                  ),
                ),
                if (widget.isPrimary) ...[
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 18, color: Colors.white),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Calendly Widget using WebView
class CalendlyWidget extends StatefulWidget {
  final String id;
  const CalendlyWidget({super.key, required this.id});

  @override
  State<CalendlyWidget> createState() => _CalendlyWidgetState();
}

class _CalendlyWidgetState extends State<CalendlyWidget> {
  late InAppWebViewController _controller;
  late bool _isDark;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _isDark = false;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final currentTheme = Theme.of(context).brightness == Brightness.dark;
    if (currentTheme != _isDark) {
      setState(() {
        _isDark = currentTheme;
        _isLoading = true;
      });
      await _loadCalendlyUrl();
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadCalendlyUrl() async {
    if (_isLoading) return;
    // Calendly URL with theme customization
    if (!mounted) return;

    final baseUrl = 'https://calendly.com/${widget.id}';
    final backgroundColor = _isDark ? '0a192f' : 'ffffff';
    final textColor = _isDark ? 'ccd6f6' : '0f172a';
    final primaryColor = _isDark ? '64ffda' : '0ea5e9';

    final themedUrl = '$baseUrl?'
        'background_color=$backgroundColor&'
        'text_color=$textColor&'
        'primary_color=$primaryColor&'
        'hide_event_type_details=0&'
        'hide_gdpr_banner=1';

    await _controller.loadUrl(urlRequest: URLRequest(url: WebUri(themedUrl)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      constraints: const BoxConstraints(maxHeight: 700),
      width: double.infinity,
      child: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri('https://calendly.com/${widget.id}'),
            ),
            initialSettings: InAppWebViewSettings(
              verticalScrollBarEnabled: false,
              disableVerticalScroll: true,
              overScrollMode: OverScrollMode.IF_CONTENT_SCROLLS,
            ),
            onWebViewCreated: (controller) {
              _controller = controller;
              _loadCalendlyUrl();
            },
            onLoadStop: (controller, url) async {
              // Inject CSS to disable scrolling
              await controller.evaluateJavascript(source: '''
                var style = document.createElement('style');
                style.innerHTML = 'body, html { overflow: hidden !important; height: 100% !important; }';
                document.head.appendChild(style);
              ''');
              setState(() {
                _isLoading = false;
              });
            },
          ),
          if (_isLoading)
            Container(
              color: theme.cardColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Loading calendar...',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
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
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}

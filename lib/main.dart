import 'dart:math' show cos, sin;
import 'package:cv_website/src/models/skill_section.dart';
import 'package:cv_website/src/models/company.dart';
import 'package:cv_website/src/models/project.dart';
import 'package:cv_website/src/models/media.dart';
import 'package:media_source/media_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:html' as html;
import 'src/data/resume_data.dart';

void main() {
  runApp(const CVWebsite());
}

class CVWebsite extends StatelessWidget {
  const CVWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${ResumeData.profile.name} - ${ResumeData.profile.title}',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.tealAccent,
        scaffoldBackgroundColor: const Color(0xFF0A192F), // Deep Navy
        cardColor: const Color(0xFF112240), // Lighter Navy
        textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme).apply(
          bodyColor: const Color(0xFF8892B0),
          displayColor: const Color(0xFFCCD6F6),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF64FFDA), // Teal
          secondary: Color(0xFF64FFDA),
          surface: Color(0xFF112240),
        ),
        useMaterial3: true,
      ),
      home: const SelectionArea(child: CVHomePage()),
    );
  }
}

class CVHomePage extends StatefulWidget {
  const CVHomePage({super.key});

  @override
  State<CVHomePage> createState() => _CVHomePageState();
}

class _CVHomePageState extends State<CVHomePage> {
  // GlobalKeys for section navigation
  static final GlobalKey aboutKey = GlobalKey();
  static final GlobalKey experienceKey = GlobalKey();
  static final GlobalKey projectsKey = GlobalKey();
  static final GlobalKey contactKey = GlobalKey();

  // Section configuration
  static final List<Map<String, dynamic>> _sections = [
    {'title': 'About', 'key': aboutKey},
    {'title': 'Experience', 'key': experienceKey},
    {'title': 'Work', 'key': projectsKey},
    {'title': 'Contact', 'key': contactKey},
  ];

  final ScrollController _scrollController = ScrollController();
  String _activeSection = 'About';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
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

    String newActiveSection = _sections.first['title'];

    // Check sections in reverse order (bottom to top) to find the active one
    for (var i = _sections.length - 1; i >= 0; i--) {
      final section = _sections[i];
      final position = _getSectionPosition(section['key'] as GlobalKey);

      if (position != null && scrollPosition >= position - screenHeight / 3) {
        newActiveSection = section['title'] as String;
        break;
      }
    }

    if (newActiveSection != _activeSection) {
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

    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      appBar: isMobile
          ? AppBar(
              backgroundColor: const Color(0xFF0A192F),
              elevation: 0,
              iconTheme: const IconThemeData(color: Color(0xFF64FFDA)),
            )
          : PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                color: const Color(0xFF0A192F).withOpacity(0.9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '<${ResumeData.profile.firstName}/>',
                      style: GoogleFonts.firaCode(
                        color: const Color(0xFF64FFDA),
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
                        // const SizedBox(width: 20),
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
              backgroundColor: const Color(0xFF112240),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color(0xFF0A192F),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '<${ResumeData.profile.firstName}/>',
                          style: GoogleFonts.firaCode(
                            color: const Color(0xFF64FFDA),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Menu',
                          style: GoogleFonts.roboto(
                            color: const Color(0xFF8892B0),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ..._sections.map((section) => ListTile(
                        leading: Icon(
                          Icons.chevron_right,
                          color: _activeSection == section['title'] ? const Color(0xFF64FFDA) : const Color(0xFF8892B0),
                        ),
                        title: Text(
                          section['title'] as String,
                          style: GoogleFonts.firaCode(
                            color:
                                _activeSection == section['title'] ? const Color(0xFF64FFDA) : const Color(0xFFCCD6F6),
                            fontSize: 16,
                            fontWeight: _activeSection == section['title'] ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        selected: _activeSection == section['title'],
                        selectedTileColor: const Color(0xFF0A192F),
                        onTap: () {
                          Navigator.pop(context);
                          _scrollToSection(section['key'] as GlobalKey);
                        },
                      )),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildHeader(context),
            _buildSummarySection(context),
            _buildSkillsSection(context),
            _buildExperienceSection(context),
            _buildProjectsSection(context),
            // _buildProjectsSection(context), // Removing duplicate
            _buildBlogSection(context),
            _buildContactsSection(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _navBarItem(String title, VoidCallback onTap, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title,
          style: GoogleFonts.firaCode(
            color: isActive ? const Color(0xFF64FFDA) : const Color(0xFFCCD6F6),
            fontSize: 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = _isMobile(context);
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Container(
      height: isMobile ? screenHeight * 0.85 : screenHeight * 0.95,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A192F), Color(0xFF1A2744)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Animated background particles
          ...List.generate(20, (index) => _buildFloatingParticle(index)),

          // Main content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60),
              child: isMobile ? _buildMobileHeroContent(context) : _buildDesktopHeroContent(context, screenWidth),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
              color: const Color(0xFF64FFDA),
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
              color: Colors.white,
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
              color: const Color(0xFF8892B0),
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
                () {
                  // TODO: Scroll to projects
                },
                isPrimary: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingParticle(int index) {
    final random = index * 17 % 100;
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
                  color: const Color(0xFF64FFDA),
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
  }

  Widget _buildCTAButton(String text, VoidCallback onPressed, {required bool isPrimary}) {
    return Builder(
      builder: (context) {
        final isMobile = _isMobile(context);
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(50),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 32,
                vertical: isMobile ? 14 : 18,
              ),
              decoration: BoxDecoration(
                gradient: isPrimary
                    ? const LinearGradient(
                        colors: [Color(0xFF5A9FFF), Color(0xFF64FFDA)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )
                    : null,
                borderRadius: BorderRadius.circular(50),
                border: isPrimary
                    ? null
                    : Border.all(
                        color: const Color(0xFF8892B0),
                        width: 2,
                      ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isPrimary ? Colors.white : const Color(0xFFCCD6F6),
                    ),
                  ),
                  if (isPrimary) ...[
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 18, color: Colors.white),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSocialIcons(BuildContext context) {
    final contact = ResumeData.profile.contact;
    final socialItems = <Map<String, dynamic>>[];

    if (contact.linkedinUrl != null) {
      socialItems.add({'icon': Icons.business, 'url': contact.linkedinUrl!});
    }
    if (contact.githubUrl != null) {
      socialItems.add({'icon': Icons.code, 'url': contact.githubUrl!});
    }
    if (contact.email != null) {
      socialItems.add({'icon': Icons.email, 'url': 'mailto:${contact.email}'});
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: socialItems.map((item) {
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _launchURL(item['url'] as String),
              child: Container(
                padding: EdgeInsets.all(_isMobile(context) ? 12 : 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2744),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF233554),
                    width: 1,
                  ),
                ),
                child: Icon(
                  item['icon'] as IconData,
                  color: const Color(0xFF8892B0),
                  size: _isMobile(context) ? 20 : 22,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildScrollIndicator() {
    return Column(
      children: [
        Text(
          'Scroll Down',
          style: GoogleFonts.firaCode(
            fontSize: 12,
            color: const Color(0xFF64FFDA),
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
                color: const Color(0xFF64FFDA),
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
  }

  Widget _buildDesktopHeroContent(BuildContext context, double screenWidth) {
    final isLargeDesktop = screenWidth > 1440;
    final imageSize = screenWidth < 1024 ? screenWidth * 0.25 : (screenWidth < 1440 ? screenWidth * 0.2 : 280.0);

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
                    color: const Color(0xFF64FFDA),
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
                    color: Colors.white,
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
                      color: const Color(0xFF8892B0),
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
                    _buildCTAButton('View Projects', () {}, isPrimary: false),
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
                color: const Color(0xFF8B93FF),
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
                          color: const Color(0xFF64FFDA),
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

    return Container(
      key: aboutKey,
      padding: _getResponsivePadding(context).copyWith(
        top: isMobile ? 60 : 100,
        bottom: isMobile ? 60 : 100,
      ),
      color: const Color(0xFF0A192F),
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
                      '01.',
                      style: GoogleFonts.firaCode(
                        fontSize: _getResponsiveFontSize(context, 24),
                        color: const Color(0xFF64FFDA),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'About Me',
                      style: GoogleFonts.roboto(
                        fontSize: _getResponsiveFontSize(context, 32),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFCCD6F6),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xFF233554),
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
                    color: const Color(0xFF8892B0),
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

    // Determine grid column count based on screen size
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
      color: const Color(0xFF112240),
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
                      '02.',
                      style: GoogleFonts.firaCode(
                        fontSize: _getResponsiveFontSize(context, 24),
                        color: const Color(0xFF64FFDA),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Skills',
                      style: GoogleFonts.roboto(
                        fontSize: _getResponsiveFontSize(context, 32),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFCCD6F6),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xFF233554),
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
                    children: skills.asMap().entries.map((entry) {
                      final index = entry.key;
                      final skillGroup = entry.value;

                      return AnimatedSkillCard(
                        delay: Duration(milliseconds: 400 + (index * 100)),
                        width: isMobile ? double.infinity : itemWidth,
                        skillGroup: skillGroup,
                        fontSize: _getResponsiveFontSize(context, 20),
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

  Widget _buildExperienceSection(BuildContext context) {
    final companies = ResumeData.profile.experience;

    final isMobile = _isMobile(context);

    return Container(
      key: experienceKey,
      padding: _getResponsivePadding(context).copyWith(
        top: isMobile ? 60 : 100,
        bottom: isMobile ? 60 : 100,
      ),
      color: const Color(0xFF0A192F),
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
                      '03.',
                      style: GoogleFonts.firaCode(
                        fontSize: _getResponsiveFontSize(context, 24),
                        color: const Color(0xFF64FFDA),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Work Experience',
                      style: GoogleFonts.roboto(
                        fontSize: _getResponsiveFontSize(context, 32),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFCCD6F6),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xFF233554),
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
      color: const Color(0xFF112240),
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
                      '04.',
                      style: GoogleFonts.firaCode(
                        fontSize: _getResponsiveFontSize(context, 24),
                        color: const Color(0xFF64FFDA),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Featured Projects',
                      style: GoogleFonts.roboto(
                        fontSize: _getResponsiveFontSize(context, 32),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFCCD6F6),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xFF233554),
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
      color: const Color(0xFF0A192F),
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
                      '05.',
                      style: GoogleFonts.firaCode(
                        fontSize: _getResponsiveFontSize(context, 24),
                        color: const Color(0xFF64FFDA),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Blog & Articles',
                      style: GoogleFonts.roboto(
                        fontSize: _getResponsiveFontSize(context, 32),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFCCD6F6),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xFF233554),
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

    return Container(
      key: contactKey,
      padding: _getResponsivePadding(context).copyWith(
        top: isMobile ? 60 : 100,
        bottom: isMobile ? 60 : 100,
      ),
      color: const Color(0xFF112240),
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
                      '06. What\'s Next?',
                      style: GoogleFonts.firaCode(
                        fontSize: _getResponsiveFontSize(context, 18),
                        color: const Color(0xFF64FFDA),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Get In Touch',
                      style: GoogleFonts.roboto(
                        fontSize: _getResponsiveFontSize(context, 48),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFCCD6F6),
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
                    color: const Color(0xFF8892B0),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              FadeInUpAnimation(
                delay: const Duration(milliseconds: 600),
                child: OutlinedButton(
                  onPressed: () {
                    if (contact.email != null) {
                      _launchURL('mailto:${contact.email}');
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF64FFDA), width: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'Say Hello',
                    style: GoogleFonts.firaCode(
                      color: const Color(0xFF64FFDA),
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

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: _isMobile(context) ? 40 : 50,
        horizontal: 20,
      ),
      color: const Color(0xFF0A192F),
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (ResumeData.profile.contact.linkedinUrl != null)
                  _buildFooterIcon(Icons.business, ResumeData.profile.contact.linkedinUrl!),
                if (ResumeData.profile.contact.githubUrl != null)
                  _buildFooterIcon(Icons.code, ResumeData.profile.contact.githubUrl!),
                if (ResumeData.profile.contact.email != null)
                  _buildFooterIcon(Icons.email, 'mailto:${ResumeData.profile.contact.email}'),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Built with Flutter',
              style: GoogleFonts.firaCode(
                fontSize: _getResponsiveFontSize(context, 14),
                color: const Color(0xFF64FFDA),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '© ${DateTime.now().year} ${ResumeData.profile.firstName}',
              style: GoogleFonts.roboto(
                fontSize: _getResponsiveFontSize(context, 14),
                color: const Color(0xFF8892B0),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterIcon(IconData icon, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _launchURL(url),
          child: Icon(
            icon,
            color: const Color(0xFF8892B0),
            size: 24,
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

      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);

      html.AnchorElement(href: url)
        ..setAttribute('download', fileName)
        ..click();

      html.Url.revokeObjectUrl(url);
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
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return FadeInUpAnimation(
      delay: widget.delay,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF0A192F),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered ? const Color(0xFF64FFDA) : const Color(0xFF233554),
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFF64FFDA).withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [],
          ),
          transform: Matrix4.translationValues(0.0, _isHovered ? -8.0 : 0.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.skillGroup.category,
                style: GoogleFonts.roboto(
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFCCD6F6),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.skillGroup.skills.map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF233554),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      skill.name,
                      style: GoogleFonts.firaCode(
                        color: const Color(0xFF64FFDA),
                        fontSize: 13,
                      ),
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
            color: const Color(0xFF112240),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered ? const Color(0xFF64FFDA) : const Color(0xFF233554),
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFF64FFDA).withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
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
                            network: (n) => Image.network(
                              n.uri.toString(),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A2744),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.business,
                                    color: Color(0xFF64FFDA),
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
                                    color: const Color(0xFF1A2744),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.business,
                                    color: Color(0xFF64FFDA),
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
                            color: const Color(0xFFCCD6F6),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${widget.company.dateRange.forResume} · ${widget.company.totalDuration}',
                          style: GoogleFonts.roboto(
                            fontSize: widget.textFontSize * 0.9,
                            color: const Color(0xFF8892B0),
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
                final isFirst = index == 0;
                final hasMultipleExperiences = widget.company.experiences.length > 1;
                final isLast = index == widget.company.experiences.length - 1;

                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Timeline Line and Dot
                      if (hasMultipleExperiences)
                        SizedBox(
                          width: widget.isMobile ? 32 : 40,
                          child: Column(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isFirst ? const Color(0xFF64FFDA) : const Color(0xFF233554),
                                  border: Border.all(color: const Color(0xFF64FFDA), width: 2),
                                ),
                              ),
                              if (!isLast)
                                Expanded(
                                  child: Container(
                                    width: 2,
                                    color: const Color(0xFF233554),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      const SizedBox(width: 8),
                      // Role Details
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: isLast ? 0 : 32.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.isMobile
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          exp.title,
                                          style: GoogleFonts.roboto(
                                            fontSize: widget.titleFontSize * 0.9,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF64FFDA),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          exp.dateRange.forResume,
                                          style: GoogleFonts.roboto(
                                            fontSize: widget.textFontSize * 0.9,
                                            color: const Color(0xFF8892B0),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            exp.title,
                                            style: GoogleFonts.roboto(
                                              fontSize: widget.titleFontSize * 0.9,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF64FFDA),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          exp.dateRange.forResume,
                                          style: GoogleFonts.roboto(
                                            fontSize: widget.textFontSize * 0.9,
                                            color: const Color(0xFF8892B0),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                              const SizedBox(height: 4),
                              Text(
                                '${exp.location} · ${exp.employmentType}',
                                style: GoogleFonts.roboto(
                                  fontSize: widget.textFontSize * 0.85,
                                  color: const Color(0xFF8892B0),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                exp.description,
                                style: GoogleFonts.roboto(
                                  fontSize: widget.textFontSize,
                                  height: 1.6,
                                  color: const Color(0xFF8892B0),
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
              color: const Color(0xFF0A192F),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _isHovered ? const Color(0xFF64FFDA) : const Color(0xFF233554),
                width: 1,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: const Color(0xFF64FFDA).withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
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
                      color: const Color(0xFF64FFDA),
                      size: 40,
                    ),
                    if (widget.onTap != null)
                      Icon(
                        Icons.open_in_new,
                        color: const Color(0xFF8892B0),
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
                    color: const Color(0xFFCCD6F6),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.project.description,
                  style: GoogleFonts.roboto(
                    fontSize: widget.descFontSize,
                    height: 1.6,
                    color: const Color(0xFF8892B0),
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
                        color: const Color(0xFF8892B0),
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
                  Color(0xFF64FFDA),
                  Color(0xFF5A9FFF),
                  Color(0xFF8B5CF6),
                  Color(0xFF64FFDA),
                ],
                stops: const [0.0, 0.33, 0.66, 1.0],
                transform: GradientRotation(_controller.value * 6.28),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF64FFDA).withOpacity(0.5),
                  blurRadius: 40,
                  spreadRadius: 5,
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
              color: const Color(0xFF1A2744),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF233554),
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
    return FadeTransition(
      opacity: _controller,
      child: Text(
        '_',
        style: GoogleFonts.roboto(
          fontSize: widget.fontSize,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF64FFDA),
        ),
      ),
    );
  }
}

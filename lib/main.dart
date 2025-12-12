import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(const CVWebsite());
}

class CVWebsite extends StatelessWidget {
  const CVWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Professional CV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme(),
        useMaterial3: true,
      ),
      home: const CVHomePage(),
    );
  }
}

class CVHomePage extends StatelessWidget {
  const CVHomePage({super.key});

  // Helper method to determine if screen is mobile
  bool _isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  // Helper method to determine if screen is tablet
  bool _isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1024;
  }

  // Get responsive padding
  EdgeInsets _getResponsivePadding(BuildContext context) {
    if (_isMobile(context)) {
      return const EdgeInsets.all(20);
    } else if (_isTablet(context)) {
      return const EdgeInsets.all(30);
    }
    return const EdgeInsets.all(40);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildSummarySection(context),
            _buildSkillsSection(context),
            _buildExperienceSection(context),
            _buildProjectsSection(context),
            _buildContactsSection(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = _isMobile(context);
    final isTablet = _isTablet(context);
    
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 40 : (isTablet ? 50 : 60),
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blue.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 600),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: CircleAvatar(
                  radius: isMobile ? 40 : (isTablet ? 50 : 60),
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: isMobile ? 55 : (isTablet ? 70 : 80),
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Hossam Eldin Mahmoud',
                    textStyle: GoogleFonts.roboto(
                      fontSize: _getResponsiveFontSize(context, 48),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 1,
              ),
              const SizedBox(height: 10),
              FadeInUpAnimation(
                delay: const Duration(milliseconds: 1000),
                child: Text(
                  'Flutter Developer | Mobile Engineer',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: _getResponsiveFontSize(context, 24),
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context) {
    return FadeInUpAnimation(
      delay: const Duration(milliseconds: 200),
      child: Container(
        padding: _getResponsivePadding(context),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Summary',
                  style: GoogleFonts.roboto(
                    fontSize: _getResponsiveFontSize(context, 32),
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Experienced Flutter developer with a background in Mechanical Engineering. '
                  'Specialized in mobile application development with expertise in creating open-source packages '
                  'and SDKs. Strong track record of building production-ready Flutter applications and contributing '
                  'to the developer community through published packages on pub.dev.',
                  style: GoogleFonts.roboto(
                    fontSize: _getResponsiveFontSize(context, 18),
                    height: 1.6,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    final skills = [
      {'category': 'Mobile Development', 'items': ['Flutter', 'Dart', 'iOS', 'Android', 'SDK Development']},
      {'category': 'Programming Languages', 'items': ['Dart', 'JavaScript', 'TypeScript', 'Python', 'Java']},
      {'category': 'Tools & Technologies', 'items': ['Git', 'Firebase', 'REST APIs', 'CI/CD', 'Package Publishing']},
      {'category': 'Soft Skills', 'items': ['Open Source', 'Problem Solving', 'Team Collaboration', 'Technical Writing']},
    ];

    final isMobile = _isMobile(context);
    final isTablet = _isTablet(context);
    
    // Determine grid column count based on screen size
    int getColumnCount() {
      if (isMobile) return 1;
      if (isTablet) return 2;
      return 3;
    }

    return FadeInUpAnimation(
      delay: const Duration(milliseconds: 300),
      child: Container(
        padding: _getResponsivePadding(context),
        color: Colors.white,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Skills',
                  style: GoogleFonts.roboto(
                    fontSize: _getResponsiveFontSize(context, 32),
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 30),
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
      ),
    );
  }

  Widget _buildExperienceSection(BuildContext context) {
    final experiences = [
      {
        'title': 'Senior Software Engineer',
        'company': 'Tech Company Inc.',
        'period': '2020 - Present',
        'description': 'Led development of multiple high-impact projects using modern technologies. '
            'Mentored junior developers and established best practices for the team.',
      },
      {
        'title': 'Software Developer',
        'company': 'Innovation Labs',
        'period': '2018 - 2020',
        'description': 'Developed and maintained web and mobile applications. '
            'Collaborated with cross-functional teams to deliver quality software solutions.',
      },
      {
        'title': 'Junior Developer',
        'company': 'StartUp Co.',
        'period': '2016 - 2018',
        'description': 'Built responsive web applications and contributed to various projects. '
            'Gained experience in full-stack development and agile methodologies.',
      },
    ];

    final isMobile = _isMobile(context);

    return FadeInUpAnimation(
      delay: const Duration(milliseconds: 400),
      child: Container(
        padding: _getResponsivePadding(context),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Work Experience',
                  style: GoogleFonts.roboto(
                    fontSize: _getResponsiveFontSize(context, 32),
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 30),
                ...experiences.asMap().entries.map((entry) {
                  final index = entry.key;
                  final exp = entry.value;
                  
                  return AnimatedExperienceCard(
                    delay: Duration(milliseconds: 500 + (index * 100)),
                    experience: exp,
                    isMobile: isMobile,
                    titleFontSize: _getResponsiveFontSize(context, 22),
                    textFontSize: _getResponsiveFontSize(context, 16),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    final projects = [
      {
        'name': 'Tawakkalna SDK Flutter',
        'description': 'Flutter SDK integration for the Tawakkalna government application, '
            'enabling secure identity verification and COVID-19 health status integration.',
        'technologies': ['Flutter', 'Dart', 'SDK Development'],
        'url': 'https://pub.dev/packages/tawakkalna_sdk_flutter',
      },
      {
        'name': 'Media Source',
        'description': 'Flutter package for advanced media handling and source management, '
            'providing seamless media integration capabilities.',
        'technologies': ['Flutter', 'Dart', 'Media APIs'],
        'url': 'https://pub.dev/packages/media_source',
      },
      {
        'name': 'File Type Plus',
        'description': 'Enhanced file type detection package for Flutter applications, '
            'supporting comprehensive file format identification.',
        'technologies': ['Flutter', 'Dart', 'File Systems'],
        'url': 'https://pub.dev/packages/file_type_plus',
      },
      {
        'name': 'File Sized',
        'description': 'Utility package for file size formatting and management in Flutter, '
            'simplifying file size operations and display.',
        'technologies': ['Flutter', 'Dart', 'Utilities'],
        'url': 'https://pub.dev/packages/file_sized',
      },
      {
        'name': 'Time of Day',
        'description': 'Time management and formatting package for Flutter applications, '
            'providing intuitive time selection and display features.',
        'technologies': ['Flutter', 'Dart', 'UI Components'],
        'url': 'https://pub.dev/packages/time_of_day',
      },
    ];

    final isMobile = _isMobile(context);
    final isTablet = _isTablet(context);
    
    int getColumnCount() {
      if (isMobile) return 1;
      if (isTablet) return 2;
      return 3;
    }

    return FadeInUpAnimation(
      delay: const Duration(milliseconds: 500),
      child: Container(
        padding: _getResponsivePadding(context),
        color: Colors.white,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Projects',
                  style: GoogleFonts.roboto(
                    fontSize: _getResponsiveFontSize(context, 32),
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 30),
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
                          delay: Duration(milliseconds: 600 + (index * 100)),
                          width: isMobile ? double.infinity : itemWidth,
                          project: project,
                          titleFontSize: _getResponsiveFontSize(context, 20),
                          descFontSize: _getResponsiveFontSize(context, 15),
                          onTap: project['url'] != null
                              ? () => _launchURL(project['url'] as String)
                              : null,
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactsSection(BuildContext context) {
    final contacts = [
      {
        'icon': Icons.email,
        'label': 'Email',
        'value': 'hossameldinmi@gmail.com',
        'url': 'mailto:hossameldinmi@gmail.com',
      },
      {
        'icon': Icons.phone,
        'label': 'Phone',
        'value': '+1 (123) 456-7890',
        'url': 'tel:+11234567890',
      },
      {
        'icon': Icons.location_on,
        'label': 'Location',
        'value': 'City, Country',
        'url': null,
      },
      {
        'icon': Icons.link,
        'label': 'LinkedIn',
        'value': 'linkedin.com/in/hossameldinmi',
        'url': 'https://linkedin.com/in/hossameldinmi',
      },
      {
        'icon': Icons.code,
        'label': 'GitHub',
        'value': 'github.com/hossameldinmi',
        'url': 'https://github.com/hossameldinmi',
      },
    ];

    final isMobile = _isMobile(context);
    final isTablet = _isTablet(context);
    
    int getColumnCount() {
      if (isMobile) return 1;
      if (isTablet) return 2;
      return 3;
    }

    return FadeInUpAnimation(
      delay: const Duration(milliseconds: 600),
      child: Container(
        padding: _getResponsivePadding(context),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact',
                  style: GoogleFonts.roboto(
                    fontSize: _getResponsiveFontSize(context, 32),
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 30),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final columnCount = getColumnCount();
                    final spacing = isMobile ? 15.0 : 20.0;
                    final itemWidth = (constraints.maxWidth - (spacing * (columnCount - 1))) / columnCount;
                    
                    return Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: contacts.asMap().entries.map((entry) {
                        final index = entry.key;
                        final contact = entry.value;
                        
                        return AnimatedContactCard(
                          delay: Duration(milliseconds: 700 + (index * 100)),
                          width: isMobile ? double.infinity : itemWidth,
                          contact: contact,
                          onTap: contact['url'] != null
                              ? () => _launchURL(contact['url'] as String)
                              : null,
                          fontSize: _getResponsiveFontSize(context, 16),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: _isMobile(context) ? 20 : 30,
        horizontal: 20,
      ),
      color: Colors.grey[800],
      child: Center(
        child: Text(
          '© ${DateTime.now().year} Hossam Eldin Mahmoud. All rights reserved.',
          style: GoogleFonts.roboto(
            fontSize: _getResponsiveFontSize(context, 14),
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
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

class _FadeInUpAnimationState extends State<FadeInUpAnimation>
    with SingleTickerProviderStateMixin {
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
  final Map<String, dynamic> skillGroup;
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
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.blue.shade200,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -4.0 : 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.skillGroup['category'] as String,
                style: GoogleFonts.roboto(
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: (widget.skillGroup['items'] as List<String>).map((skill) {
                  return Chip(
                    label: Text(skill),
                    backgroundColor: Colors.blue.shade100,
                    labelStyle: GoogleFonts.roboto(
                      color: Colors.blue.shade900,
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

class AnimatedExperienceCard extends StatefulWidget {
  final Duration delay;
  final Map<String, dynamic> experience;
  final bool isMobile;
  final double titleFontSize;
  final double textFontSize;

  const AnimatedExperienceCard({
    super.key,
    required this.delay,
    required this.experience,
    required this.isMobile,
    required this.titleFontSize,
    required this.textFontSize,
  });

  @override
  State<AnimatedExperienceCard> createState() => _AnimatedExperienceCardState();
}

class _AnimatedExperienceCardState extends State<AnimatedExperienceCard> {
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
          margin: const EdgeInsets.only(bottom: 30),
          padding: EdgeInsets.all(widget.isMobile ? 16 : 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: _isHovered ? Colors.blue.shade200 : Colors.grey.shade300,
                blurRadius: _isHovered ? 15 : 10,
                offset: Offset(0, _isHovered ? 6 : 4),
              ),
            ],
          ),
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -2.0 : 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.experience['title'] as String,
                          style: GoogleFonts.roboto(
                            fontSize: widget.titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.experience['period'] as String,
                          style: GoogleFonts.roboto(
                            fontSize: widget.textFontSize,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.experience['title'] as String,
                            style: GoogleFonts.roboto(
                              fontSize: widget.titleFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800,
                            ),
                          ),
                        ),
                        Text(
                          widget.experience['period'] as String,
                          style: GoogleFonts.roboto(
                            fontSize: widget.textFontSize,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 8),
              Text(
                widget.experience['company'] as String,
                style: GoogleFonts.roboto(
                  fontSize: widget.textFontSize + 2,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.experience['description'] as String,
                style: GoogleFonts.roboto(
                  fontSize: widget.textFontSize,
                  height: 1.5,
                  color: Colors.grey[600],
                ),
              ),
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
  final Map<String, dynamic> project;
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
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.width,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: Colors.blue.shade100,
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            transform: Matrix4.identity()
              ..translate(0.0, _isHovered ? -4.0 : 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.folder_open,
                      color: Colors.blue.shade600,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.project['name'] as String,
                        style: GoogleFonts.roboto(
                          fontSize: widget.titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ),
                    if (widget.onTap != null)
                      Tooltip(
                        message: 'Open on pub.dev',
                        child: Icon(
                          Icons.open_in_new,
                          color: Colors.blue.shade400,
                          size: 20,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  widget.project['description'] as String,
                  style: GoogleFonts.roboto(
                    fontSize: widget.descFontSize,
                    height: 1.5,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (widget.project['technologies'] as List<String>).map((tech) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tech,
                        style: GoogleFonts.roboto(
                          fontSize: 13,
                          color: Colors.blue.shade900,
                        ),
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

class AnimatedContactCard extends StatefulWidget {
  final Duration delay;
  final double width;
  final Map<String, dynamic> contact;
  final VoidCallback? onTap;
  final double fontSize;

  const AnimatedContactCard({
    super.key,
    required this.delay,
    required this.width,
    required this.contact,
    this.onTap,
    required this.fontSize,
  });

  @override
  State<AnimatedContactCard> createState() => _AnimatedContactCardState();
}

class _AnimatedContactCardState extends State<AnimatedContactCard> {
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
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.width,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: _isHovered ? Colors.blue.shade200 : Colors.grey.shade300,
                  blurRadius: _isHovered ? 12 : 8,
                  offset: Offset(0, _isHovered ? 4 : 2),
                ),
              ],
            ),
            transform: Matrix4.identity()
              ..translate(0.0, _isHovered ? -2.0 : 0.0),
            child: Row(
              children: [
                Icon(
                  widget.contact['icon'] as IconData,
                  color: Colors.blue.shade600,
                  size: 32,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.contact['label'] as String,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.contact['value'] as String,
                        style: GoogleFonts.roboto(
                          fontSize: widget.fontSize,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.contact['url'] != null)
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.blue.shade400,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

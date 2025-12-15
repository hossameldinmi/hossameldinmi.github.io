import 'package:cv_website/src/models/skill_section.dart';
import 'package:cv_website/src/models/company.dart';
import 'package:cv_website/src/models/project.dart';
import 'package:cv_website/src/models/media.dart';
import 'package:media_source/media_source.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'src/data/resume_data.dart';

void main() {
  runApp(const CVWebsite());
}

class CVWebsite extends StatelessWidget {
  const CVWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hossam Eldin Mahmoud - Senior Mobile Software Engineer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme(),
        useMaterial3: true,
      ),
      home: const SelectionArea(child: CVHomePage()),
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
            _buildProjectsSection(context),
            _buildBlogSection(context),
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
                  backgroundImage: const AssetImage('assets/photo.jpg'),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    ResumeData.profile.name,
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
                  ResumeData.profile.title,
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
                  ResumeData.profile.about,
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
    final skills = ResumeData.profile.skills;

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
    final companies = ResumeData.profile.experience;

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
                ...companies.asMap().entries.map((entry) {
                  final index = entry.key;
                  final company = entry.value;

                  return AnimatedCompanyExperienceCard(
                    delay: Duration(milliseconds: 500 + (index * 100)),
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

    return FadeInUpAnimation(
      delay: const Duration(milliseconds: 550),
      child: Container(
        padding: _getResponsivePadding(context),
        color: Colors.grey[50],
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Blog',
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
                      children: blogs.asMap().entries.map((entry) {
                        final index = entry.key;
                        final blog = entry.value;

                        // Reusing AnimatedProjectCard as a template for Blog for now
                        // In a real scenario, we'd create a specific AnimatedBlogCard
                        return AnimatedProjectCard(
                          delay: Duration(milliseconds: 600 + (index * 100)),
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
      ),
    );
  }

  Widget _buildContactsSection(BuildContext context) {
    final contact = ResumeData.profile.contact;

    final isMobile = _isMobile(context);
    final isTablet = _isTablet(context);

    // Create a list of mappable items for the grid
    final contactItems = [
      if (contact.email != null)
        {
          'icon': Icons.email,
          'label': 'Email',
          'value': contact.email!,
          'url': 'mailto:${contact.email}',
        },
      if (contact.phone != null)
        {
          'icon': Icons.phone,
          'label': 'Phone',
          'value': contact.phone.toString(),
          'url': 'tel:${contact.phone?.number.replaceAll(' ', '')}',
        },
      if (contact.linkedinUrl != null)
        {
          'icon': Icons.link,
          'label': 'LinkedIn',
          'value': 'linkedin.com/in/hossameldinmi', // Simplified for display
          'url': contact.linkedinUrl!,
        },
      if (contact.githubUrl != null)
        {
          'icon': Icons.code,
          'label': 'GitHub',
          'value': 'github.com/hossameldinmi',
          'url': contact.githubUrl!,
        },
      if (contact.websiteUrl != null)
        {
          'icon': Icons.web,
          'label': 'Website',
          'value': 'hossameldinmi.github.io',
          'url': contact.websiteUrl!,
        },
    ];

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
                      children: contactItems.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;

                        return AnimatedContactCard(
                          delay: Duration(milliseconds: 700 + (index * 100)),
                          width: isMobile ? double.infinity : itemWidth,
                          icon: item['icon'] as IconData,
                          label: item['label'] as String,
                          value: item['value'] as String,
                          url: item['url'] as String,
                          onTap: () => _launchURL(item['url'] as String),
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
          '© ${DateTime.now().year} ${ResumeData.profile.name}. All rights reserved.',
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
          transform: Matrix4.translationValues(0.0, _isHovered ? -4.0 : 0.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.skillGroup.category,
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
                children: widget.skillGroup.skills.map((skill) {
                  return Chip(
                    label: Text(skill.name),
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
          transform: Matrix4.translationValues(0.0, _isHovered ? -2.0 : 0.0, 0.0),
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
                        child: SizedBox(
                          width: 48,
                          height: 48,
                          child: widget.company.logo!.fold(
                            network: (n) => Image.network(n.uri.toString()),
                            asset: (a) => Image.asset(a.assetPath),
                            orElse: () => const SizedBox(),
                          ),
                        ),
                      ),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.company.name,
                        style: GoogleFonts.roboto(
                          fontSize: widget.titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.company.dateRange.forResume} · ${widget.company.totalDuration}',
                        style: GoogleFonts.roboto(
                          fontSize: widget.textFontSize * 0.9,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
                          width: 40,
                          child: Column(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isFirst ? Colors.blue.shade600 : Colors.blue.shade200,
                                  border: Border.all(color: Colors.blue.shade100, width: 2),
                                ),
                              ),
                              if (!isLast)
                                Expanded(
                                  child: Container(
                                    width: 2,
                                    color: Colors.blue.shade200,
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
                                            color: Colors.blue.shade800,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          exp.dateRange.forResume,
                                          style: GoogleFonts.roboto(
                                            fontSize: widget.textFontSize * 0.9,
                                            color: Colors.grey[600],
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
                                              color: Colors.blue.shade800,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          exp.dateRange.forResume,
                                          style: GoogleFonts.roboto(
                                            fontSize: widget.textFontSize * 0.9,
                                            color: Colors.grey[600],
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
                                  color: Colors.grey[500],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                exp.description,
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
            transform: Matrix4.translationValues(0.0, _isHovered ? -4.0 : 0.0, 0.0),
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
                        widget.project.title,
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
                  widget.project.description,
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
                  children: widget.project.skills.map((s) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        s.name,
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
  final IconData icon;
  final String label;
  final String value;
  final String url;
  final VoidCallback? onTap;
  final double fontSize;

  const AnimatedContactCard({
    super.key,
    required this.delay,
    required this.width,
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
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
            transform: Matrix4.translationValues(0.0, _isHovered ? -2.0 : 0.0, 0.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    widget.icon,
                    color: Colors.blue.shade800,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label,
                        style: GoogleFonts.roboto(
                          fontSize: widget.fontSize * 0.85,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.value,
                        style: GoogleFonts.roboto(
                          fontSize: widget.fontSize,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue.shade800,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

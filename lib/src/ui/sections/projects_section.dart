import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/resume_data.dart';
import '../../data/experiences.dart';
import '../../models/project.dart';
import '../../utils/responsive_utils.dart';
import '../widgets/animations/fade_in_up_animation.dart';
import '../widgets/animations/animated_project_card.dart';
import '../widgets/common/project_details_dialog.dart';

enum ProjectFilter {
  all,
  openSource,
  ynmo,
  toptalAndela,
  portme,
  facegraph,
  eme,
}

class ProjectsSection extends StatefulWidget {
  final GlobalKey sectionKey;

  const ProjectsSection({
    super.key,
    required this.sectionKey,
  });

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  ProjectFilter _selectedFilter = ProjectFilter.all;

  List<Project> _getFilteredProjects() {
    final allProjects = ResumeData.profile.projects;

    switch (_selectedFilter) {
      case ProjectFilter.all:
        return allProjects;
      case ProjectFilter.openSource:
        return allProjects
            .where((p) =>
                p.experiences.contains(Experiences.toptalSenior) || p.experiences.contains(Experiences.andelaSenior))
            .toList();
      case ProjectFilter.ynmo:
        return allProjects.where((p) => p.experiences.contains(Experiences.ynmoSenior)).toList();
      case ProjectFilter.toptalAndela:
        return allProjects
            .where((p) =>
                p.experiences.contains(Experiences.toptalSenior) || p.experiences.contains(Experiences.andelaSenior))
            .toList();
      case ProjectFilter.portme:
        return allProjects.where((p) => p.experiences.contains(Experiences.portmeSenior)).toList();
      case ProjectFilter.facegraph:
        return allProjects.where((p) => p.experiences.contains(Experiences.facegraphSenior)).toList();
      case ProjectFilter.eme:
        return allProjects.where((p) => p.experiences.contains(Experiences.emeSpecialist)).toList();
    }
  }

  String _getFilterLabel(ProjectFilter filter) {
    switch (filter) {
      case ProjectFilter.all:
        return 'All Projects';
      case ProjectFilter.openSource:
        return 'Open Source';
      case ProjectFilter.ynmo:
        return 'Ynmo';
      case ProjectFilter.toptalAndela:
        return 'Toptal/Andela';
      case ProjectFilter.portme:
        return 'Portme';
      case ProjectFilter.facegraph:
        return 'FaceGraph';
      case ProjectFilter.eme:
        return 'EME';
    }
  }

  @override
  Widget build(BuildContext context) {
    final projects = _getFilteredProjects();

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
      key: widget.sectionKey,
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
              const SizedBox(height: 30),
              // Filter Chips
              FadeInUpAnimation(
                delay: const Duration(milliseconds: 300),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ProjectFilter.values.map((filter) {
                    final isSelected = _selectedFilter == filter;
                    return FilterChip(
                      label: Text(_getFilterLabel(filter)),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedFilter = filter;
                          });
                        }
                      },
                      selectedColor: theme.colorScheme.primary.withOpacity(0.2),
                      checkmarkColor: theme.colorScheme.primary,
                      backgroundColor: isDark ? const Color(0xFF172A46) : Colors.grey[200],
                      side: BorderSide(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : (isDark ? const Color(0xFF233554) : Colors.grey[300]!),
                        width: 1.5,
                      ),
                      labelStyle: GoogleFonts.roboto(
                        color: isSelected ? theme.colorScheme.primary : theme.textTheme.bodyMedium?.color,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 30),
              // Projects count indicator
              FadeInUpAnimation(
                delay: const Duration(milliseconds: 350),
                child: Text(
                  '${projects.length} ${projects.length == 1 ? 'project' : 'projects'}',
                  style: GoogleFonts.roboto(
                    fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                          showDialog(
                            context: context,
                            builder: (context) => ProjectDetailsDialog(project: project),
                          );
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
}

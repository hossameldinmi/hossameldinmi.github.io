import 'package:cv_website/src/models/company.dart';
import 'package:cv_website/src/models/date_range.dart';
import 'package:cv_website/src/models/media.dart';
import 'package:cv_website/src/models/project.dart';
import 'package:cv_website/src/models/skill.dart';

class Experience {
  final String title;

  final String locationType;
  final String employmentType; // Full-time, Contract, etc.
  final DateRange dateRange;
  final String description;
  late final Company company;
  final List<Media> media = [];
  final List<Skill> skills = []; // Related Skills
  final List<Project> projects = []; // Private list to avoid circular dependency issues

  Experience({
    required this.title,
    this.locationType = '',
    this.employmentType = '',
    required this.dateRange,
    required this.description,
    List<Skill>? skills,
  }) {
    this.skills.addAll(skills ?? []);
    this.skills.forEach((skill) {
      skill.addExperience(this);
    });
  }

  // Add a project to this experience
  void addProject(Project project) {
    projects.add(project);
  }

  void addCompany(Company company) {
    this.company = company;
  }
}

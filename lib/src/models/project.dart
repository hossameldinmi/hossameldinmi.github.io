import 'package:cv_website/src/models/media.dart';
import 'package:cv_website/src/models/skill.dart';

class Project {
  final String title;
  final String description;
  final List<Media> media;
  final List<Skill> skills; // Related Skills
  // Relation strings
  final List<String> relatedExperienceTitles;
  final List<String> relatedEducationSchools;
  final List<String> relatedCertificationNames;

  Project({
    required this.title,
    required this.description,
    this.media = const [],
    this.skills = const [],
    this.relatedExperienceTitles = const [],
    this.relatedEducationSchools = const [],
    this.relatedCertificationNames = const [],
  }) {
    skills.forEach((skill) {
      skill.addProject(this);
    });
  }
}

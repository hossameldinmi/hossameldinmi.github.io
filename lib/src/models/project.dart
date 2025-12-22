import 'package:cv_website/src/models/experience.dart';
import 'package:cv_website/src/models/media.dart';
import 'package:cv_website/src/models/skill.dart';

class Project {
  final String title;
  final String description;
  final List<Media> media;
  final List<Skill> skills; // Related Skills
  final List<Experience> experiences; // Related Experiences
  // Relation strings (deprecated - use experiences list instead)
  final List<String> relatedExperienceTitles;
  final List<String> relatedEducationSchools;
  final List<String> relatedCertificationNames;

  /// Returns the first media item if it's an image, to be used as logo
  final Media? logo;

  Project({
    required this.title,
    required this.description,
    this.media = const [],
    this.logo,
    this.skills = const [],
    this.experiences = const [],
    this.relatedExperienceTitles = const [],
    this.relatedEducationSchools = const [],
    this.relatedCertificationNames = const [],
  }) {
    skills.forEach((skill) {
      skill.addProject(this);
    });
    experiences.forEach((experience) {
      experience.addProject(this);
    });
  }
}

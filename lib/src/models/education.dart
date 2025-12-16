import 'package:cv_website/src/models/date_range.dart';
import 'package:cv_website/src/models/media.dart';
import 'package:cv_website/src/models/skill.dart';

class Education {
  final String schoolName;
  final String degreeName;
  final String fieldOfStudy;
  final DateRange dateRange;
  final String description;
  final List<Media> media;
  final List<Skill> skills; // Related Skills

  Education({
    required this.schoolName,
    required this.degreeName,
    required this.fieldOfStudy,
    required this.dateRange,
    required this.description,
    this.media = const [],
    this.skills = const [],
  }) {
    skills.forEach((skill) {
      skill.addEducation(this);
    });
  }
}

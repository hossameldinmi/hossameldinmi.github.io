import 'package:cv_website/src/models/skill.dart';

class SkillSection {
  final String category; // Preserving UI grouping
  final List<Skill> skills;

  const SkillSection({
    required this.category,
    required this.skills,
  });
}

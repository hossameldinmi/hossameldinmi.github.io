import 'package:cv_website/src/models/article.dart';
import 'package:cv_website/src/models/education.dart';
import 'package:cv_website/src/models/experience.dart';
import 'package:cv_website/src/models/project.dart';

enum SkillProficiency {
  expert, // Green - 80%+
  advanced, // Pink/Magenta - 60-79%
  intermediate, // Cyan - 40-59%
  beginner, // Orange - <40 %
}

class Skill {
  final String name;
  final SkillProficiency proficiency;
  final List<Experience> relatedExperiences = [];
  final List<Education> relatedEducation = [];
  final List<Project> relatedProjects = [];
  final List<Article> relatedArticles = [];

  Skill({
    required this.name,
    this.proficiency = SkillProficiency.advanced,
  });

  void addExperience(Experience experience) {
    relatedExperiences.add(experience);
  }

  void addEducation(Education education) {
    relatedEducation.add(education);
  }

  void addProject(Project project) {
    relatedProjects.add(project);
  }

  void addArticle(Article article) {
    relatedArticles.add(article);
  }
}

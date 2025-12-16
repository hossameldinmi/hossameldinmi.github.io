import 'package:cv_website/src/models/media.dart';
import 'package:cv_website/src/models/skill.dart';
import 'package:media_source/media_source.dart';

class Article {
  final String title;
  final String description;
  final MediaSource url;
  final List<Media> media;
  final List<Skill> skills;

  Article({
    required this.title,
    required this.description,
    required this.url,
    this.media = const [],
    this.skills = const [],
  }) {
    skills.forEach((skill) {
      skill.addArticle(this);
    });
  }
}

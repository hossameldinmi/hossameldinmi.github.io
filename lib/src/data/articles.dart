import 'package:cv_website/src/data/skils.dart';
import 'package:cv_website/src/models/article.dart';
import 'package:media_source/media_source.dart';

class Articles {
  static final values = [
    // Example Placeholder
    Article(
      title: 'Simplifying Media Handling in Flutter: A Type-Safe Unified API',
      description: 'Tips and tricks for making your Flutter apps fly.',
      url: UrlMedia.url('https://medium.com/p/83e4ad137fb0'), // Placeholder
      skills: [Skills.flutter, Skills.dart],
    ),
  ];
}

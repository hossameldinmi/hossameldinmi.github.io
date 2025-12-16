import 'package:media_source/media_source.dart';

enum MediaType { image, video, article, link }

class Media {
  final String title;
  final String description;
  final MediaType type;
  final MediaSource media;

  const Media({
    required this.media,
    required this.title,
    this.description = '',
    required this.type,
  });
}

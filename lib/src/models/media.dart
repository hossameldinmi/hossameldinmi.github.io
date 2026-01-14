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

  static Media googlePlayStore(String url) => Media(
        media: UrlMedia.url(url),
        title: 'Google Play Store',
        type: MediaType.link,
      );

  static Media appStore(String url) => Media(
        media: UrlMedia.url(url),
        title: 'Apple App Store',
        type: MediaType.link,
      );

  static Media huaweiAppGallery(String url) => Media(
        media: UrlMedia.url(url),
        title: 'Huawei AppGallery',
        type: MediaType.link,
      );

  static Media pubDev(String url) => Media(
        media: UrlMedia.url(url),
        title: 'pub.dev',
        type: MediaType.link,
      );

  static Media github(String url) => Media(
        media: UrlMedia.url(url),
        title: 'GitHub',
        type: MediaType.link,
      );

  static Media link(
    String url, {
    required String title,
    String description = '',
  }) =>
      Media(
        media: UrlMedia.url(url),
        title: title,
        description: description,
        type: MediaType.link,
      );
}

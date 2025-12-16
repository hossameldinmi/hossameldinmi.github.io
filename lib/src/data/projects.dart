import 'package:cv_website/src/data/skils.dart';
import 'package:cv_website/src/models/media.dart';
import 'package:cv_website/src/models/project.dart';
import 'package:media_source/media_source.dart';

class Projects {
  static final values = [
    Project(
      title: 'Tawakkalna SDK Flutter',
      description: 'Flutter SDK integration for the Tawakkalna government application, '
          'enabling secure identity verification and COVID-19 health status integration. '
          'Provides seamless integration with Saudi Arabia\'s official health platform.',
      media: [
        Media(
            media: UrlMedia.url('https://pub.dev/packages/tawakkalna_sdk_flutter'),
            title: 'Tawakkalna SDK Flutter',
            type: MediaType.link)
      ],
      skills: [Skills.flutter, Skills.dart],
    ),
    Project(
      title: 'Media Source',
      description: 'Flutter package for advanced media handling and source management, '
          'providing seamless media integration capabilities. Supports multiple media formats '
          'and sources with efficient caching and loading mechanisms.',
      media: [
        Media(media: UrlMedia.url('https://pub.dev/packages/media_source'), title: 'Media Source', type: MediaType.link)
      ],
      skills: [Skills.flutter, Skills.dart],
    ),
    Project(
      title: 'File Type Plus',
      description: 'Enhanced file type detection package for Flutter applications, '
          'supporting comprehensive file format identification. Provides accurate MIME type '
          'detection and file extension validation.',
      media: [
        Media(
            media: UrlMedia.url('https://pub.dev/packages/file_type_plus'),
            title: 'File Type Plus',
            type: MediaType.link)
      ],
      skills: [Skills.flutter, Skills.dart],
    ),
    Project(
      title: 'File Sized',
      description: 'Utility package for file size formatting and management in Flutter, '
          'simplifying file size operations and display. Provides human-readable file size '
          'formatting with customizable units.',
      media: [
        Media(
          media: UrlMedia.url('https://pub.dev/packages/file_sized'),
          title: 'File Sized',
          type: MediaType.link,
        )
      ],
      skills: [Skills.flutter, Skills.dart],
    ),
    Project(
      title: 'Time of Day',
      description: 'Time management and formatting package for Flutter applications, '
          'providing intuitive time selection and display features. Includes custom time '
          'pickers and formatting utilities.',
      media: [
        Media(media: UrlMedia.url('https://pub.dev/packages/time_of_day'), title: 'Time of Day', type: MediaType.link)
      ],
      skills: [Skills.flutter, Skills.dart],
    ),
  ];
}

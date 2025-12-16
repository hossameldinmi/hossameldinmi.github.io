import 'package:cv_website/src/models/date_range.dart';
import 'package:cv_website/src/models/experience.dart';
import 'package:media_source/media_source.dart';

class Company {
  final String name;
  final MediaSource<ImageType>? logo;
  final List<Experience> experiences;

  const Company({
    required this.name,
    this.logo,
    required this.experiences,
  });

  DateRange get dateRange {
    if (experiences.isEmpty) {
      return DateRange(start: DateTime.now(), end: DateTime.now());
    }

    DateTime? minStart;
    DateTime? maxEnd;
    bool isPresent = false;

    for (var exp in experiences) {
      if (minStart == null || exp.dateRange.start.isBefore(minStart)) {
        minStart = exp.dateRange.start;
      }
      if (exp.dateRange.end == null) {
        isPresent = true;
      } else if (!isPresent && (maxEnd == null || exp.dateRange.end!.isAfter(maxEnd))) {
        maxEnd = exp.dateRange.end;
      }
    }

    final start = minStart ?? DateTime.now();
    final end = isPresent ? null : (maxEnd ?? DateTime.now());

    return DateRange(start: start, end: end);
  }

  String get totalDuration {
    final range = dateRange;
    final end = range.end ?? DateTime.now();
    final start = range.start;

    int months = (end.year - start.year) * 12 + end.month - start.month;
    months += 1;

    if (months <= 0) return '';

    final years = months ~/ 12;
    final remainingMonths = months % 12;

    final parts = <String>[];
    if (years > 0) parts.add('$years yr${years > 1 ? "s" : ""}');
    if (remainingMonths > 0) parts.add('$remainingMonths mo${remainingMonths > 1 ? "s" : ""}');

    return parts.join(' ');
  }
}

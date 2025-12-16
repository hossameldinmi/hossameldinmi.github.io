import 'package:intl/intl.dart';

class DateRange {
  final DateTime start;
  final DateTime? end;

  const DateRange({required this.start, this.end});

  bool get isPresent => end == null;

  Duration get duration => (end ?? DateTime.now()).difference(start);
  static final _format = DateFormat('MMM yyyy');
  String get forResume {
    if (isPresent) {
      return '${_format.format(start)} - Present';
    }
    return '${_format.format(start)} - ${_format.format(end!)}';
  }
}

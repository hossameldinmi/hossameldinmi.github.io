import 'package:cv_website/src/data/skils.dart';
import 'package:cv_website/src/models/date_range.dart';
import 'package:cv_website/src/models/education.dart';

class EducationSchools {
  static final values = [
    Education(
      schoolName: 'Information Technology Institute (ITI)',
      degreeName: 'Nanodegree',
      fieldOfStudy: 'Mobile Application Development',
      dateRange: DateRange(start: DateTime(2017), end: DateTime(2018)),
      description:
          'Comprehensive program covering iOS and Android development, mobile UI/UX design, and app deployment.',
      skills: [
        Skills.ios,
        Skills.mobileDevelopment,
        Skills.xamarin,
      ],
    ),
    Education(
      schoolName: 'South Valley University',
      degreeName: 'Bachelor',
      fieldOfStudy: 'Mechanical Engineering',
      dateRange: DateRange(start: DateTime(2012), end: DateTime(2017)), // Graduation
      description: 'Strong foundation in engineering principles, problem-solving, and analytical thinking.',
      skills: [
        Skills.problemSolving,
      ],
    ),
  ];
}

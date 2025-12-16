import 'package:cv_website/src/data/skils.dart';
import 'package:cv_website/src/models/company.dart';
import 'package:cv_website/src/models/date_range.dart';
import 'package:cv_website/src/models/experience.dart';
import 'package:media_source/media_source.dart';

class Experiences {
  static final values = [
    Company(
      name: 'Ynmo',
      logo: ImageNetworkMedia.url('https://ynmodata.com/wp-content/uploads/2024/08/favico.png'),
      experiences: [
        Experience(
          title: 'Senior Mobile Software Engineer',
          location: 'Remote',
          employmentType: 'Full-time',
          dateRange: DateRange(start: DateTime(2022, 2)),
          description:
              'Leading mobile development for fintech platform. Architecting and implementing Flutter applications with focus on performance and scalability. Mentoring team members and establishing mobile development best practices. Integrating complex financial APIs and ensuring security compliance. Collaborating with cross-functional teams to deliver high-quality mobile solutions.',
          skills: [Skills.flutter, Skills.dart, Skills.ios, Skills.restApis, Skills.performanceOptimization],
        ),
      ],
    ),
    Company(
      name: 'PortMe',
      logo: ImageNetworkMedia.url('https://portme.app/assets/images/fav.png'),
      experiences: [
        Experience(
          title: 'Senior Mobile Software Engineer',
          location: 'Remote',
          employmentType: 'Contract',
          dateRange: DateRange(start: DateTime(2021, 9), end: DateTime(2022, 4)),
          description:
              'Developed cross-platform mobile applications using Flutter for telecommunications platform. Implemented number porting features and real-time status tracking. Collaborated with backend team to design and integrate RESTful APIs. Optimized app performance and reduced crash rates by 40%. Enhanced user experience through intuitive UI/UX design.',
          skills: [Skills.flutter, Skills.dart, Skills.restApis, Skills.performanceOptimization],
        ),
      ],
    ),
    Company(
      name: 'Facegraph',
      logo: ImageNetworkMedia.url(
          'https://facegraph.com/wp-content/uploads/2022/12/favicon.png'), // Restoring Facegraph logo (Note: This is white, might need adjustment)
      experiences: [
        Experience(
          title: 'Senior Software Engineer',
          location: 'Remote',
          employmentType: 'Full-time',
          dateRange: DateRange(start: DateTime(2021, 10), end: DateTime(2022, 1)),
          description:
              'Built social networking features using Flutter and native iOS/Android. Implemented real-time messaging, media sharing, and social graph features. Worked on SDK development for third-party integrations. Enhanced app stability and user engagement metrics. Participated in architectural decisions and code reviews.',
          skills: [Skills.flutter, Skills.dart, Skills.ios, Skills.performanceOptimization],
        ),
        Experience(
          title: 'Software Engineer II',
          location: 'Remote',
          employmentType: 'Full-time',
          dateRange: DateRange(start: DateTime(2019, 12), end: DateTime(2021, 10)),
          description:
              'Developed mobile applications using Flutter and React Native. Implemented user authentication, profile management, and content feed features. Collaborated with design team to create intuitive user interfaces. Participated in code reviews and agile ceremonies. Contributed to improving development workflows and best practices.',
          skills: [Skills.flutter, Skills.dart, Skills.ios, Skills.performanceOptimization],
        ),
      ],
    ),
    Company(
      name: 'EME International',
      logo: ImageNetworkMedia.url(
          'https://media.licdn.com/dms/image/v2/C4D0BAQGu4ks3R0ACQw/company-logo_200_200/company-logo_200_200/0/1658672814240/eme_international_logo?e=1767225600&v=beta&t=l_8ac5BU9V31UFZsAqRP3TWCwGE4Le4x9phoFsAmiZg'),
      experiences: [
        Experience(
          title: 'Specialist Software Engineer - .NET and Cross-Platform',
          location: 'Egypt',
          employmentType: 'Full-time',
          dateRange: DateRange(start: DateTime(2019, 2), end: DateTime(2019, 12)),
          description:
              'Developed cross-platform mobile applications using Xamarin and Flutter. Built enterprise solutions for logistics and supply chain management. Integrated with legacy .NET backend systems. Provided technical support and training to clients. Participated in requirement analysis and solution design.',
          skills: [Skills.xamarin, Skills.flutter, Skills.dart, Skills.ios, Skills.performanceOptimization],
        ),
        Experience(
          title: 'Associate Software Engineer - .NET and Cross-Platform',
          location: 'Egypt',
          employmentType: 'Full-time',
          dateRange: DateRange(start: DateTime(2018, 3), end: DateTime(2019, 2)),
          description:
              'Started career in mobile development with Xamarin and .NET. Contributed to enterprise mobile applications. Learned mobile development best practices and design patterns. Participated in requirement gathering and technical documentation. Gained experience in full software development lifecycle.',
          skills: [Skills.xamarin, Skills.cSharp, Skills.dotNet, Skills.mobileDevelopment],
        ),
      ],
    ),
  ];
}

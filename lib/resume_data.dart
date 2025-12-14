import 'package:media_source/media_source.dart';

// Comprehensive LinkedIn Data Models
class LinkedInProfile {
  final String name;
  final String title;
  final String about;
  final String photoUrl;
  final String location;
  final List<Position> experience;
  final List<Education> education;
  final List<SkillSection> skills;
  final List<Project> projects;
  final List<LicenseAndCertification> certifications;
  final List<Language> languages;
  final Contact contact;
  final List<Blog> blogs;

  const LinkedInProfile({
    required this.name,
    required this.title,
    required this.about,
    required this.photoUrl,
    required this.location,
    required this.experience,
    required this.education,
    required this.skills,
    required this.projects,
    required this.certifications,
    required this.languages,
    required this.contact,
    required this.blogs,
  });
}

class Position {
  final String title;
  final String companyName;
  final String? companyLogoUrl;
  final String location;
  final String employmentType; // Full-time, Contract, etc.
  final DateRange dateRange;
  final String description;
  final List<Media> media;
  final List<String> skills; // Related Skills

  const Position({
    required this.title,
    required this.companyName,
    this.companyLogoUrl,
    this.location = '',
    this.employmentType = '',
    required this.dateRange,
    required this.description,
    this.media = const [],
    this.skills = const [],
  });
}

class Education {
  final String schoolName;
  final String degreeName;
  final String fieldOfStudy;
  final DateRange dateRange;
  final String description;
  final List<Media> media;
  final List<String> skills; // Related Skills

  const Education({
    required this.schoolName,
    required this.degreeName,
    required this.fieldOfStudy,
    required this.dateRange,
    required this.description,
    this.media = const [],
    this.skills = const [],
  });
}

class SkillSection {
  final String category; // Preserving UI grouping
  final List<Skill> skills;

  const SkillSection({
    required this.category,
    required this.skills,
  });
}

class Skill {
  final String name;
  // Relationships modeled as strings to avoid circular static references
  final List<String> relatedExperienceTitles;
  final List<String> relatedEducationSchools;
  final List<String> relatedProjectTitles;

  const Skill({
    required this.name,
    this.relatedExperienceTitles = const [],
    this.relatedEducationSchools = const [],
    this.relatedProjectTitles = const [],
  });
}

class Project {
  final String title;
  final String description;
  final String url;
  final List<String> technologies;
  final List<Media> media;
  final List<String> skills; // Related Skills
  // Relation strings
  final List<String> relatedExperienceTitles;
  final List<String> relatedEducationSchools;
  final List<String> relatedCertificationNames;

  const Project({
    required this.title,
    required this.description,
    required this.url,
    this.technologies = const [],
    this.media = const [],
    this.skills = const [],
    this.relatedExperienceTitles = const [],
    this.relatedEducationSchools = const [],
    this.relatedCertificationNames = const [],
  });
}

class LicenseAndCertification {
  final String name;
  final String issuingOrganization;
  final String issueDate;
  final String? credentialUrl;

  const LicenseAndCertification({
    required this.name,
    required this.issuingOrganization,
    required this.issueDate,
    this.credentialUrl,
  });
}

class Language {
  final String name;
  final String proficiency;

  const Language({
    required this.name,
    required this.proficiency,
  });
}

class Contact {
  final String? email;
  final String? linkedinUrl;
  final String? githubUrl;
  final String? websiteUrl;
  final PhoneNumber? phone;

  const Contact({
    this.email,
    this.linkedinUrl,
    this.githubUrl,
    this.websiteUrl,
    this.phone,
  });
}

class PhoneNumber {
  final String countryCode;
  final String number;

  const PhoneNumber({required this.countryCode, required this.number});

  @override
  String toString() => '$countryCode $number';
}

class Blog {
  final String title;
  final String description;
  final String url;
  final List<Media> media;
  final List<String> skills;

  const Blog({
    required this.title,
    required this.description,
    required this.url,
    this.media = const [],
    this.skills = const [],
  });
}

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

enum MediaType { image, video, article, link }

// Helper for Date Range
class DateRange {
  final String start;
  final String end;

  const DateRange({required this.start, this.end = 'Present'});

  @override
  String toString() => '$start - $end';
}

class ResumeData {
  static const LinkedInProfile profile = LinkedInProfile(
    name: 'Hossam Eldin Mahmoud',
    title: 'Senior Mobile Software Engineer',
    about: 'Senior Mobile Software Engineer with 7+ years of experience specializing in Flutter and cross-platform '
        'mobile development. Proven track record of building production-ready applications and SDKs for '
        'government services, fintech, and social platforms. Published 5+ open-source packages on pub.dev '
        'with thousands of downloads. Strong expertise in Flutter, Dart, native iOS/Android integration, '
        'and SDK development. Background in Mechanical Engineering with a focus on problem-solving and '
        'technical innovation.',
    photoUrl: 'assets/photo.jpg',
    location: 'Egypt',
    contact: Contact(
      email: 'hossameldinmi@gmail.com',
      linkedinUrl: 'https://linkedin.com/in/hossameldinmi',
      githubUrl: 'https://github.com/hossameldinmi',
      websiteUrl: 'https://hossameldinmi.github.io', // Assuming
      phone: PhoneNumber(countryCode: '+20', number: '122 848 6542'),
    ),
    experience: [
      Position(
        title: 'Senior Mobile Software Engineer',
        companyName: 'Ynmo',
        location: 'Remote',
        employmentType: 'Full-time',
        dateRange: DateRange(start: 'Feb 2022'),
        description: 'Leading mobile development for fintech platform. Architecting and implementing '
            'Flutter applications with focus on performance and scalability. Mentoring team members '
            'and establishing mobile development best practices. Integrating complex financial APIs '
            'and ensuring security compliance. Collaborating with cross-functional teams to deliver '
            'high-quality mobile solutions.',
        skills: ['Flutter', 'Dart', 'Fintech', 'Architecture'],
      ),
      Position(
        title: 'Senior Mobile Software Engineer',
        companyName: 'PortMe',
        location: 'Remote',
        employmentType: 'Full-time',
        dateRange: DateRange(start: 'Sep 2021', end: 'Apr 2022'),
        description: 'Developed cross-platform mobile applications using Flutter for telecommunications '
            'platform. Implemented number porting features and real-time status tracking. Collaborated '
            'with backend team to design and integrate RESTful APIs. Optimized app performance and '
            'reduced crash rates by 40%. Enhanced user experience through intuitive UI/UX design.',
        skills: ['Flutter', 'Dart', 'REST APIs', 'Performance Optimization'],
      ),
      Position(
        title: 'Senior Software Engineer',
        companyName: 'Facegraph',
        location: 'Remote', // Assumed
        employmentType: 'Full-time',
        dateRange: DateRange(start: 'Oct 2021', end: 'Jan 2022'),
        description: 'Built social networking features using Flutter and native iOS/Android. Implemented '
            'real-time messaging, media sharing, and social graph features. Worked on SDK development '
            'for third-party integrations. Enhanced app stability and user engagement metrics. '
            'Participated in architectural decisions and code reviews.',
        skills: ['Flutter', 'iOS Native', 'Android Native', 'Real-time Messaging'],
      ),
      Position(
        title: 'Software Engineer II',
        companyName: 'Facegraph',
        location: 'Remote', // Assumed
        employmentType: 'Full-time',
        dateRange: DateRange(start: 'Dec 2019', end: 'Oct 2021'),
        description: 'Developed mobile applications using Flutter and React Native. Implemented user '
            'authentication, profile management, and content feed features. Collaborated with design '
            'team to create intuitive user interfaces. Participated in code reviews and agile ceremonies. '
            'Contributed to improving development workflows and best practices.',
        skills: ['Flutter', 'React Native', 'Authentication', 'UI/UX'],
      ),
      Position(
        title: 'Specialist Software Engineer - .NET and Cross-Platform',
        companyName: 'EME International',
        location: 'Egypt',
        employmentType: 'Full-time',
        dateRange: DateRange(start: 'Feb 2019', end: 'Dec 2019'),
        description: 'Developed cross-platform mobile applications using Xamarin and Flutter. Built '
            'enterprise solutions for logistics and supply chain management. Integrated with legacy '
            '.NET backend systems. Provided technical support and training to clients. Participated '
            'in requirement analysis and solution design.',
        skills: ['Xamarin', 'Flutter', '.NET', 'Enterprise Solutions'],
      ),
      Position(
        title: 'Associate Software Engineer - .NET and Cross-Platform',
        companyName: 'EME International',
        location: 'Egypt',
        employmentType: 'Full-time',
        dateRange: DateRange(start: 'Mar 2018', end: 'Feb 2019'),
        description: 'Started career in mobile development with Xamarin and .NET. Contributed to '
            'enterprise mobile applications. Learned mobile development best practices and design '
            'patterns. Participated in requirement gathering and technical documentation. Gained '
            'experience in full software development lifecycle.',
        skills: ['Xamarin', 'C#', '.NET', 'Mobile Development'],
      ),
    ],
    education: [
      Education(
        schoolName: 'Udacity',
        degreeName: 'Nanodegree',
        fieldOfStudy: 'Mobile Application Development',
        dateRange: DateRange(start: '2017', end: '2017'),
        description:
            'Comprehensive program covering iOS and Android development, mobile UI/UX design, and app deployment.',
        skills: ['iOS', 'Android', 'Mobile UI/UX'],
      ),
      Education(
        schoolName: 'University',
        degreeName: 'Bachelor',
        fieldOfStudy: 'Mechanical Engineering',
        dateRange: DateRange(start: '2016', end: '2016'), // Graduation
        description: 'Strong foundation in engineering principles, problem-solving, and analytical thinking.',
        skills: ['Problem Solving', 'Analytical Thinking', 'Engineering'],
      ),
    ],
    skills: [
      SkillSection(
        category: 'Mobile Development',
        skills: [
          Skill(
              name: 'Flutter',
              relatedExperienceTitles: ['Senior Mobile Software Engineer', 'Senior Software Engineer'],
              relatedProjectTitles: ['Tawakkalna SDK Flutter', 'Media Source']),
          Skill(name: 'Dart'),
          Skill(name: 'iOS (Swift/Objective-C)'),
          Skill(name: 'Android (Kotlin/Java)'),
          Skill(name: 'React Native'),
          Skill(name: 'Cross-Platform Development'),
        ],
      ),
      SkillSection(
        category: 'Programming Languages',
        skills: [
          Skill(name: 'Dart'),
          Skill(name: 'Swift'),
          Skill(name: 'Kotlin'),
          Skill(name: 'JavaScript'),
          Skill(name: 'TypeScript'),
          Skill(name: 'C#'),
          Skill(name: '.NET'),
          Skill(name: 'Java')
        ],
      ),
      SkillSection(
        category: 'SDK & Integration',
        skills: [
          Skill(name: 'SDK Development'),
          Skill(name: 'Native Bridges'),
          Skill(name: 'Platform Channels'),
          Skill(name: 'API Integration'),
          Skill(name: 'Third-party SDKs'),
          Skill(name: 'Plugin Development')
        ],
      ),
      SkillSection(
        category: 'Tools & Technologies',
        skills: [
          Skill(name: 'Git'),
          Skill(name: 'Firebase'),
          Skill(name: 'REST APIs'),
          Skill(name: 'GraphQL'),
          Skill(name: 'CI/CD'),
          Skill(name: 'Fastlane'),
          Skill(name: 'Xcode'),
          Skill(name: 'Android Studio')
        ],
      ),
      SkillSection(
        category: 'Architecture & Patterns',
        skills: [
          Skill(name: 'Clean Architecture'),
          Skill(name: 'MVVM'),
          Skill(name: 'BLoC'),
          Skill(name: 'Provider'),
          Skill(name: 'Riverpod'),
          Skill(name: 'GetX'),
          Skill(name: 'MVC')
        ],
      ),
      SkillSection(
        category: 'Soft Skills',
        skills: [
          Skill(name: 'Open Source Contribution'),
          Skill(name: 'Technical Leadership'),
          Skill(name: 'Mentoring'),
          Skill(name: 'Problem Solving'),
          Skill(name: 'Agile/Scrum'),
          Skill(name: 'Team Collaboration')
        ],
      ),
    ],
    projects: [
      Project(
        title: 'Tawakkalna SDK Flutter',
        description: 'Flutter SDK integration for the Tawakkalna government application, '
            'enabling secure identity verification and COVID-19 health status integration. '
            'Provides seamless integration with Saudi Arabia\'s official health platform.',
        technologies: ['Flutter', 'Dart', 'SDK Development', 'Government APIs'],
        url: 'https://pub.dev/packages/tawakkalna_sdk_flutter',
        skills: ['Flutter', 'Dart', 'Security'],
      ),
      Project(
        title: 'Media Source',
        description: 'Flutter package for advanced media handling and source management, '
            'providing seamless media integration capabilities. Supports multiple media formats '
            'and sources with efficient caching and loading mechanisms.',
        technologies: ['Flutter', 'Dart', 'Media APIs', 'File Handling'],
        url: 'https://pub.dev/packages/media_source',
        skills: ['Media Handling', 'Caching'],
      ),
      Project(
        title: 'File Type Plus',
        description: 'Enhanced file type detection package for Flutter applications, '
            'supporting comprehensive file format identification. Provides accurate MIME type '
            'detection and file extension validation.',
        technologies: ['Flutter', 'Dart', 'File Systems', 'MIME Types'],
        url: 'https://pub.dev/packages/file_type_plus',
        skills: ['File Systems', 'MIME Types'],
      ),
      Project(
        title: 'File Sized',
        description: 'Utility package for file size formatting and management in Flutter, '
            'simplifying file size operations and display. Provides human-readable file size '
            'formatting with customizable units.',
        technologies: ['Flutter', 'Dart', 'Utilities', 'Formatting'],
        url: 'https://pub.dev/packages/file_sized',
        skills: ['Utilities', 'Data Formatting'],
      ),
      Project(
        title: 'Time of Day',
        description: 'Time management and formatting package for Flutter applications, '
            'providing intuitive time selection and display features. Includes custom time '
            'pickers and formatting utilities.',
        technologies: ['Flutter', 'Dart', 'UI Components', 'DateTime'],
        url: 'https://pub.dev/packages/time_of_day',
        skills: ['UI Components', 'DateTime'],
      ),
    ],
    certifications: [
      LicenseAndCertification(
        name: 'Mobile Application Development',
        issuingOrganization: 'Udacity',
        issueDate: '2017',
      ),
    ],
    languages: [
      Language(name: 'Arabic', proficiency: 'Native'),
      Language(name: 'English', proficiency: 'Professional Working Proficiency'),
    ],
    blogs: [
      // Example Placeholder
      Blog(
        title: 'Optimizing Flutter Performance',
        description: 'Tips and tricks for making your Flutter apps fly.',
        url: 'https://medium.com/@hossameldinmi', // Placeholder
        skills: ['Performance', 'Flutter'],
      ),
    ],
  );
}

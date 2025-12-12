// Professional data extracted from Hossam Eldin Mahmoud's resume

import 'package:flutter/material.dart';

class ResumeData {
  // Personal Information
  static const String name = 'Hossam Eldin Mahmoud';
  static const String title = 'Senior Mobile Software Engineer';
  static const String subtitle =
      'Senior Mobile Engineer | Native iOS & Flutter Specialist\nEnterprise Mobile Architecture | Open Source Enthusiast';
  static const String email = 'hossameldinmi@gmail.com';
  static const String linkedIn = 'linkedin.com/in/hossameldinmi';
  static const String github = 'github.com/hossameldinmi';

  // Professional Summary
  static const String summary =
      'Senior Mobile Software Engineer with 7+ years of experience specializing in Flutter and cross-platform '
      'mobile development. Proven track record of building production-ready applications and SDKs for '
      'government services, fintech, and social platforms. Published 5+ open-source packages on pub.dev '
      'with thousands of downloads. Strong expertise in Flutter, Dart, native iOS/Android integration, '
      'and SDK development. Background in Mechanical Engineering with a focus on problem-solving and '
      'technical innovation.';

  // Key Competencies / Skills
  static const List<Map<String, dynamic>> skills = [
    {
      'category': 'Mobile Development',
      'items': [
        'Flutter',
        'Dart',
        'iOS (Swift/Objective-C)',
        'Android (Kotlin/Java)',
        'React Native',
        'Cross-Platform Development'
      ]
    },
    {
      'category': 'Programming Languages',
      'items': ['Dart', 'Swift', 'Kotlin', 'JavaScript', 'TypeScript', 'C#', '.NET', 'Java']
    },
    {
      'category': 'SDK & Integration',
      'items': [
        'SDK Development',
        'Native Bridges',
        'Platform Channels',
        'API Integration',
        'Third-party SDKs',
        'Plugin Development'
      ]
    },
    {
      'category': 'Tools & Technologies',
      'items': ['Git', 'Firebase', 'REST APIs', 'GraphQL', 'CI/CD', 'Fastlane', 'Xcode', 'Android Studio']
    },
    {
      'category': 'Architecture & Patterns',
      'items': ['Clean Architecture', 'MVVM', 'BLoC', 'Provider', 'Riverpod', 'GetX', 'MVC']
    },
    {
      'category': 'Soft Skills',
      'items': [
        'Open Source Contribution',
        'Technical Leadership',
        'Mentoring',
        'Problem Solving',
        'Agile/Scrum',
        'Team Collaboration'
      ]
    },
  ];

  // Work Experience
  static const List<Map<String, String>> experiences = [
    {
      'title': 'Senior Mobile Software Engineer',
      'company': 'Ynmo (Remote)',
      'period': 'Feb 2022 - Present',
      'description': 'Leading mobile development for fintech platform. Architecting and implementing '
          'Flutter applications with focus on performance and scalability. Mentoring team members '
          'and establishing mobile development best practices. Integrating complex financial APIs '
          'and ensuring security compliance. Collaborating with cross-functional teams to deliver '
          'high-quality mobile solutions.',
    },
    {
      'title': 'Senior Mobile Software Engineer',
      'company': 'PortMe (Remote)',
      'period': 'Sep 2021 - Apr 2022',
      'description': 'Developed cross-platform mobile applications using Flutter for telecommunications '
          'platform. Implemented number porting features and real-time status tracking. Collaborated '
          'with backend team to design and integrate RESTful APIs. Optimized app performance and '
          'reduced crash rates by 40%. Enhanced user experience through intuitive UI/UX design.',
    },
    {
      'title': 'Senior Software Engineer',
      'company': 'Facegraph',
      'period': 'Oct 2021 - Jan 2022',
      'description': 'Built social networking features using Flutter and native iOS/Android. Implemented '
          'real-time messaging, media sharing, and social graph features. Worked on SDK development '
          'for third-party integrations. Enhanced app stability and user engagement metrics. '
          'Participated in architectural decisions and code reviews.',
    },
    {
      'title': 'Software Engineer II',
      'company': 'Facegraph',
      'period': 'Dec 2019 - Oct 2021',
      'description': 'Developed mobile applications using Flutter and React Native. Implemented user '
          'authentication, profile management, and content feed features. Collaborated with design '
          'team to create intuitive user interfaces. Participated in code reviews and agile ceremonies. '
          'Contributed to improving development workflows and best practices.',
    },
    {
      'title': 'Specialist Software Engineer - .NET and Cross-Platform',
      'company': 'EME International',
      'period': 'Feb 2019 - Dec 2019',
      'description': 'Developed cross-platform mobile applications using Xamarin and Flutter. Built '
          'enterprise solutions for logistics and supply chain management. Integrated with legacy '
          '.NET backend systems. Provided technical support and training to clients. Participated '
          'in requirement analysis and solution design.',
    },
    {
      'title': 'Associate Software Engineer - .NET and Cross-Platform',
      'company': 'EME International',
      'period': 'Mar 2018 - Feb 2019',
      'description': 'Started career in mobile development with Xamarin and .NET. Contributed to '
          'enterprise mobile applications. Learned mobile development best practices and design '
          'patterns. Participated in requirement gathering and technical documentation. Gained '
          'experience in full software development lifecycle.',
    },
  ];

  // Open Source Projects
  static const List<Map<String, dynamic>> projects = [
    {
      'name': 'Tawakkalna SDK Flutter',
      'description': 'Flutter SDK integration for the Tawakkalna government application, '
          'enabling secure identity verification and COVID-19 health status integration. '
          'Provides seamless integration with Saudi Arabia\'s official health platform.',
      'technologies': ['Flutter', 'Dart', 'SDK Development', 'Government APIs'],
      'url': 'https://pub.dev/packages/tawakkalna_sdk_flutter',
    },
    {
      'name': 'Media Source',
      'description': 'Flutter package for advanced media handling and source management, '
          'providing seamless media integration capabilities. Supports multiple media formats '
          'and sources with efficient caching and loading mechanisms.',
      'technologies': ['Flutter', 'Dart', 'Media APIs', 'File Handling'],
      'url': 'https://pub.dev/packages/media_source',
    },
    {
      'name': 'File Type Plus',
      'description': 'Enhanced file type detection package for Flutter applications, '
          'supporting comprehensive file format identification. Provides accurate MIME type '
          'detection and file extension validation.',
      'technologies': ['Flutter', 'Dart', 'File Systems', 'MIME Types'],
      'url': 'https://pub.dev/packages/file_type_plus',
    },
    {
      'name': 'File Sized',
      'description': 'Utility package for file size formatting and management in Flutter, '
          'simplifying file size operations and display. Provides human-readable file size '
          'formatting with customizable units.',
      'technologies': ['Flutter', 'Dart', 'Utilities', 'Formatting'],
      'url': 'https://pub.dev/packages/file_sized',
    },
    {
      'name': 'Time of Day',
      'description': 'Time management and formatting package for Flutter applications, '
          'providing intuitive time selection and display features. Includes custom time '
          'pickers and formatting utilities.',
      'technologies': ['Flutter', 'Dart', 'UI Components', 'DateTime'],
      'url': 'https://pub.dev/packages/time_of_day',
    },
  ];

  // Contact Information
  static const List<Map<String, dynamic>> contacts = [
    {
      'icon': Icons.email,
      'label': 'Email',
      'value': 'hossameldinmi@gmail.com',
      'url': 'mailto:hossameldinmi@gmail.com',
    },
    {
      'icon': Icons.phone,
      'label': 'Phone',
      'value': '+20 122 848 6542',
      'url': 'tel:+201228486542',
    },
    {
      'icon': Icons.link,
      'label': 'LinkedIn',
      'value': 'linkedin.com/in/hossameldinmi',
      'url': 'https://linkedin.com/in/hossameldinmi',
    },
    {
      'icon': Icons.code,
      'label': 'GitHub',
      'value': 'github.com/hossameldinmi',
      'url': 'https://github.com/hossameldinmi',
    },
  ];

  // Education
  static const List<Map<String, String>> education = [
    {
      'degree': 'Mobile Application Development Nanodegree',
      'institution': 'Udacity',
      'year': '2017',
      'description': 'Comprehensive program covering iOS and Android development, '
          'mobile UI/UX design, and app deployment.',
    },
    {
      'degree': 'Bachelor of Mechanical Engineering',
      'institution': 'University',
      'year': '2016',
      'description': 'Strong foundation in engineering principles, problem-solving, '
          'and analytical thinking.',
    },
  ];

  // Professional Development / Certifications
  static const List<Map<String, String>> certifications = [
    {
      'name': 'Mobile Application Development',
      'issuer': 'Udacity',
      'year': '2017',
    },
  ];

  // Languages
  static const List<Map<String, String>> languages = [
    {
      'language': 'Arabic',
      'proficiency': 'Native',
    },
    {
      'language': 'English',
      'proficiency': 'Professional Working Proficiency',
    },
  ];
}

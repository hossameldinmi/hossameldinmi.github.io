import 'package:cv_website/src/data/skills.dart';
import 'package:cv_website/src/models/company.dart';
import 'package:cv_website/src/models/date_range.dart';
import 'package:cv_website/src/models/experience.dart';
import 'package:media_source/media_source.dart';

class Experiences {
  // Individual Experience static variables
  static final toptalSenior = Experience(
    title: 'Senior Mobile Software Engineer',
    locationType: 'Remote',
    employmentType: 'Freelance',
    dateRange: DateRange(start: DateTime(2025, 11)),
    description:
        '𝑲𝒆𝒚 𝑹𝒆𝒔𝒑𝒐𝒏𝒔𝒊𝒃𝒊𝒍𝒊𝒕𝒊𝒆𝒔:\n• Write simple unit tests to ensure code reliability.\n• Participate in code reviews and follow clean code and best practice standards.\n• Communicate with project leads to clarify requirements and report progress regularly.',
    skills: [
      Skills.technicalDocumentation,
      Skills.aiTools,
      Skills.lifecycleManagement,
      Skills.agileScrum,
      Skills.swift,
      Skills.appProfiling,
      Skills.crossPlatform,
      Skills.ios,
      Skills.reactiveArchitecture,
      Skills.azureDevOps,
      Skills.jwt,
      Skills.debugging,
      Skills.ciCd,
    ],
  );

  static final ynmoSenior = Experience(
    title: 'Senior Mobile Software Engineer',
    locationType: 'Remote',
    employmentType: 'Full-time',
    dateRange: DateRange(start: DateTime(2022, 2)),
    description:
        '𝑲𝒆𝒚 𝑹𝒆𝒔𝒑𝒐𝒏𝒔𝒊𝒃𝒊𝒍𝒊𝒕𝒊𝒆𝒔:\n• Lead the adoption of unit testing and best coding practices to ensure code reliability and maintainability, while incorporating Domain Driven Design (DDD) to align technical solutions with business needs.\n• Led the adoption of AI-assisted development workflows to accelerate feature delivery, refactoring, and automated testing while maintaining clean architecture and code quality.\n• Implement CI/CD pipelines on App Center to reduce release times by 70% and streamline delivery workflows, using Modular Architecture to improve scalability and maintainability.\n• Integrate advanced analytics and logging tools to enhance bug tracking, issue resolution, and overall observability, with a focus on Reactive Architecture for real-time event-driven solutions.\n• Collaborate with cross-functional teams to deliver high-quality, business-aligned mobile solutions, leveraging Domain Driven Design and Modular Architecture principles for robust and flexible systems.\n• Initiate widget testing for complex UI components, strengthening the quality and stability of mobile applications, while applying Reactive Architecture to ensure responsiveness and user-centric design.',
    skills: [
      Skills.technicalDocumentation,
      Skills.aiTools,
      Skills.lifecycleManagement,
      Skills.restApis,
      Skills.refactoring,
      Skills.cleanArchitecture,
      Skills.performanceOptimization,
      Skills.crossPlatform,
      Skills.debugging,
      Skills.ios,
      Skills.reactiveArchitecture,
      Skills.flutter,
      Skills.tdd,
      Skills.featurePlanning,
      Skills.codeReview,
      Skills.dart,
      Skills.domainDrivenDesign,
      Skills.ciCd,
      Skills.teamCollaboration,
      Skills.selfMotivation,
    ],
  );

  static final andelaSenior = Experience(
    title: 'Senior Mobile Software Engineer',
    locationType: 'Remote',
    employmentType: 'Freelance',
    dateRange: DateRange(start: DateTime(2022, 1)),
    description:
        '𝑲𝒆𝒚 𝑹𝒆𝒔𝒑𝒐𝒏𝒔𝒊𝒃𝒊𝒍𝒊𝒕𝒊𝒆𝒔:\n• Support in developing and maintaining mobile applications using Flutter and Dart.\n• Collaborate with team members on small feature implementations and bug fixes.\n• Assist in setting up or improving CI/CD pipelines under team guidance.',
    skills: [
      Skills.technicalDocumentation,
      Skills.lifecycleManagement,
      Skills.refactoring,
      Skills.appProfiling,
      Skills.crossPlatform,
      Skills.codeReview,
      Skills.ios,
      Skills.reactiveArchitecture,
      Skills.featurePlanning,
      Skills.debugging,
    ],
  );

  static final portmeSenior = Experience(
    title: 'Sr. Mobile Software Engineer',
    locationType: 'Remote',
    employmentType: 'Contract',
    dateRange: DateRange(start: DateTime(2021, 9), end: DateTime(2022, 4)),
    description:
        '𝑲𝒆𝒚 𝑹𝒆𝒔𝒑𝒐𝒏𝒔𝒊𝒃𝒊𝒍𝒊𝒕𝒊𝒆𝒔:\n• Led the end-to-end design, development, and deployment of high-performance mobile applications for iOS and Android.\n• Architected scalable, efficient mobile solutions that delivered seamless user experiences across multiple devices.\n• Collaborated with product managers and designers to translate business goals into clear, actionable technical specifications.',
    skills: [
      Skills.technicalDocumentation,
      Skills.lifecycleManagement,
      Skills.restApis,
      Skills.github,
      Skills.crossPlatform,
      Skills.reactiveArchitecture,
      Skills.flutter,
      Skills.tdd,
      Skills.featurePlanning,
      Skills.debugging,
    ],
  );

  static final facegraphSenior = Experience(
    title: 'Senior Software Engineer',
    locationType: 'Remote',
    employmentType: 'Full-time',
    dateRange: DateRange(start: DateTime(2021, 10), end: DateTime(2022, 1)),
    description:
        '𝑲𝒆𝒚 𝑹𝒆𝒔𝒑𝒐𝒏𝒔𝒊𝒃𝒊𝒍𝒊𝒕𝒊𝒆𝒔:\n• Improved code reliability and quality by leading efforts to expand unit testing coverage.\n• Refactored legacy systems into clean, reactive architectures to enhance maintainability and scalability.\n• Designed and implemented CI/CD pipelines on Azure DevOps, optimizing development workflows and accelerating release cycles through build flavor configurations.',
    skills: [
      Skills.technicalDocumentation,
      Skills.lifecycleManagement,
      Skills.tdd,
      Skills.refactoring,
      Skills.agileScrum,
      Skills.crossPlatform,
      Skills.reactiveArchitecture,
      Skills.domainDrivenDesign,
      Skills.git,
      Skills.ios,
      Skills.restApis,
      Skills.openSourceDev,
      Skills.debugging,
      Skills.performanceOptimization,
      Skills.dart,
      Skills.mobileDevelopment,
      Skills.azureDevOps,
      Skills.ciCd,
      Skills.codeReview,
    ],
  );

  static final facegraphMid = Experience(
    title: 'Software Engineer II',
    locationType: 'Hybrid',
    employmentType: 'Full-time',
    dateRange: DateRange(start: DateTime(2019, 12), end: DateTime(2021, 10)),
    description:
        '𝑲𝒆𝒚 𝑹𝒆𝒔𝒑𝒐𝒏𝒔𝒊𝒃𝒊𝒍𝒊𝒕𝒊𝒆𝒔:\n• Enhanced application performance and scalability across platforms, increasing unit testing coverage and maintaining clean code practices.\n• Collaborated with cross-functional teams to design, implement, and deploy new features while refactoring legacy systems to a clean, reactive architecture.\n• Set up CI/CD pipelines on Azure DevOps, introduced build flavors to optimize development and release times, and assisted in defining technical guidelines and coding standards.',
    skills: [
      Skills.lifecycleManagement,
      Skills.restApis,
      Skills.refactoring,
      Skills.xamarin,
      Skills.xamarinForms,
      Skills.agileScrum,
      Skills.crossPlatform,
      Skills.debugging,
      Skills.dotNet,
      Skills.reactiveArchitecture,
      Skills.flutter,
      Skills.tdd,
      Skills.codeReview,
      Skills.performanceOptimization,
      Skills.ciCd,
    ],
  );

  static final emeSpecialist = Experience(
    title: 'Specialist Software Engineer (Cross-Platform)',
    locationType: 'On-site',
    employmentType: 'Full-time',
    dateRange: DateRange(start: DateTime(2019, 2), end: DateTime(2019, 12)),
    description:
        '𝑲𝒆𝒚 𝑹𝒆𝒔𝒑𝒐𝒏𝒔𝒊𝒃𝒊𝒍𝒊𝒕𝒊𝒆𝒔:\n• Enhanced performance and code readability.\n• Initiated coding standards and guidelines with the team leader.\n• Integrating with analytics providers for apps.\n• Revamping Xamarin Core layer project into Flutter.',
    skills: [
      Skills.lifecycleManagement,
      Skills.restApis,
      Skills.xamarin,
      Skills.xamarinForms,
      Skills.crossPlatform,
      Skills.debugging,
      Skills.dotNet,
      Skills.cSharp,
      Skills.selfMotivation,
      Skills.codeReview,
      Skills.linq,
    ],
  );

  static final emeAssociate = Experience(
    title: 'Associate Software Engineer (Cross-Platform)',
    locationType: 'On-site',
    employmentType: 'Full-time',
    dateRange: DateRange(start: DateTime(2018, 3), end: DateTime(2019, 2)),
    description:
        '𝑲𝒆𝒚 𝑹𝒆𝒔𝒑𝒐𝒏𝒔𝒊𝒃𝒊𝒍𝒊𝒕𝒊𝒆𝒔:\n• Building Cross-Platform Apps using Xamarin.Forms.\n• Integrating with any backend APIs.\n• Release and Publish Apps to the Store.',
    skills: [
      Skills.lifecycleManagement,
      Skills.restApis,
      Skills.xamarin,
      Skills.xamarinForms,
      Skills.crossPlatform,
      Skills.debugging,
      Skills.dotNet,
      Skills.cSharp,
      Skills.selfMotivation,
      Skills.linq,
    ],
  );

  // Company list for UI display
  static final values = [
    Company(
      name: 'Toptal',
      location: 'San Francisco, California, United States',
      logo: ImageAssetMedia(
        assetPath: 'assets/toptal_logo.png',
        mimeType: 'image/png',
        name: 'toptal_logo.png',
        size: 45.5.kb,
      ),
      experiences: [toptalSenior],
    ),
    Company(
      name: 'Ynmo | ينمو',
      location: 'Mecca, Makkah, Saudi Arabia',
      logo: ImageAssetMedia(
        assetPath: 'assets/ynmo_logo.png',
        mimeType: 'image/png',
        name: 'ynmo_logo.png',
        size: 4.03.kb,
      ),
      experiences: [ynmoSenior],
    ),
    Company(
      name: 'Andela',
      location: 'New York, United States',
      logo: ImageAssetMedia(
        assetPath: 'assets/andela_logo.png',
        mimeType: 'image/png',
        name: 'andela_logo.png',
        size: 3.kb,
      ),
      experiences: [andelaSenior],
    ),
    Company(
      name: 'Portme',
      location: 'California, United States',
      logo: ImageAssetMedia(
        assetPath: 'assets/portme_logo.png',
        mimeType: 'image/png',
        name: 'portme_logo.png',
        size: 3.86.kb,
      ),
      experiences: [portmeSenior],
    ),
    Company(
      name: 'Facegraph',
      location: 'California, United States',
      logo: ImageAssetMedia(
        assetPath: 'assets/facegraph_logo.png',
        mimeType: 'image/png',
        name: 'facegraph_logo.png',
        size: 883.b,
      ),
      experiences: [facegraphSenior, facegraphMid],
    ),
    Company(
      name: 'EME International',
      location: 'Maadi, Cairo, Egypt',
      logo: ImageAssetMedia(
        assetPath: 'assets/eme_logo.png',
        mimeType: 'image/png',
        name: 'eme_logo.png',
        size: 6.68.kb,
      ),
      experiences: [emeSpecialist, emeAssociate],
    ),
  ];
}

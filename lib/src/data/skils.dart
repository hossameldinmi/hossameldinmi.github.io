import 'package:cv_website/src/models/skill.dart';
import 'package:cv_website/src/models/skill_section.dart';

class Skills {
  // Mobile Development
  static final flutter = Skill(name: 'Flutter');
  static final dart = Skill(name: 'Dart');
  static final ios = Skill(name: 'iOS (Swift/Objective-C)');
  static final crossPlatform = Skill(name: 'Cross-Platform Development');
  static final performanceOptimization = Skill(name: 'Performance Optimization');
  static final xamarin = Skill(name: 'Xamarin');
  static final mobileDevelopment = Skill(name: 'Mobile Development');

  // Programming Languages
  static final swift = Skill(name: 'Swift');
  static final javascript = Skill(name: 'JavaScript');
  static final typescript = Skill(name: 'TypeScript');
  static final cSharp = Skill(name: 'C#');
  static final dotNet = Skill(name: '.NET');
  static final java = Skill(name: 'Java');

  // SDK & Integration
  static final sdkDevelopment = Skill(name: 'SDK Development');
  static final nativeBridges = Skill(name: 'Native Bridges');
  static final platformChannels = Skill(name: 'Platform Channels');
  static final apiIntegration = Skill(name: 'API Integration');
  static final thirdPartySdks = Skill(name: 'Third-party SDKs');
  static final pluginDevelopment = Skill(name: 'Plugin Development');

  // Tools & Technologies
  static final git = Skill(name: 'Git');
  static final firebase = Skill(name: 'Firebase');
  static final restApis = Skill(name: 'REST APIs');
  static final graphQL = Skill(name: 'GraphQL');
  static final ciCd = Skill(name: 'CI/CD');
  static final xcode = Skill(name: 'Xcode');
  static final androidStudio = Skill(name: 'Android Studio');

  // Architecture & Patterns
  static final cleanArchitecture = Skill(name: 'Clean Architecture');
  static final mvvm = Skill(name: 'MVVM');
  static final bloc = Skill(name: 'BLoC');
  static final provider = Skill(name: 'Provider');
  static final riverpod = Skill(name: 'Riverpod');
  static final getX = Skill(name: 'GetX');
  static final mvc = Skill(name: 'MVC');

  // Soft Skills
  static final openSourceContribution = Skill(name: 'Open Source Contribution');
  static final technicalLeadership = Skill(name: 'Technical Leadership');
  static final mentoring = Skill(name: 'Mentoring');
  static final problemSolving = Skill(name: 'Problem Solving');
  static final agileScrum = Skill(name: 'Agile/Scrum');
  static final teamCollaboration = Skill(name: 'Team Collaboration');

  static final sections = [
    SkillSection(
      category: 'Mobile Development',
      skills: [
        flutter,
        dart,
        ios,
        crossPlatform,
      ],
    ),
    SkillSection(
      category: 'Programming Languages',
      skills: [
        dart,
        swift,
        javascript,
        typescript,
        cSharp,
        dotNet,
        java,
      ],
    ),
    SkillSection(
      category: 'SDK & Integration',
      skills: [
        sdkDevelopment,
        nativeBridges,
        platformChannels,
        apiIntegration,
        thirdPartySdks,
        pluginDevelopment,
      ],
    ),
    SkillSection(
      category: 'Tools & Technologies',
      skills: [
        git,
        firebase,
        restApis,
        graphQL,
        ciCd,
        xcode,
        androidStudio,
      ],
    ),
    SkillSection(
      category: 'Architecture & Patterns',
      skills: [
        cleanArchitecture,
        mvvm,
        bloc,
        provider,
        riverpod,
        getX,
        mvc,
      ],
    ),
    SkillSection(
      category: 'Soft Skills',
      skills: [
        openSourceContribution,
        technicalLeadership,
        mentoring,
        problemSolving,
        agileScrum,
        teamCollaboration,
      ],
    ),
  ];
}

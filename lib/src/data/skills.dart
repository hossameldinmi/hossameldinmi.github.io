import 'package:cv_website/src/models/skill.dart';
import 'package:cv_website/src/models/skill_section.dart';

class Skills {
  // Mobile Development
  static final flutter = Skill(name: 'Flutter', proficiency: SkillProficiency.expert);
  static final ios = Skill(name: 'iOS Development', proficiency: SkillProficiency.beginner);
  static final crossPlatform = Skill(name: 'Cross-Platform Development', proficiency: SkillProficiency.expert);
  static final performanceOptimization =
      Skill(name: 'Performance Optimization', proficiency: SkillProficiency.advanced);
  static final xamarin = Skill(name: 'Xamarin', proficiency: SkillProficiency.advanced);
  static final xamarinForms = Skill(name: 'Xamarin.Forms', proficiency: SkillProficiency.advanced);
  static final mobileDevelopment = Skill(name: 'Mobile Development', proficiency: SkillProficiency.expert);
  static final appProfiling = Skill(name: 'App Performance Profiling', proficiency: SkillProficiency.intermediate);
  static final lifecycleManagement =
      Skill(name: 'Mobile App Lifecycle Management', proficiency: SkillProficiency.advanced);

  // Programming Languages
  static final swift = Skill(name: 'Swift', proficiency: SkillProficiency.advanced);
  static final dart = Skill(name: 'Dart', proficiency: SkillProficiency.expert);
  static final cSharp = Skill(name: 'C#', proficiency: SkillProficiency.advanced);
  static final dotNet = Skill(name: '.NET Framework', proficiency: SkillProficiency.advanced);
  static final java = Skill(name: 'Java', proficiency: SkillProficiency.intermediate);

  // SDK & Integration
  static final sdkDevelopment = Skill(name: 'SDK Development', proficiency: SkillProficiency.expert);
  static final nativeBridges = Skill(name: 'Native Bridges', proficiency: SkillProficiency.expert);
  static final platformChannels = Skill(name: 'Platform Channels', proficiency: SkillProficiency.expert);
  static final apiIntegration = Skill(name: 'API Integration', proficiency: SkillProficiency.expert);
  static final thirdPartySdks = Skill(name: 'Third-party SDKs', proficiency: SkillProficiency.advanced);
  static final pluginDevelopment = Skill(name: 'Plugin Development', proficiency: SkillProficiency.expert);
  static final openSourceDev = Skill(name: 'Open-Source Development', proficiency: SkillProficiency.expert);

  // Tools & Technologies
  static final git = Skill(name: 'Git', proficiency: SkillProficiency.expert);
  static final github = Skill(name: 'GitHub', proficiency: SkillProficiency.expert);
  static final firebase = Skill(name: 'Firebase', proficiency: SkillProficiency.advanced);
  static final restApis = Skill(name: 'REST APIs', proficiency: SkillProficiency.expert);
  static final graphQL = Skill(name: 'GraphQL', proficiency: SkillProficiency.intermediate);
  static final ciCd = Skill(name: 'CI/CD', proficiency: SkillProficiency.advanced);
  static final xcode = Skill(name: 'Xcode', proficiency: SkillProficiency.advanced);
  static final androidStudio = Skill(name: 'Android Studio', proficiency: SkillProficiency.intermediate);
  static final vscode = Skill(name: 'VS Code', proficiency: SkillProficiency.expert);
  static final azureDevOps = Skill(name: 'Azure DevOps', proficiency: SkillProficiency.intermediate);
  static final jwt = Skill(name: 'JWT', proficiency: SkillProficiency.advanced);
  static final linq = Skill(name: 'LINQ', proficiency: SkillProficiency.advanced);
  static final aiTools = Skill(name: 'AI Tools (Copilot, Cursor, Windsurf)', proficiency: SkillProficiency.expert);

  // Architecture & Patterns
  static final cleanArchitecture = Skill(name: 'Clean Architecture', proficiency: SkillProficiency.expert);
  static final domainDrivenDesign = Skill(name: 'Domain-Driven Design', proficiency: SkillProficiency.advanced);
  static final mvvm = Skill(name: 'MVVM', proficiency: SkillProficiency.expert);
  static final bloc = Skill(name: 'BLoC', proficiency: SkillProficiency.expert);
  static final provider = Skill(name: 'Provider', proficiency: SkillProficiency.expert);
  static final riverpod = Skill(name: 'Riverpod', proficiency: SkillProficiency.advanced);
  static final getX = Skill(name: 'GetX', proficiency: SkillProficiency.advanced);
  static final mvc = Skill(name: 'MVC', proficiency: SkillProficiency.expert);
  static final oop = Skill(name: 'Object-Oriented Programming', proficiency: SkillProficiency.expert);
  static final oodDesign = Skill(name: 'Object-Oriented Design', proficiency: SkillProficiency.expert);
  static final reactiveArchitecture = Skill(name: 'Reactive Architecture', proficiency: SkillProficiency.advanced);
  static final uml = Skill(name: 'UML', proficiency: SkillProficiency.intermediate);

  // Software Engineering Practices
  static final tdd = Skill(name: 'Test Driven Development', proficiency: SkillProficiency.advanced);
  static final debugging = Skill(name: 'Debugging & Issue Tracking', proficiency: SkillProficiency.expert);
  static final codeReview = Skill(name: 'Code Review & Quality Assurance', proficiency: SkillProficiency.expert);
  static final refactoring = Skill(name: 'Refactoring Legacy Systems', proficiency: SkillProficiency.advanced);
  static final technicalDebt = Skill(name: 'Managing Technical Debt', proficiency: SkillProficiency.advanced);
  static final sdlc = Skill(name: 'Software Development Life Cycle', proficiency: SkillProficiency.expert);
  static final technicalDocumentation =
      Skill(name: 'Technical Documentation Writing', proficiency: SkillProficiency.advanced);

  // Soft Skills
  static final openSourceContribution = Skill(name: 'Open Source Contribution', proficiency: SkillProficiency.expert);
  static final technicalLeadership = Skill(name: 'Technical Leadership', proficiency: SkillProficiency.expert);
  static final mentoring = Skill(name: 'Mentoring', proficiency: SkillProficiency.advanced);
  static final problemSolving = Skill(name: 'Problem Solving', proficiency: SkillProficiency.expert);
  static final agileScrum = Skill(name: 'Agile Software Development', proficiency: SkillProficiency.expert);
  static final teamCollaboration = Skill(name: 'Team Collaboration', proficiency: SkillProficiency.expert);
  static final selfMotivation = Skill(name: 'Self-Motivation', proficiency: SkillProficiency.expert);
  static final featurePlanning =
      Skill(name: 'Feature Planning & Sprint Execution', proficiency: SkillProficiency.expert);

  static final sections = [
    SkillSection(
      category: 'Technical Skills',
      skills: [
        // Expert Level
        flutter,
        crossPlatform,
        mobileDevelopment,
        dart,
        sdkDevelopment,
        nativeBridges,
        platformChannels,
        apiIntegration,
        pluginDevelopment,
        openSourceDev,
        git,
        github,
        restApis,
        vscode,
        aiTools,
        cleanArchitecture,
        oop,
        oodDesign,
        mvvm,
        mvc,
        bloc,
        provider,
        debugging,
        codeReview,
        sdlc,
        // Advanced Level
        ios,
        xamarin,
        xamarinForms,
        performanceOptimization,
        lifecycleManagement,
        swift,
        cSharp,
        dotNet,
        thirdPartySdks,
        firebase,
        jwt,
        linq,
        ciCd,
        xcode,
        domainDrivenDesign,
        riverpod,
        getX,
        reactiveArchitecture,
        tdd,
        refactoring,
        technicalDebt,
        technicalDocumentation,
        // Intermediate Level
        appProfiling,
        java,
        graphQL,
        androidStudio,
        azureDevOps,
        uml,
      ],
    ),
    SkillSection(
      category: 'Soft Skills',
      skills: [
        // Expert Level
        technicalLeadership,
        agileScrum,
        featurePlanning,
        problemSolving,
        openSourceContribution,
        teamCollaboration,
        selfMotivation,
        // Advanced Level
        mentoring,
      ],
    ),
  ];
}

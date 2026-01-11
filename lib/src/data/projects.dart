import 'package:cv_website/src/data/experiences.dart';
import 'package:cv_website/src/data/skills.dart';
import 'package:cv_website/src/models/media.dart';
import 'package:cv_website/src/models/project.dart';
import 'package:media_source/media_source.dart';

class Projects {
  static final values = [
    // Open Source Packages
    Project(
      title: 'File Type Plus - Dart/Flutter Package',
      description: 'A comprehensive file type detection library for Dart and Flutter applications. '
          'Supports over 200 file formats with byte-level signature analysis. Perfect for file upload '
          'validation, content management systems, file browsers, media galleries, and any application '
          'that needs reliable file type detection. Built with 100% test coverage and full null safety support. '
          '+3K Downloads on pub.dev.',
      media: [
        Media(
          media: UrlMedia.url('https://pub.dev/packages/file_type_plus'),
          title: 'pub.dev Package',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://github.com/hossameldinmi/file_type_plus'),
          title: 'GitHub Repository',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.dart,
        Skills.flutter,
        Skills.openSourceDev,
        Skills.ciCd,
        Skills.aiTools,
        Skills.github,
      ],
      experiences: [
        Experiences.toptalSenior,
        Experiences.andelaSenior,
      ],
    ),
    Project(
      title: 'Media Source - Flutter Package',
      description: 'Flutter package for advanced media handling and source management, '
          'providing seamless media integration capabilities. Supports multiple media formats '
          'and sources with efficient caching and loading mechanisms.',
      logo: Media(
        media:
            ImageNetworkMedia.url('https://raw.githubusercontent.com/hossameldinmi/media_source/main/assets/icon.png'),
        title: 'icon.png',
        type: MediaType.image,
      ),
      media: [
        Media(
          media: UrlMedia.url('https://pub.dev/packages/media_source'),
          title: 'pub.dev Package',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://github.com/hossameldinmi/media_source'),
          title: 'GitHub Repository',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.dart,
        Skills.flutter,
        Skills.openSourceDev,
        Skills.ciCd,
        Skills.aiTools,
        Skills.github,
      ],
      experiences: [
        Experiences.toptalSenior,
        Experiences.andelaSenior,
      ],
    ),
    Project(
      title: 'Paging Plus - Dart/Flutter Package',
      description: 'A powerful and flexible pagination package for Dart and Flutter applications, '
          'providing efficient data loading and scroll management for large datasets.',
      media: [
        Media(
          media: UrlMedia.url('https://pub.dev/packages/paging_plus'),
          title: 'pub.dev Package',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://github.com/hossameldinmi/paging_plus'),
          title: 'GitHub Repository',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.dart,
        Skills.flutter,
        Skills.openSourceDev,
        Skills.ciCd,
        Skills.aiTools,
        Skills.github,
      ],
      experiences: [
        Experiences.toptalSenior,
        Experiences.andelaSenior,
      ],
    ),
    Project(
      title: 'Tawakkalna SDK for Flutter',
      description: 'Flutter SDK integration for the Tawakkalna government application, '
          'enabling secure identity verification and COVID-19 health status integration. '
          'Provides seamless integration with Saudi Arabia\'s official health platform.',
      logo: Media(
        media: ImageNetworkMedia.url(
            'https://raw.githubusercontent.com/hossameldinmi/tawakkalna_sdk_flutter/main/doc/icon.png'),
        title: 'icon.png',
        type: MediaType.image,
      ),
      media: [
        Media(
          media: UrlMedia.url('https://pub.dev/packages/tawakkalna_sdk_flutter'),
          title: 'pub.dev Package',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://github.com/hossameldinmi/tawakkalna_sdk_flutter'),
          title: 'GitHub Repository',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.dart,
        Skills.flutter,
        Skills.openSourceDev,
        Skills.ciCd,
        Skills.aiTools,
        Skills.github,
        Skills.sdkDevelopment,
      ],
      experiences: [],
    ),
    Project(
      title: 'Time of Day - Dart/Flutter Package',
      description: 'A type-safe Dart package for representing and manipulating time of day values with '
          'microsecond precision, supporting AM/PM periods, time comparisons, and safe arithmetic operations.',
      logo: Media(
        media:
            ImageNetworkMedia.url('https://raw.githubusercontent.com/hossameldinmi/time_of_day/main/assets/icon.png'),
        title: 'icon.png',
        type: MediaType.image,
      ),
      media: [
        Media(
          media: UrlMedia.url('https://pub.dev/packages/time_of_day'),
          title: 'pub.dev Package',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://github.com/hossameldinmi/time_of_day'),
          title: 'GitHub Repository',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.dart,
        Skills.flutter,
        Skills.openSourceDev,
        Skills.ciCd,
        Skills.aiTools,
        Skills.github,
      ],
      experiences: [
        Experiences.toptalSenior,
        Experiences.andelaSenior,
      ],
    ),
    Project(
      title: 'File Sized - Dart/Flutter Package',
      description: 'A lightweight and intuitive Dart package for file size conversions and formatting them '
          'for human-readable display. Convert between bytes(B), kilobytes(KB), megabytes(MB), gigabytes(GB), '
          'and terabytes(TB) using constructors or convenient extension methods. Supports arithmetic operations, '
          'comparisons, and localization for a complete file size handling solution.',
      logo: Media(
        media: ImageNetworkMedia.url('https://raw.githubusercontent.com/hossameldinmi/file_sized/main/assets/icon.png'),
        title: 'icon.png',
        type: MediaType.image,
      ),
      media: [
        Media(
          media: UrlMedia.url('https://pub.dev/packages/file_sized'),
          title: 'pub.dev Package',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://github.com/hossameldinmi/file_sized'),
          title: 'GitHub Repository',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.dart,
        Skills.flutter,
        Skills.openSourceDev,
        Skills.ciCd,
        Skills.aiTools,
        Skills.github,
      ],
      experiences: [
        Experiences.toptalSenior,
        Experiences.andelaSenior,
      ],
    ),

    // Ynmo Projects
    Project(
      title: 'Ynmo - Warif',
      description: 'Mobile application for Warif educational services powered by Ynmo platform. '
          'Provides comprehensive educational management and tracking features for schools and educators.',
      logo: Media(
        media: ImageAssetMedia(
          assetPath: 'assets/warif.png',
          mimeType: 'image/png',
          name: 'warif.png',
          size: 4.03.kb,
        ),
        title: 'warif.png',
        type: MediaType.image,
      ),
      media: [
        Media(
          media: UrlMedia.url('https://apps.apple.com/kw/app/ynmo-warif/id6743444953'),
          title: 'App Store',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://play.google.com/store/apps/details?id=com.ynmo.schools.warif&hl=en_US'),
          title: 'Google Play Store',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.dart,
        Skills.flutter,
        Skills.debugging,
        Skills.cleanArchitecture,
        Skills.technicalDocumentation,
        Skills.lifecycleManagement,
        Skills.crossPlatform,
        Skills.codeReview,
        Skills.reactiveArchitecture,
        Skills.performanceOptimization,
      ],
      experiences: [
        Experiences.ynmoSenior,
      ],
    ),
    Project(
      title: 'Mahd - Daycare Management',
      description: 'Comprehensive daycare management system for early childhood education centers. '
          'Streamlines operations, parent communication, and child development tracking.',
      logo: Media(
        media: ImageAssetMedia(
          assetPath: 'assets/mahd.png',
          mimeType: 'image/png',
          name: 'mahd.png',
          size: 4.03.kb,
        ),
        title: 'mahd.png',
        type: MediaType.image,
      ),
      media: [
        Media(
          media: UrlMedia.url('https://apps.apple.com/eg/app/mahd/id6741514365'),
          title: 'App Store',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://play.google.com/store/apps/details?id=com.ynmo.daycares.pif&hl=en_US'),
          title: 'Google Play Store',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://appgallery.huawei.com/app/C113411347'),
          title: 'Huawei AppGallery',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.dart,
        Skills.flutter,
        Skills.debugging,
        Skills.cleanArchitecture,
        Skills.technicalDocumentation,
        Skills.lifecycleManagement,
        Skills.crossPlatform,
        Skills.codeReview,
        Skills.reactiveArchitecture,
        Skills.performanceOptimization,
      ],
      experiences: [
        Experiences.ynmoSenior,
      ],
    ),
    Project(
      title: 'Ynmo - MOD (Ministry of Defense)',
      description: 'Specialized educational management application for Ministry of Defense schools, '
          'providing comprehensive support for special education services and rehabilitation programs.',
      logo: Media(
        media: ImageAssetMedia(
          assetPath: 'assets/mod.png',
          mimeType: 'image/png',
          name: 'mod.png',
          size: 4.03.kb,
        ),
        title: 'mod.png',
        type: MediaType.image,
      ),
      media: [
        Media(
          media: UrlMedia.url('https://apps.apple.com/eg/app/ynmo-defense/id6740533290'),
          title: 'App Store',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://play.google.com/store/apps/details?id=com.ynmo.tifli.mod&hl=en'),
          title: 'Google Play Store',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.dart,
        Skills.flutter,
        Skills.debugging,
        Skills.cleanArchitecture,
        Skills.technicalDocumentation,
        Skills.lifecycleManagement,
        Skills.crossPlatform,
        Skills.codeReview,
        Skills.reactiveArchitecture,
        Skills.performanceOptimization,
      ],
      experiences: [
        Experiences.ynmoSenior,
      ],
    ),
    Project(
      title: 'Ynmo - Daycare',
      description: 'A comprehensive system that simplifies the management of childcare centers. '
          'Everything you need to manage childcare centers in one system! Supports activity planning, '
          'parent communication, attendance tracking, and child development monitoring.',
      logo: Media(
        media: ImageAssetMedia(
          assetPath: 'assets/daycare.png',
          mimeType: 'image/png',
          name: 'daycare.png',
          size: 4.03.kb,
        ),
        title: 'daycare.png',
        type: MediaType.image,
      ),
      media: [
        Media(
          media: UrlMedia.url('https://play.google.com/store/apps/details?id=com.ynmo.daycare&hl=en'),
          title: 'Google Play Store',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://apps.apple.com/eg/app/ynmo-daycare/id6451186636'),
          title: 'App Store',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://appgallery.huawei.com/app/C109751001'),
          title: 'Huawei AppGallery',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://daycare.ynmodata.com'),
          title: 'Website',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.dart,
        Skills.flutter,
        Skills.debugging,
        Skills.refactoring,
        Skills.cleanArchitecture,
        Skills.technicalDocumentation,
        Skills.lifecycleManagement,
        Skills.crossPlatform,
        Skills.codeReview,
        Skills.reactiveArchitecture,
        Skills.performanceOptimization,
      ],
      experiences: [
        Experiences.ynmoSenior,
      ],
    ),
    Project(
      title: 'Ynmo - Plan | ينمو - بلان',
      description: 'Ynmo is a digital platform designed to transform how educational and rehabilitation '
          'services are delivered to individuals with disabilities. It supports special education teachers, '
          'behavior analysts, speech, occupational, and physical therapists by simplifying every step of their '
          'workflow—before, during, and after therapy sessions. The platform streamlines documentation, progress '
          'tracking, and communication, helping professionals provide more efficient, consistent, and impactful '
          'support to children with disabilities in both school and home settings.',
      logo: Media(
        media: ImageAssetMedia(
          assetPath: 'assets/plan.png',
          mimeType: 'image/png',
          name: 'plan.png',
          size: 4.03.kb,
        ),
        title: 'plan.png',
        type: MediaType.image,
      ),
      media: [
        Media(
          media: UrlMedia.url('https://play.google.com/store/apps/details?id=io.softcare.ynmo.android&hl=en'),
          title: 'Google Play Store',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://apps.apple.com/sa/app/ynmo-plan/id1492633399'),
          title: 'App Store',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://appgallery.huawei.com/app/C103366721'),
          title: 'Huawei AppGallery',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://ynmodata.com/en/school/'),
          title: 'Website',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.dart,
        Skills.flutter,
        Skills.debugging,
        Skills.refactoring,
        Skills.cleanArchitecture,
        Skills.domainDrivenDesign,
        Skills.technicalDocumentation,
        Skills.lifecycleManagement,
        Skills.crossPlatform,
        Skills.codeReview,
        Skills.reactiveArchitecture,
        Skills.performanceOptimization,
      ],
      experiences: [
        Experiences.ynmoSenior,
      ],
    ),
    Project(
      title: 'Ynmo - Sharjah',
      description: 'Specialized version of Ynmo platform for Sharjah educational institutions. '
          'Provides comprehensive support for Special Education Teachers, Behavior Analysts, Speech Therapists, '
          'Occupational Therapists, and Physical Therapists delivering school-based or home-based services '
          'to children with disabilities.',
      logo: Media(
        media: ImageAssetMedia(
          assetPath: 'assets/schs.png',
          mimeType: 'image/png',
          name: 'schs.png',
          size: 4.03.kb,
        ),
        title: 'schs.png',
        type: MediaType.image,
      ),
      media: [
        Media(
          media: UrlMedia.url('https://apps.apple.com/us/app/ynmo-schs/id6443915348'),
          title: 'App Store',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://play.google.com/store/apps/details?id=com.ynmodata.sharjah&hl=en'),
          title: 'Google Play Store',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://appgallery.huawei.com/app/C107566553'),
          title: 'Huawei AppGallery',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.dart,
        Skills.flutter,
        Skills.debugging,
        Skills.refactoring,
        Skills.cleanArchitecture,
        Skills.technicalDocumentation,
        Skills.lifecycleManagement,
        Skills.crossPlatform,
        Skills.codeReview,
        Skills.reactiveArchitecture,
        Skills.performanceOptimization,
      ],
      experiences: [
        Experiences.ynmoSenior,
      ],
    ),
    Project(
      title: 'Ynmo - Tifli | ينمو - طفلي',
      description: 'Faseeh Initiative application for early intervention of language disorders among children '
          'from 8 months to 36 months. Provides early detection of language disorders, free sessions for over '
          '10,000 children across Saudi Arabia, comprehensive assessment services, early intervention programs, '
          'awareness campaigns, and training programs for caregivers.',
      logo: Media(
        media: ImageAssetMedia(
          assetPath: 'assets/tifli.png',
          mimeType: 'image/png',
          name: 'tifli.png',
          size: 4.03.kb,
        ),
        title: 'tifli.png',
        type: MediaType.image,
      ),
      media: [
        Media(
          media: UrlMedia.url('https://apps.apple.com/eg/app/ynmo-tifli/id6443390362'),
          title: 'App Store',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://play.google.com/store/apps/details?id=com.tatralab.ynmo_parent&hl=en'),
          title: 'Google Play Store',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://appgallery.huawei.com/app/C107540835'),
          title: 'Huawei AppGallery',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://ynmodata.com/en/tifli/'),
          title: 'Website',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://tifli.ynmodata.com/'),
          title: 'Platform',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.dart,
        Skills.flutter,
        Skills.debugging,
        Skills.refactoring,
        Skills.cleanArchitecture,
        Skills.domainDrivenDesign,
        Skills.technicalDocumentation,
        Skills.lifecycleManagement,
        Skills.crossPlatform,
        Skills.codeReview,
        Skills.restApis,
        Skills.reactiveArchitecture,
        Skills.performanceOptimization,
      ],
      experiences: [
        Experiences.ynmoSenior,
      ],
    ),
    Project(
      title: 'كاشف | Kashef - Autism Screening',
      description: 'Application provided by King Salman Relief and Humanitarian Aid Center in partnership '
          'with Ynmo. Helps determine if a child needs comprehensive autism assessment. Provides educational '
          'and awareness content about autism, specifically targeting children and families in refugee camps.',
      logo: Media(
        media: ImageAssetMedia(
          assetPath: 'assets/kashef.png',
          mimeType: 'image/png',
          name: 'kashef.png',
          size: 4.03.kb,
        ),
        title: 'kashef.png',
        type: MediaType.image,
      ),
      media: [
        Media(
          media: UrlMedia.url(
              'https://play.google.com/store/apps/details?id=io.softcare.ynmo.android.ksc.family&hl=en_US'),
          title: 'Google Play Store',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://apps.apple.com/ae/app/kashef-%D9%83%D8%A7%D8%B4%D9%81/id1636641638'),
          title: 'App Store',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url('https://appgallery.huawei.com/app/C106801261'),
          title: 'Huawei AppGallery',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.dart,
        Skills.flutter,
        Skills.debugging,
        Skills.cleanArchitecture,
        Skills.domainDrivenDesign,
        Skills.technicalDocumentation,
        Skills.lifecycleManagement,
        Skills.crossPlatform,
        Skills.codeReview,
        Skills.reactiveArchitecture,
        Skills.performanceOptimization,
      ],
      experiences: [
        Experiences.ynmoSenior,
      ],
    ),
    Project(
      title: 'نمائي | Namaai - Developmental Screening',
      description: 'Namaai App helps caregivers assess their child\'s behavior to determine if further '
          'evaluation for autism or other developmental disorders may be needed. Provides a comprehensive list '
          'of diagnostic and early intervention service providers in Saudi Arabia, along with empirically '
          'validated information and resources for parents.',
      logo: Media(
        media: ImageAssetMedia(
          assetPath: 'assets/namaai.png',
          mimeType: 'image/png',
          name: 'namaai.png',
          size: 4.03.kb,
        ),
        title: 'namaai.png',
        type: MediaType.image,
      ),
      media: [
        Media(
          media: UrlMedia.url('https://apps.apple.com/sa/app/namaai/id1607722385'),
          title: 'App Store',
          type: MediaType.link,
        ),
        Media(
          media: UrlMedia.url(
              'https://play.google.com/store/apps/details?id=io.softcare.ynmo.android.shc.family&hl=ar&gl=US'),
          title: 'Google Play Store',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.dart,
        Skills.flutter,
        Skills.debugging,
        Skills.cleanArchitecture,
        Skills.technicalDocumentation,
        Skills.lifecycleManagement,
        Skills.crossPlatform,
        Skills.codeReview,
        Skills.reactiveArchitecture,
        Skills.performanceOptimization,
      ],
      experiences: [
        Experiences.ynmoSenior,
      ],
    ),

    // Other Projects
    Project(
      title: 'Portme',
      description: 'Digital portfolio and personal branding platform enabling professionals to showcase '
          'their work, skills, and achievements in a modern, interactive format.',
      logo: Media(
        media: ImageAssetMedia(
          assetPath: 'assets/portme_logo.png',
          mimeType: 'image/png',
          name: 'portme_logo.png',
          size: 3.86.kb,
        ),
        title: 'icon.png',
        type: MediaType.image,
      ),
      media: [
        Media(
          media: UrlMedia.url('https://portme.app/'),
          title: 'Website',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.dart,
        Skills.flutter,
        Skills.debugging,
        Skills.technicalDocumentation,
        Skills.lifecycleManagement,
        Skills.crossPlatform,
        Skills.codeReview,
        Skills.restApis,
        Skills.reactiveArchitecture,
        Skills.performanceOptimization,
      ],
      experiences: [
        Experiences.portmeSenior,
      ],
    ),
    Project(
      title: 'Connect - FaceGraph',
      description: 'FaceGraph provides cutting-edge technology building a set of tightly integrated software '
          '& hardware that provides the best attendance tracking and access control solutions. Features frictionless '
          'attendance tracking, powerful & safe facial recognition, world-class support, and around-the-clock reliability.',
      media: [
        Media(
          media: UrlMedia.url('https://facegraph.com/'),
          title: 'Website',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.dart,
        Skills.flutter,
        Skills.debugging,
        Skills.refactoring,
        Skills.cleanArchitecture,
        Skills.technicalDocumentation,
        Skills.lifecycleManagement,
        Skills.crossPlatform,
        Skills.codeReview,
        Skills.restApis,
        Skills.reactiveArchitecture,
        Skills.performanceOptimization,
      ],
      experiences: [
        Experiences.facegraphSenior,
      ],
    ),
    Project(
      title: 'O7 Therapy',
      description: 'Online platform offering convenient access to psychotherapy services. '
          'Connects patients with licensed therapists for remote mental health support.',
      logo: Media(
        media: ImageAssetMedia(
          assetPath: 'assets/o7.jpg',
          mimeType: 'image/jpeg',
          name: 'o7.jpg',
          size: 4.03.kb,
        ),
        title: 'o7.jpg',
        type: MediaType.image,
      ),
      media: [
        Media(
          media: UrlMedia.url('https://play.google.com/store/apps/details?id=com.eme.o7&hl=en'),
          title: 'Google Play Store',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.cSharp,
        Skills.technicalDocumentation,
        Skills.lifecycleManagement,
        Skills.crossPlatform,
        Skills.restApis,
        Skills.xamarin,
        Skills.xamarinForms,
      ],
      experiences: [
        Experiences.emeSpecialist,
      ],
    ),
    Project(
      title: 'MSales Customer App - Fresh Water E-Commerce',
      description: 'E-commerce platform enabling customers to easily purchase fresh water products with '
          'quick and reliable delivery to their preferred location. Offers a convenient and seamless shopping experience.',
      media: [
        Media(
          media: UrlMedia.url('https://play.google.com/store/apps/details?id=store.zid.athbwater'),
          title: 'Google Play Store',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.cSharp,
        Skills.cleanArchitecture,
        Skills.technicalDocumentation,
        Skills.lifecycleManagement,
        Skills.crossPlatform,
        Skills.restApis,
        Skills.xamarin,
        Skills.xamarinForms,
      ],
      experiences: [
        Experiences.emeSpecialist,
      ],
    ),
    Project(
      title: 'Dryve - Car Rental Platform',
      description: 'The first peer-to-peer car sharing marketplace in Egypt providing the fastest, cheapest, '
          'and safest digital car rental service. Connects car owners with renters for affordable car sharing '
          'compared to traditional car rental companies.',
      media: [
        Media(
          media: UrlMedia.url('https://play.google.com/store/apps/details?id=com.eme.Dryve'),
          title: 'Google Play Store',
          type: MediaType.link,
        ),
      ],
      skills: [
        Skills.cSharp,
        Skills.technicalDocumentation,
        Skills.lifecycleManagement,
        Skills.crossPlatform,
        Skills.xamarin,
        Skills.xamarinForms,
      ],
      experiences: [
        Experiences.emeSpecialist,
      ],
    ),
  ];
}

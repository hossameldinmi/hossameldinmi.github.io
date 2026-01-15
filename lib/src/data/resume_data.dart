import 'package:cv_website/src/data/articles.dart';
import 'package:cv_website/src/data/certifications.dart';
import 'package:cv_website/src/data/education.dart';
import 'package:cv_website/src/data/experiences.dart';
import 'package:cv_website/src/data/projects.dart';
import 'package:cv_website/src/data/skills.dart';
import 'package:cv_website/src/models/contact.dart';
import 'package:cv_website/src/models/language.dart';
import 'package:cv_website/src/models/linked_in_profile.dart';
import 'package:cv_website/src/models/phone_number.dart';
import 'package:media_source/media_source.dart';

class ResumeData {
  static final profile = LinkedInProfile(
    firstName: 'Hossam Eldin',
    lastName: 'Mahmoud',
    title: 'Senior Mobile Software Engineer',
    subtitle: 'I build exceptional mobile and web applications that solve real-world problems.',
    focusList: [
      'Native-iOS',
      'Flutter',
      'Cross-Platform Mobile Developer',
      'Scalable Architecture Consultant',
      'Open-Source Contributor',
    ],
    calendlyUrl: 'https://calendly.com/hossameldinmi/snacks-coffee-break',
    about: '''
- As a Senior Cross-Platform Mobile Engineer, I specialize in designing and developing high-performance mobile applications using Flutter, Dart, and iOS. With 7+ years of hands-on experience, I focus on delivering scalable, reliable, and user-centric mobile solutions that align with business objectives and enhance digital experiences.

- I’m passionate about engineering excellence—implementing CI/CD pipelines, driving unit and widget testing adoption, and leading clean architecture refactoring to improve app quality and reduce release times by up to 70%. I leverage Domain Driven Design (DDD), Modular Architecture, and Reactive Architecture to build robust, scalable, and event-driven systems that meet business requirements while ensuring flexibility and maintainability. My approach combines technical precision with a strong sense of collaboration, ensuring every project achieves its maximum potential through teamwork, agile practices, and data-driven decision-making.

- Throughout my career, I’ve contributed to projects across various industries, from accessibility platforms to enterprise applications, consistently improving performance, maintainability, and delivery efficiency. I take pride in transforming complex requirements into seamless mobile experiences that make a tangible impact.

- Let’s connect — I’m always open to discussing innovative projects, technical collaborations, and opportunities to build impactful mobile solutions that drive real value.
''',
    profilePicture: ImageAssetMedia(
      assetPath: 'assets/photo.jpg',
      mimeType: 'image/jpeg',
      name: 'photo.jpg',
      size: 484.86.kb,
    ),
    location: 'Agouza, Giza, Egypt',
    resume:
        DocumentNetworkMedia.url('https://drive.google.com/file/d/13sCoWtPGaIY6yKfPP6sORHs8LadhmACd/view?usp=sharing'),
    contact: const Contact(
      email: 'hossameldinmi@gmail.com',
      linkedinUrl: 'https://linkedin.com/in/hossameldinmi',
      githubUrl: 'https://github.com/hossameldinmi',
      websiteUrl: 'https://hossameldinmi.github.io',
      phone: PhoneNumber(countryCode: '+20', number: '122 848 6542'),
    ),
    experience: Experiences.values,
    education: EducationSchools.values,
    skills: Skills.sections,
    projects: Projects.values,
    certifications: Certifications.values,
    languages: [
      const Language(name: 'Arabic', proficiency: 'Native'),
      const Language(name: 'English', proficiency: 'Professional Working Proficiency'),
      const Language(name: 'Turkish', proficiency: 'Elementary')
    ],
    blogs: Articles.values,
  );
}

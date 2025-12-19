import 'package:cv_website/src/models/article.dart';
import 'package:cv_website/src/models/contact.dart';
import 'package:cv_website/src/models/education.dart';
import 'package:cv_website/src/models/language.dart';
import 'package:cv_website/src/models/license_and_certification.dart';
import 'package:cv_website/src/models/company.dart';
import 'package:cv_website/src/models/project.dart';
import 'package:cv_website/src/models/skill_section.dart';
import 'package:media_source/media_source.dart';

class LinkedInProfile {
  final String firstName;
  final String lastName;
  String get name => '$firstName $lastName';
  final String title;
  final String subtitle;
  final List<String> focusList;
  final String? calendlyId;
  final String about;
  final MediaSource<ImageType> profilePicture;
  final String location;
  final List<Company> experience;
  final List<Education> education;
  final List<SkillSection> skills;
  final List<Project> projects;
  final List<LicenseAndCertification> certifications;
  final List<Language> languages;
  final Contact contact;
  final List<Article> blogs;
  final MediaSource<DocumentType>? resume;

  const LinkedInProfile({
    required this.firstName,
    required this.lastName,
    required this.title,
    required this.subtitle,
    required this.focusList,
    required this.about,
    required this.profilePicture,
    required this.location,
    required this.experience,
    required this.education,
    required this.skills,
    required this.projects,
    required this.certifications,
    required this.languages,
    required this.contact,
    required this.blogs,
    this.calendlyId,
    this.resume,
  });
}

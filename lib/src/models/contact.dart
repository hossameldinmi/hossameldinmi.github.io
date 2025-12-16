import 'package:cv_website/src/models/phone_number.dart';

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

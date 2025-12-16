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

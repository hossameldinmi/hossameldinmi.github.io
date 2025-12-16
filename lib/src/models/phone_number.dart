class PhoneNumber {
  final String countryCode;
  final String number;

  const PhoneNumber({required this.countryCode, required this.number});

  @override
  String toString() => '$countryCode $number';
}

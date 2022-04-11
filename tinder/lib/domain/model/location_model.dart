class LocationModel {
  String street;
  String city;
  String state;
  String country;
  String? timezone;
  LocationModel(
      {required this.street,
      required this.city,
      required this.state,
      required this.country,
      this.timezone});

  factory LocationModel.fromJson({required Map<String, dynamic> json}) {
    return LocationModel(
        street: json['street'] ?? '',
        city: json['city'] ?? '',
        state: json['state'] ?? '',
        country: json['country'] ?? '',
        timezone: json['timezone']);
  }
}

/*{
street: string(length: 5-100)
city: string(length: 2-30)
state: string(length: 2-30)
country: string(length: 2-30)
timezone: string(Valid timezone value ex. +7:00, -1:00)
}
*/
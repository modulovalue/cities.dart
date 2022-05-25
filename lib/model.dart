abstract class Cities {
  List<City> get all;
}

class CitiesImpl implements Cities {
  @override
  final List<City> all;

  const CitiesImpl({
    required final this.all,
  });
}

abstract class City {
  String get country;

  String get city;

  String get accent_city;

  String get region;

  double get latitude;

  double get longitude;

  String debug_string();
}

class CityImpl implements City {
  @override
  final String country;
  @override
  final String city;
  @override
  final String accent_city;
  @override
  final String region;
  @override
  final double latitude;
  @override
  final double longitude;

  const CityImpl({
    required final this.country,
    required final this.city,
    required final this.accent_city,
    required final this.region,
    required final this.latitude,
    required final this.longitude,
  });

  @override
  String toString() => debug_string();

  @override
  String debug_string() =>
      'CityImpl(country: "' +
      country +
      '", city: "' +
      city +
      '", accent_city: "' +
      accent_city +
      '", region: "' +
      region +
      '", latitude: ' +
      latitude.toString() +
      ', longitude: ' +
      longitude.toString() +
      ')';
}

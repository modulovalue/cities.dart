// region public
City parse_city_lazy({
  required final String str,
}) {
  return _CityLazyImpl(
    str: str,
  );
}

City parse_city_eager({
  required final String str,
}) {
  final components = str.split(
    ",",
  );
  assert(
    components.length == 6,
    "Each entry must have exactly 6 values.",
  );
  return _CityEagerImpl(
    country: components[0],
    // Some values contain leading spaces, remove them here.
    city: components[1].trimLeft(),
    // Some values contain leading spaces, remove them here.
    accent_city: components[2].trimLeft(),
    region: components[3],
    latitude: double.parse(
      components[4],
    ),
    longitude: double.parse(
      components[5],
    ),
  );
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
// endregion

// region internal
class _CityLazyImpl with _CityToStringMixin implements City {
  final String str;

  _CityLazyImpl({
    required final this.str,
  });

  late final components = () {
    final components = str.split(
      ",",
    );
    assert(
      components.length == 6,
      "Each entry must have exactly 6 values.",
    );
    return components;
  }();

  @override
  String get country {
    return components[0];
  }

  @override
  String get city {
    return components[1].trimLeft();
  }

  @override
  String get accent_city {
    return components[2].trimLeft();
  }

  @override
  String get region {
    return components[3];
  }

  @override
  double get latitude {
    return double.parse(
      components[4],
    );
  }

  @override
  double get longitude {
    return double.parse(
      components[5],
    );
  }
}

class _CityEagerImpl with _CityToStringMixin implements City {
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

  const _CityEagerImpl({
    required final this.country,
    required final this.city,
    required final this.accent_city,
    required final this.region,
    required final this.latitude,
    required final this.longitude,
  });
}

mixin _CityToStringMixin implements City {
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
// endregion

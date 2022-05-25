# cities.dart

A dataset containing over 2 million real cities that can be used by benchmarks or demos.
It has zero third party dependencies and is completely self-contained.

```yaml
  cities: 1.0.0
```

```dart
import 'package:cities/cities.dart';

Future<void> main() async {
  final cities = await cities_auto();
  final all_cities = cities.all;
  final first_ten_cities = all_cities.take(10);
  for (final city in first_ten_cities) {
    print(
      city.debug_string(),
    );
    // CityImpl(country: "ad", city: "aixas", accent_city: "Aixàs", region: "06", latitude: 42.4833333, longitude: 1.4666667)
    // CityImpl(country: "ad", city: "aixirivali", accent_city: "Aixirivali", region: "06", latitude: 42.4666667, longitude: 1.5)
    // CityImpl(country: "ad", city: "aixirivall", accent_city: "Aixirivall", region: "06", latitude: 42.4666667, longitude: 1.5)
    // CityImpl(country: "ad", city: "aixirvall", accent_city: "Aixirvall", region: "06", latitude: 42.4666667, longitude: 1.5)
    // CityImpl(country: "ad", city: "aixovall", accent_city: "Aixovall", region: "06", latitude: 42.4666667, longitude: 1.4833333)
    // CityImpl(country: "ad", city: "andorra", accent_city: "Andorra", region: "07", latitude: 42.5, longitude: 1.5166667)
    // CityImpl(country: "ad", city: "andorra la vella", accent_city: "Andorra la Vella", region: "07", latitude: 42.5, longitude: 1.5166667)
    // CityImpl(country: "ad", city: "andorra-vieille", accent_city: "Andorra-Vieille", region: "07", latitude: 42.5, longitude: 1.5166667)
    // CityImpl(country: "ad", city: "andorre", accent_city: "Andorre", region: "07", latitude: 42.5, longitude: 1.5166667)
    // CityImpl(country: "ad", city: "andorre-la-vieille", accent_city: "Andorre-la-Vieille", region: "07", latitude: 42.5, longitude: 1.5166667)
  }
}

```

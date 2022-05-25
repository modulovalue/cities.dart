import 'package:cities/cities.dart';

Future<void> main() async {
  final cities = await cities_auto();
  final all_cities = cities.all;
  final first_ten_cities = all_cities.take(10);
  for (final city in first_ten_cities) {
    print(
      city.debug_string(),
    );
  }
}

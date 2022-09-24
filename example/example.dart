import 'package:cities/cities.dart';

Future<void> main() async {
  final cities = await cities_auto_eager();
  final first_ten_cities = cities.take(10);
  for (final city in first_ten_cities) {
    print(
      city.debug_string(),
    );
  }
}

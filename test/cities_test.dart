import 'package:cities/cities_io.dart';
import 'package:test/test.dart';

Future<void> main() async {
  final sut = (await cities_auto()).all.toList();
  group("test", () {
    test("amount of cities", () {
      _texpect(
        sut.length,
      )(
        2673764,
      );
    });
    test("first datapoint", () {
      _texpect(
        sut.first.toString(),
      )(
        'CityImpl(country: "ad", city: "aixas", accent_city: '
        '"Aixàs", region: "06", latitude: 42.4833333, '
        'longitude: 1.4666667)',
      );
    });
    test("last datapoint", () {
      _texpect(
        sut.last.toString(),
      )(
        'CityImpl(country: "zw", city: "zvishavane", '
        'accent_city: "Zvishavane", region: "07", '
        'latitude: -20.3333333, longitude: 30.0333333)',
      );
    });
  });
}

void Function(
  T expected,
) _texpect<T>(
  final T actual,
) =>
    (
      final expected,
    ) =>
        expect(
          actual,
          expected,
        );

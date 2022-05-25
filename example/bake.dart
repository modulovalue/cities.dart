import 'package:cities/cities_io.dart';
import 'package:cities/model.dart';

// This could be used to bake some of the benchmark data to a dart file.
Future<void> main() async {
  final _cities = await cities_auto();
  final baked = _bake(_cities);
  print(baked);
}

String _bake(
  final Cities cities,
) =>
    """
abstract class CitiesTestData {
  List<String> cities1();
  List<String> cities10();
  List<String> cities100();
  List<String> cities1000();
  List<String> cities10000();
  List<String> cities100000();
  List<double> longitudes1();
  List<double> longitudes10();
  List<double> longitudes100();
  List<double> longitudes1000();
  List<double> longitudes10000();
  List<int> integerLongitudes1();
  List<int> integerLongitudes10();
  List<int> integerLongitudes100();
  List<int> integerLongitudes1000();
  List<int> integerLongitudes10000();
}

class CitiesTestDataImpl implements CitiesTestData {
  const CitiesTestDataImpl();
  @override
  List<String> cities1() => [${cities.all.take(1).map((final a) => "'${a.city.replaceAll("'", r"\'")}'").join(", ")}];
  @override
  List<String> cities10() => [${cities.all.take(10).map((final a) => "'${a.city.replaceAll("'", r"\'")}'").join(", ")}];
  @override
  List<String> cities100() => [${cities.all.take(100).map((final a) => "'${a.city.replaceAll("'", r"\'")}'").join(", ")}];
  @override
  List<String> cities1000() => [${cities.all.take(1000).map((final a) => "'${a.city.replaceAll("'", r"\'")}'").join(", ")}];
  @override
  List<String> cities10000() => [${cities.all.take(10000).map((final a) => "'${a.city.replaceAll("'", r"\'")}'").join(", ")}];
  @override
  List<double> longitudes1() => [${cities.all.take(1).map((final a) => a.longitude).join(", ")}];
  @override
  List<double> longitudes10() => [${cities.all.take(10).map((final a) => a.longitude).join(", ")}];
  @override
  List<double> longitudes100() => [${cities.all.take(100).map((final a) => a.longitude).join(", ")}];
  @override
  List<double> longitudes1000() => [${cities.all.take(1000).map((final a) => a.longitude).join(", ")}];
  @override
  List<double> longitudes10000() => [${cities.all.take(10000).map((final a) => a.longitude).join(", ")}];
  @override
  List<int> integerLongitudes1() => [${cities.all.take(1).map((final a) => a.longitude.toInt()).join(", ")}];
  @override
  List<int> integerLongitudes10() => [${cities.all.take(10).map((final a) => a.longitude.toInt()).join(", ")}];
  @override
  List<int> integerLongitudes100() => [${cities.all.take(100).map((final a) => a.longitude.toInt()).join(", ")}];
  @override
  List<int> integerLongitudes1000() => [${cities.all.take(1000).map((final a) => a.longitude.toInt()).join(", ")}];
  @override
  List<int> integerLongitudes10000() => [${cities.all.take(10000).map((final a) => a.longitude.toInt()).join(", ")}];
}
""";

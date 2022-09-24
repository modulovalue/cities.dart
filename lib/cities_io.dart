import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'model.dart';

// region public
/// Each city is parsed entirely during construction.
Future<Iterable<City>> cities_auto_eager() async {
  return (await _cities_auto_untyped()).map(
    (final e) => parse_city_lazy(
      str: e,
    ),
  );
}

/// The properties of each city are derived on access.
Future<Iterable<City>> cities_auto_lazy() async {
  return (await _cities_auto_untyped()).map(
    (final e) => parse_city_lazy(
      str: e,
    ),
  );
}
// endregion

// region internal
Future<Iterable<String>> _cities_auto_untyped() async {
  final location_of_cities_file_within_this_package = Uri.parse(
    _cities_path_within_package,
  );
  final resolved_location = await Isolate.resolvePackageUri(
    location_of_cities_file_within_this_package,
  );
  if (resolved_location == null) {
    throw Exception(
      _cities_package_name +
          ": Resolving the dataset location within the package by using Isolate.resolvePackageUri failed.",
    );
  } else {
    final file_path = resolved_location.toFilePath();
    final file = File(
      file_path,
    );
    final cities_file = _decode_cities_from_raw_file(
      file: file,
    );
    final cities_iterable = _cities_from(
      content: cities_file,
    );
    return cities_iterable;
  }
}

const String _cities_path_within_package = "package:" + _cities_package_name + "/" + _cities_file_name;

const String _cities_package_name = "cities";

const String _cities_file_name = "cities.txt.gz";

String _decode_cities_from_raw_file({
  required final File file,
}) {
  final content = file.readAsBytesSync();
  final gzip_decoded = gzip.decode(
    content,
  );
  final latin1_decoded = latin1.decode(
    gzip_decoded,
  );
  return latin1_decoded;
}

Iterable<String> _cities_from({
  required final String content,
}) {
  final lines = LineSplitter.split(
    content,
  );
  final lines_without_header = lines.skip(
    1,
  );
  final cities = lines_without_header.map(
    (final a) => a,
  );
  return cities;
}
// endregion

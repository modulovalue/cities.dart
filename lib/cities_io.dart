import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'model.dart';

/// Loads the cities file from the disk and parses it into a safe model.
Future<Cities> cities_auto() async {
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
    return _cities_from_raw_file(
      file: file,
    );
  }
}

const String _cities_path_within_package = "package:" + _cities_package_name + "/" + _cities_file_name;

const String _cities_package_name = "cities";

const String _cities_file_name = "cities.txt.gz";

Cities _cities_from_raw_file({
  required final File file,
}) {
  final content = file.readAsBytesSync();
  // TODO try delta encoding.
  // TODO try rle encoding.
  // TODO try huffman encoding.
  // TODO try https://pub.dev/packages/leb128.
  // TODO try lz style compression.
  // TODO try burrows wheeler transform.
  // TODO try all of them in rows vs columns storage.
  // TODO try see https://youtu.be/x7drE24geUw?t=3713.
  // TODO then compare against gzip.
  final gzip_decoded = gzip.decode(
    content,
  );
  final latin1_decoded = latin1.decode(
    gzip_decoded,
  );
  return _cities_from(
    content: latin1_decoded,
  );
}

Cities _cities_from({
  required final String content,
}) {
  final lines = LineSplitter.split(
    content,
  );
  final lines_without_header = lines.skip(
    1,
  );
  final cities = lines_without_header.map(
    (final a) => _city_from_string(
      str: a,
    ),
  );
  final cities_list = cities.toList();
  return CitiesImpl(
    all: cities_list,
  );
}

City _city_from_string({
  required final String str,
}) {
  final components = str.split(
    ",",
  );
  assert(
    components.length == 6,
    "Each entry must have exactly 6 values.",
  );
  return CityImpl(
    country: components[0],
    city: components[1],
    accent_city: components[2],
    region: components[3],
    latitude: double.parse(
      components[4],
    ),
    longitude: double.parse(
      components[5],
    ),
  );
}

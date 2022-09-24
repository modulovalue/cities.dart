import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'model.dart';

// region public
/// Loads the cities file from the disk and parses it into a safe model.
Future<Cities> cities_auto() async {
  final cities = await cities_auto_lazy();
  final cities_list = cities.toList();
  return CitiesImpl(
    all: cities_list,
  );
}

/// Returns a lazy iterable of all parsed cities.
///
/// Good for when you want to use your own index
/// and not pay for the overhead of lists.
Future<Iterable<City>> cities_auto_lazy() async {
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
    return cities_iterable.map(
      (final e) => parse_city_lazy(
        str: e,
      ),
    );
  }
}
// endregion

// region internal
const String _cities_path_within_package = "package:" + _cities_package_name + "/" + _cities_file_name;

const String _cities_package_name = "cities";

const String _cities_file_name = "cities.txt.gz";

String _decode_cities_from_raw_file({
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

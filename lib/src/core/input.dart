import 'dart:io';
import 'package:path/path.dart' as p;

class InputLoader {
  static String projectRoot() {
    return Directory.current.path;
  }

  static String loadInput(int day, int part) {
    final root = projectRoot();
    final dayStr = day.toString().padLeft(2, '0');
    final fileName = 'day$dayStr-$part.txt';
    final filePath = p.join(root, 'inputs', fileName);
    final file = File(filePath);
    if (!file.existsSync()) {
      throw Exception('Input file not found: $filePath');
    }
    return file.readAsStringSync().trimRight();
  }
}

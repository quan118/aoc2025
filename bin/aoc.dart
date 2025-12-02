import 'package:aoc2025/src/core/runner.dart';

void main(List<String> arguments) {
  if (arguments.length < 2) {
    print('Usage: dart run bin/aoc.dart <day> <part>');
    print('Example: dart run bin/aoc.dart 1 1');
    return;
  }

  final day = int.parse(arguments[0]);
  final part = int.parse(arguments[1]);
  final runner = PuzzleRunner();
  runner.run(day: day, part: part);
}

import 'package:aoc2025/src/core/puzzle.dart';

class Day01 extends Puzzle {
  @override
  String solvePart1(String input) {
    final lines = input.split('\n');
    int initial = 50;
    int result = 0;
    for (var line in lines) {
      final steps = int.parse(line.substring(1));
      if (line.startsWith('L')) {
        initial -= steps;
      } else {
        initial += steps;
      }
      initial %= 100;
      if (initial == 0) {
        result++;
      }
    }
    return result.toString();
  }

  @override
  String solvePart2(String input) {
    final lines = input.split('\n');
    int initial = 50;
    int result = 0;
    for (var line in lines) {
      final steps = int.parse(line.substring(1));
      final before = initial;
      if (line.startsWith('L')) {
        initial -= steps;
      } else {
        initial += steps;
      }
      result += (initial ~/ 100).abs();
      if (before > 0 && initial <= 0) {
        result += 1;
      }
      initial %= 100;
    }
    return result.toString();
  }
}

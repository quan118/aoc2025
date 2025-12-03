import 'puzzle.dart';
import 'input.dart';

import '../day01.dart' as day01;
import '../day02.dart' as day02;
import '../day03.dart' as day03;

typedef PuzzleFactory = Puzzle Function();

class PuzzleRunner {
  final List<PuzzleFactory> _registry = [
    () => day01.Day01(),
    () => day02.Day02(),
    () => day03.Day03(),
  ];

  void run({required int day, required int part}) {
    if (_registry.length < day) {
      throw Exception('Puzzle not registered for day $day');
    }

    final puzzle = _registry[day - 1]();
    final input = InputLoader.loadInput(day, part);
    final result = switch (part) {
      1 => puzzle.solvePart1(input),
      2 => puzzle.solvePart2(input),
      _ => throw Exception('Part must be 1 or 2, got $part'),
    };

    print('Day $day Part $part: $result');
  }
}

import 'puzzle.dart';
import 'input.dart';

import '../day01.dart' as day01;
import '../day02.dart' as day02;
import '../day03.dart' as day03;
import '../day04.dart' as day04;
import '../day05.dart' as day05;
import '../day06.dart' as day06;
import '../day07.dart' as day07;
import '../day08.dart' as day08;
import '../day09.dart' as day09;

typedef PuzzleFactory = Puzzle Function();

class PuzzleRunner {
  final List<PuzzleFactory> _registry = [
    () => day01.Day01(),
    () => day02.Day02(),
    () => day03.Day03(),
    () => day04.Day04(),
    () => day05.Day05(),
    () => day06.Day06(),
    () => day07.Day07(),
    () => day08.Day08(),
    () => day09.Day09(),
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

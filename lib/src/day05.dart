import 'package:aoc2025/src/core/puzzle.dart';

class Day05 extends Puzzle {
  @override
  String solvePart1(String input) {
    final lines = input.split('\n');
    final ranges = <(int, int)>[];
    final ingredients = <int>[];
    for (var line in lines) {
      if (line.contains('-')) {
        final parts = line.split('-');
        ranges.add((int.parse(parts[0]), int.parse(parts[1])));
      } else if (line.trim().isNotEmpty) {
        ingredients.add(int.parse(line));
      }
    }
    int freshCounter = 0;
    for (var ingredient in ingredients) {
      for (var range in ranges) {
        if (ingredient >= range.$1 && ingredient <= range.$2) {
          freshCounter++;
          break;
        }
      }
    }

    return freshCounter.toString();
  }

  @override
  String solvePart2(String input) {
    final lines = input.split('\n');
    final endpoints = <(int, bool)>[]; // true: start, false: end
    for (var line in lines) {
      if (line.contains('-')) {
        final parts = line.split('-');
        endpoints.add((int.parse(parts[0]), true));
        endpoints.add((int.parse(parts[1]), false));
      }
    }
    endpoints.sort((a, b) {
      final order = a.$1.compareTo(b.$1);

      if (order == 0) {
        return a.$2 ? -1 : 1;
      }
      return order;
    });

    int freshCounter = 0;
    final stack = <int>[];
    for (var endpoint in endpoints) {
      if (endpoint.$2) {
        stack.add(endpoint.$1);
      } else {
        final value = stack.removeLast();
        if (stack.isEmpty) {
          freshCounter += endpoint.$1 - value + 1;
        }
      }
    }

    return freshCounter.toString();
  }
}

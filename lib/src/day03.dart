import 'dart:math';
import 'package:aoc2025/src/core/puzzle.dart';

class Day03 extends Puzzle {
  @override
  String solvePart1(String input) {
    return process(input, 2);
  }

  @override
  String solvePart2(String input) {
    return process(input, 12);
  }

  String process(String input, int size) {
    final lines = input.split('\n');
    int result = 0;
    for (var line in lines) {
      final digits = line.split('').map(int.parse).toList();
      final maxDigits = List.filled(size, -1);
      int pos = -1;
      for (int i = 0; i < size; ++i) {
        for (int j = pos + 1; j < digits.length - (size - 1 - i); ++j) {
          if (digits[j] > maxDigits[i]) {
            maxDigits[i] = digits[j];
            pos = j;
          }
        }
      }
      for (int i = 0; i < size; ++i) {
        result += pow(10, size - i - 1).toInt() * maxDigits[i];
      }
    }
    return result.toString();
  }
}

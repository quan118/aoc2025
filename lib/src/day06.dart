import 'package:aoc2025/src/core/puzzle.dart';

class Day06 extends Puzzle {
  @override
  String solvePart1(String input) {
    final lines = input.split('\n');
    final numbers = <int>[];
    final operators = <String>[];
    for (int i = 0; i < lines.length - 1; i++) {
      final parts = lines[i].trim().split(RegExp(r'\s+'));
      final numbersInLine = parts.map(int.parse).toList();
      numbers.addAll(numbersInLine);
    }
    operators.addAll(lines.last.split(RegExp(r'\s+')).map((e) => e.trim()));
    int result = 0;

    for (int i = 0; i < operators.length; i++) {
      final operator = operators[i];
      var output = operator == '+' ? 0 : 1;
      for (int j = 0; j < lines.length - 1; j++) {
        final number = numbers[j * operators.length + i];
        if (operator == '+') {
          output += number;
        } else if (operator == '*') {
          output *= number;
        }
      }
      result += output;
    }
    return result.toString();
  }

  @override
  String solvePart2(String input) {
    final lines = input.split('\n');

    int col = 0;
    int row = 0;
    int left = 0;
    int right = 0;
    int result = 0;
    while (col < lines[0].length) {
      if (row >= lines.length - 1) {
        row = 0;
        col++;
        result += readNumbers(lines, left, right - 1);
        left = right = col;
      } else if (lines[row][col] == ' ') {
        row++;
      } else {
        col++;
        right = col;
      }
    }
    if (left != right) {
      result += readNumbers(lines, left, right - 1);
    }

    return result.toString();
  }

  int readNumbers(List<String> lines, int left, int right) {
    final allNumbers = <String>[];
    for (int i = right; i >= left; --i) {
      var number = '';
      for (int j = 0; j < lines.length - 1; ++j) {
        if (lines[j][i] != ' ') {
          number += lines[j][i];
        }
      }
      allNumbers.add(number);
    }

    String operator = '';
    for (int i = left; i <= right; ++i) {
      if (lines.last[i] != ' ') {
        operator = lines.last[i];
        break;
      }
    }

    return allNumbers
        .map(int.parse)
        .reduce((a, b) => operator == '+' ? a + b : a * b);
  }
}

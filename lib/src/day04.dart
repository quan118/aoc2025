import 'package:aoc2025/src/core/puzzle.dart';

class Day04 extends Puzzle {
  @override
  String solvePart1(String input) {
    final lines = input.split('\n');
    int result = 0;
    final chars = lines.map((line) => line.split('')).toList();
    for (var r = 0; r < chars.length; r++) {
      for (var c = 0; c < chars[r].length; c++) {
        if (chars[r][c] == '@') {
          int neighbors = countNeighbors(chars, r, c);
          if (neighbors < 4) {
            result++;
          }
        }
      }
    }
    return result.toString();
  }

  @override
  String solvePart2(String input) {
    final lines = input.split('\n');
    int result = 0;
    final chars = lines.map((line) => line.split('')).toList();
    bool updated = false;
    do {
      updated = false;
      for (var r = 0; r < chars.length; r++) {
        for (var c = 0; c < chars[r].length; c++) {
          if (chars[r][c] == '@') {
            int neighbors = countNeighbors(chars, r, c);
            if (neighbors < 4) {
              updated = true;
              result++;
              chars[r][c] = '.';
            }
          }
        }
      }
    } while (updated);

    return result.toString();
  }

  int countNeighbors(List<List<String>> chars, int r, int c) {
    int counter = 0;
    for (var dr = -1; dr <= 1; dr++) {
      for (var dc = -1; dc <= 1; dc++) {
        if (dr == 0 && dc == 0) continue;
        if (r + dr < 0 ||
            r + dr >= chars.length ||
            c + dc < 0 ||
            c + dc >= chars[r].length) {
          continue;
        }
        if (chars[r + dr][c + dc] == '@') {
          counter++;
        }
      }
    }
    return counter;
  }
}

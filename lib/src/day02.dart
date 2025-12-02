import 'package:aoc2025/src/core/puzzle.dart';

class Day02 extends Puzzle {
  @override
  String solvePart1(String input) {
    return process(input, (n1, n2) {
      final invalidSet = <int>{};
      for (int n = n1; n <= n2; n++) {
        final isValid = validate(n, 2);
        if (isValid) {
          invalidSet.add(n);
        }
      }
      return invalidSet;
    });
  }

  @override
  String solvePart2(String input) {
    return process(input, (n1, n2) {
      final invalidSet = <int>{};
      for (int n = n1; n <= n2; n++) {
        final s = n.toString();
        for (int m = 2; m <= s.length; m++) {
          final isValid = validate(n, m);
          if (isValid) {
            invalidSet.add(n);
          }
        }
      }
      return invalidSet;
    });
  }

  String process(String input, Set<int> Function(int, int) getInvalidSet) {
    final lines = input.split(',');
    final invalids = <int>[];
    for (var line in lines) {
      final parts = line.split('-');

      final n1 = int.parse(parts[0]);
      final n2 = int.parse(parts[1]);

      final invalidSet = getInvalidSet(n1, n2);
      invalids.addAll(invalidSet);
    }
    return invalids.reduce((a, b) => a + b).toString();
  }

  bool validate(int n, int m) {
    final s = n.toString();
    if (s.length % m != 0) return false;
    final end = s.length ~/ m;
    bool isValid = true;
    for (int i = 0; i < end; i++) {
      for (int j = 0; j < m - 1; ++j) {
        if (s[i + end * j] != s[i + end * (j + 1)]) {
          isValid = false;
          break;
        }
      }
      if (!isValid) break;
    }
    return isValid;
  }
}

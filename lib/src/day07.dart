import 'package:aoc2025/src/core/puzzle.dart';

class Day07 extends Puzzle {
  @override
  String solvePart1(String input) {
    final lines = input.split('\n');
    final visited = List<bool>.filled(lines.length * lines[0].length, false);
    int result = 0;
    for (int r = 0; r < lines.length; r++) {
      for (int c = 0; c < lines[r].length; c++) {
        if (lines[r][c] == 'S') {
          result = dfs(lines, r, c, visited);
          break;
        }
      }
      if (result > 0) {
        break;
      }
    }

    return result.toString();
  }

  @override
  String solvePart2(String input) {
    final lines = input.split('\n');
    final cached = List<int>.filled(lines.length * lines[0].length, -1);
    int result = 0;
    for (int r = 0; r < lines.length; r++) {
      for (int c = 0; c < lines[r].length; c++) {
        if (lines[r][c] == 'S') {
          result = dfs2(lines, r, c, cached);
          break;
        }
      }
      if (result > 0) {
        break;
      }
    }

    return result.toString();
  }

  int dfs(List<String> lines, int r, int c, List<bool> visited) {
    if (r < 0 || r >= lines.length || c < 0 || c >= lines[r].length) {
      return 0;
    }
    final idx = r * lines[0].length + c;
    if (visited[idx]) {
      return 0;
    }
    visited[idx] = true;
    if (lines[r][c] == '.' || lines[r][c] == 'S') {
      return dfs(lines, r + 1, c, visited);
    } else if (lines[r][c] == '^') {
      return 1 + dfs(lines, r, c - 1, visited) + dfs(lines, r, c + 1, visited);
    }
    return 0;
  }

  int dfs2(List<String> lines, int r, int c, List<int> cached) {
    if (r >= lines.length) {
      return 1;
    }
    if (r < 0 || c < 0 || c >= lines[r].length) {
      return 0;
    }
    final idx = r * lines[0].length + c;

    if (cached[idx] != -1) {
      return cached[idx];
    }

    if (lines[r][c] == '.' || lines[r][c] == 'S') {
      cached[idx] = dfs2(lines, r + 1, c, cached);
      return cached[idx];
    } else if (lines[r][c] == '^') {
      cached[idx] =
          dfs2(lines, r, c - 1, cached) + dfs2(lines, r, c + 1, cached);
      return cached[idx];
    }
    return 0;
  }
}

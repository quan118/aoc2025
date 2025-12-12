import 'dart:math';
import 'package:aoc2025/src/core/puzzle.dart';

class Day09 extends Puzzle {
  @override
  String solvePart1(String input) {
    final lines = input.split('\n');
    final coords = lines
        .map((line) => line.split(',').map(int.parse).toList())
        .toList();
    var largest = 0;
    for (int i = 0; i < coords.length - 1; ++i) {
      for (int j = i + 1; j < coords.length; ++j) {
        final area =
            (coords[i][0] - coords[j][0] + 1).abs() *
            (coords[i][1] - coords[j][1] + 1).abs();
        largest = max(largest, area);
        // print("i: $i, j: $j, area: $area");
      }
    }
    return largest.toString();
  }

  @override
  String solvePart2(String input) {
    final lines = input.split('\n');
    final coords = lines
        .map((line) => line.split(',').map(int.parse).toList())
        .toList();

    var largest = 0;
    for (int i = 0; i < coords.length - 1; ++i) {
      for (int j = i + 1; j < coords.length; ++j) {
        if (i != 0 || j != 4) continue;
        if (coords[i][0] == coords[j][0] || coords[i][1] == coords[j][1]) {
          continue;
        }
        final topLeft = (
          min(coords[i][0], coords[j][0]),
          min(coords[i][1], coords[j][1]),
        );
        final topRight = (
          max(coords[i][0], coords[j][0]),
          min(coords[i][1], coords[j][1]),
        );
        final bottomLeft = (
          min(coords[i][0], coords[j][0]),
          max(coords[i][1], coords[j][1]),
        );
        final bottomRight = (
          max(coords[i][0], coords[j][0]),
          max(coords[i][1], coords[j][1]),
        );
        print("i: $i, j: $j");
        print("topLeft: ${topLeft.$1},${topLeft.$2}");
        print("topRight: ${topRight.$1},${topRight.$2}");
        print("bottomLeft: ${bottomLeft.$1},${bottomLeft.$2}");
        print("bottomRight: ${bottomRight.$1},${bottomRight.$2}");
        final isTopHorizontalInside = checkHorizontalSegmentInside(
          coords,
          topLeft.$1,
          topRight.$1,
          topLeft.$2,
        );
        final isBottomHorizontalInside = checkHorizontalSegmentInside(
          coords,
          bottomLeft.$1,
          bottomRight.$1,
          bottomLeft.$2,
        );
        final isLeftVerticalInside = checkVerticalSegmentInside(
          coords,
          topLeft.$2,
          bottomLeft.$2,
          topLeft.$1,
        );
        final isRightVerticalInside = checkVerticalSegmentInside(
          coords,
          topRight.$2,
          bottomRight.$2,
          topRight.$1,
        );
        print("isTopHorizontalInside: $isTopHorizontalInside");
        print("isBottomHorizontalInside: $isBottomHorizontalInside");
        print("isLeftVerticalInside: $isLeftVerticalInside");
        print("isRightVerticalInside: $isRightVerticalInside");
        if (isTopHorizontalInside &&
            isBottomHorizontalInside &&
            isLeftVerticalInside &&
            isRightVerticalInside) {
          final area =
              (coords[i][0] - coords[j][0] + 1).abs() *
              (coords[i][1] - coords[j][1] + 1).abs();
          print("i: $i, j: $j");
          largest = max(largest, area);
        }
      }
    }
    return largest.toString();
  }

  bool checkHorizontalSegmentInside(
    List<List<int>> coords,
    int x1,
    int x2,
    int y,
  ) {
    print("checkHorizontalSegmentInside: $x1, $x2, $y");
    var tIntersections =
        <
          (int, int, int)
        >[]; // second parameter is intersection type, third parameter is intersection index
    var intersections = <int>[];
    for (int i = 0; i < coords.length; i++) {
      final j = i == coords.length - 1 ? 0 : i + 1;
      if (coords[i][1] == coords[j][1]) {
        // only check vertical lines
        continue;
      }
      final y1 = min(coords[i][1], coords[j][1]);
      final y2 = max(coords[i][1], coords[j][1]);
      if (y < y1 || y2 < y) {
        continue;
      }
      if (y1 < y && y < y2) {
        tIntersections.add((coords[i][0], 0, -1)); // don't need index
      } else if (y1 == y) {
        tIntersections.add((
          coords[i][0],
          -1,
          coords[i][0] < coords[j][0] ? i : j,
        ));
      } else if (y2 == y) {
        tIntersections.add((
          coords[j][0],
          1,
          coords[i][0] < coords[j][0] ? j : i,
        ));
      }
    }
    tIntersections.sort((a, b) => a.$1.compareTo(b.$1));
    print("temp intersections: $tIntersections");

    var isOutside = true;
    var states = <bool>[true]; // true for outside, false for inside
    for (int i = 0; i < tIntersections.length; i++) {
      if (isOutside) {
        isOutside = false;
        states.add(isOutside);
        intersections.add(tIntersections[i].$1);
      } else {
        if (tIntersections[i].$2 == 0) {
          isOutside = true;
          states.add(isOutside);
          intersections.add(tIntersections[i].$1);
        } else {
          if (!states[i - 1] &&
              tIntersections[i].$2 * tIntersections[i - 1].$2 < 0) {
            final minIdx = min(tIntersections[i].$3, tIntersections[i - 1].$3);
            final maxIdx = max(tIntersections[i].$3, tIntersections[i - 1].$3);
          }
        }
      }
    }

    for (int i = 0; i < tIntersections.length - 1; i += 2) {
      if (tIntersections[i] <= x1 && x2 <= tIntersections[i + 1]) {
        return true;
      }
    }
    return false;
  }

  bool checkVerticalSegmentInside(
    List<List<int>> coords,
    int y1,
    int y2,
    int x,
  ) {
    // print("checkVerticalSegmentInside: $y1, $y2, $x");
    var intersections = <int>[];
    for (int i = 0; i < coords.length; i++) {
      final j = i == coords.length - 1 ? 0 : i + 1;
      if (coords[i][0] == coords[j][0]) {
        // only check horizontal segments
        continue;
      }
      final x1 = min(coords[i][0], coords[j][0]);
      final x2 = max(coords[i][0], coords[j][0]);
      if (x1 <= x && x < x2) {
        intersections.add(coords[i][1]);
      }
    }
    intersections.sort();
    // print("intersections: $intersections");
    for (int i = 0; i < intersections.length - 1; i += 2) {
      if (intersections[i] <= y1 && y2 <= intersections[i + 1]) {
        return true;
      }
    }
    return false;
  }
}

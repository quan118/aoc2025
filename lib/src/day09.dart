import 'dart:math';
import 'package:aoc2025/src/core/puzzle.dart';

class Day09 extends Puzzle {
  @override
  String solvePart1(String input) {
    final lines = input.split('\n');
    final verts = lines
        .map((line) => line.split(',').map(int.parse).toList())
        .toList();
    var maxArea = 0;
    for (int i = 0; i < verts.length - 1; ++i) {
      for (int j = i + 1; j < verts.length; ++j) {
        final area =
            ((verts[i][0] - verts[j][0]).abs() + 1) *
            ((verts[i][1] - verts[j][1]).abs() + 1);
        maxArea = max(maxArea, area);
      }
    }
    return maxArea.toString();
  }

  @override
  String solvePart2(String input) {
    final lines = input.split('\n');
    final verts = lines
        .map((line) => line.split(',').map(int.parse).toList())
        .toList();

    var maxArea = 0;
    for (int i = 0; i < verts.length - 1; ++i) {
      for (int j = i + 1; j < verts.length; ++j) {
        if (verts[i][0] == verts[j][0] || verts[i][1] == verts[j][1]) {
          continue;
        }
        final topLeft = (
          min(verts[i][0], verts[j][0]),
          min(verts[i][1], verts[j][1]),
        );
        final topRight = (
          max(verts[i][0], verts[j][0]),
          min(verts[i][1], verts[j][1]),
        );
        final bottomLeft = (
          min(verts[i][0], verts[j][0]),
          max(verts[i][1], verts[j][1]),
        );
        final bottomRight = (
          max(verts[i][0], verts[j][0]),
          max(verts[i][1], verts[j][1]),
        );

        final isTopLeftInsideOrOnEdge = isPointInsideOrOnEdge(
          topLeft.$1,
          topLeft.$2,
          verts,
        );
        final isTopRightInsideOrOnEdge = isPointInsideOrOnEdge(
          topRight.$1,
          topRight.$2,
          verts,
        );
        final isBottomLeftInsideOrOnEdge = isPointInsideOrOnEdge(
          bottomLeft.$1,
          bottomLeft.$2,
          verts,
        );
        final isBottomRightInsideOrOnEdge = isPointInsideOrOnEdge(
          bottomRight.$1,
          bottomRight.$2,
          verts,
        );

        if (!isTopLeftInsideOrOnEdge ||
            !isTopRightInsideOrOnEdge ||
            !isBottomLeftInsideOrOnEdge ||
            !isBottomRightInsideOrOnEdge) {
          continue;
        }

        final topEdgeClear = isHorizontalSegmentClearOfPolygonEdges(
          verts,
          topLeft.$1,
          topRight.$1,
          topLeft.$2,
        );
        final bottomEdgeClear = isHorizontalSegmentClearOfPolygonEdges(
          verts,
          bottomLeft.$1,
          bottomRight.$1,
          bottomLeft.$2,
        );
        final leftEdgeClear = isVerticalSegmentClearOfPolygonEdges(
          verts,
          topLeft.$2,
          bottomLeft.$2,
          topLeft.$1,
        );
        final rightEdgeClear = isVerticalSegmentClearOfPolygonEdges(
          verts,
          topRight.$2,
          bottomRight.$2,
          topRight.$1,
        );

        if (topEdgeClear &&
            bottomEdgeClear &&
            leftEdgeClear &&
            rightEdgeClear) {
          final area =
              ((verts[i][0] - verts[j][0]).abs() + 1) *
              ((verts[i][1] - verts[j][1]).abs() + 1);
          maxArea = max(maxArea, area);
        }
      }
    }
    return maxArea.toString();
  }

  bool isHorizontalSegmentClearOfPolygonEdges(
    List<List<int>> verts,
    int x1,
    int x2,
    int y,
  ) {
    for (int i = 0; i < verts.length; i++) {
      final j = i == verts.length - 1 ? 0 : i + 1;
      if (verts[i][1] == verts[j][1]) {
        // only check vertical lines
        continue;
      }
      final y1 = min(verts[i][1], verts[j][1]);
      final y2 = max(verts[i][1], verts[j][1]);
      if (y1 < y && y < y2 && x1 < verts[i][0] && verts[i][0] < x2) {
        return false;
      }
    }

    return true;
  }

  bool isVerticalSegmentClearOfPolygonEdges(
    List<List<int>> verts,
    int y1,
    int y2,
    int x,
  ) {
    for (int i = 0; i < verts.length; i++) {
      final j = i == verts.length - 1 ? 0 : i + 1;
      if (verts[i][0] == verts[j][0]) {
        // only check horizontal edges
        continue;
      }
      final x1 = min(verts[i][0], verts[j][0]);
      final x2 = max(verts[i][0], verts[j][0]);
      if (x1 < x && x < x2 && y1 < verts[i][1] && verts[i][1] < y2) {
        return false;
      }
    }

    return true;
  }

  bool isPointInsideOrOnEdge(int x, int y, List<List<int>> verts) {
    var onEdge = false;
    for (int i = 0; i < verts.length; ++i) {
      final j = i == verts.length - 1 ? 0 : i + 1;
      if (verts[i][0] == verts[j][0]) {
        final y1 = min(verts[i][1], verts[j][1]);
        final y2 = max(verts[i][1], verts[j][1]);
        if (y1 <= y && y <= y2 && x == verts[i][0]) {
          onEdge = true;
          break;
        }
      } else {
        final x1 = min(verts[i][0], verts[j][0]);
        final x2 = max(verts[i][0], verts[j][0]);
        if (x1 <= x && x <= x2 && y == verts[i][1]) {
          onEdge = true;
          break;
        }
      }
    }
    if (onEdge) return true;

    // check if inside polygon
    var rayCrossings = 0;
    for (int i = 0; i < verts.length; i++) {
      final j = i == verts.length - 1 ? 0 : i + 1;
      if (verts[i][1] == verts[j][1]) {
        // only check vertical segments
        continue;
      }

      final y1 = min(verts[i][1], verts[j][1]);
      final y2 = max(verts[i][1], verts[j][1]);
      if (y1 <= y && y < y2 && x < verts[i][0]) {
        rayCrossings++;
      }
    }
    return rayCrossings % 2 == 1;
  }
}

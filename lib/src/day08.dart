import 'package:aoc2025/src/core/puzzle.dart';

class Day08 extends Puzzle {
  @override
  String solvePart1(String input) {
    final lines = input.split('\n');
    final boxes = lines
        .map((e) => e.split(',').map(int.parse).toList())
        .toList();
    final distances = <((int, int), int)>[];
    for (int i = 0; i < boxes.length; i++) {
      for (int j = i + 1; j < boxes.length; j++) {
        final dx = boxes[i][0] - boxes[j][0];
        final dy = boxes[i][1] - boxes[j][1];
        final dz = boxes[i][2] - boxes[j][2];
        final distance = dx * dx + dy * dy + dz * dz;
        distances.add(((i, j), distance));
      }
    }
    distances.sort((a, b) => a.$2.compareTo(b.$2));
    final boxToGroupId = <int, int>{};
    final groups = <Set<int>>[];
    for (int i = 0; i < boxes.length; i++) {
      groups.add({i});
      boxToGroupId[i] = i;
    }

    for (int i = 0; i < 1000; ++i) {
      final ((box1, box2), _) = distances[i];
      final gid1 = boxToGroupId[box1]!;
      final gid2 = boxToGroupId[box2]!;

      if (gid1 != gid2) {
        for (int box in groups[gid2]) {
          groups[gid1].add(box);
          boxToGroupId[box] = gid1;
        }
        groups[gid2].clear();
      }
    }

    final groupSizes = groups.map((e) => e.length).toList();
    groupSizes.sort((a, b) => b.compareTo(a));
    int result = 1;
    for (int i = 0; i < 3; i++) {
      result *= groupSizes[i];
    }
    return result.toString();
  }

  @override
  String solvePart2(String input) {
    final lines = input.split('\n');
    final boxes = lines
        .map((e) => e.split(',').map(int.parse).toList())
        .toList();
    final distances = <((int, int), int)>[];
    for (int i = 0; i < boxes.length; i++) {
      for (int j = i + 1; j < boxes.length; j++) {
        final dx = boxes[i][0] - boxes[j][0];
        final dy = boxes[i][1] - boxes[j][1];
        final dz = boxes[i][2] - boxes[j][2];
        final distance = dx * dx + dy * dy + dz * dz;
        distances.add(((i, j), distance));
      }
    }
    distances.sort((a, b) => a.$2.compareTo(b.$2));
    final boxToGroupId = <int, int>{};
    final groups = <Set<int>>[];
    for (int i = 0; i < boxes.length; i++) {
      groups.add({i});
      boxToGroupId[i] = i;
    }
    int groupCounter = groups.length;
    int result = 0;
    for (int i = 0; i < distances.length; ++i) {
      final ((box1, box2), _) = distances[i];
      final gid1 = boxToGroupId[box1]!;
      final gid2 = boxToGroupId[box2]!;

      if (gid1 != gid2) {
        for (int box in groups[gid2]) {
          groups[gid1].add(box);
          boxToGroupId[box] = gid1;
        }
        groups[gid2].clear();
        groupCounter--;
        if (groupCounter == 1) {
          print('box1: ${boxes[box1][0]},${boxes[box1][1]},${boxes[box1][2]}');
          print('box2: ${boxes[box2][0]},${boxes[box2][1]},${boxes[box2][2]}');
          result = boxes[box1][0] * boxes[box2][0];
          break;
        }
      }
    }

    return result.toString();
  }
}

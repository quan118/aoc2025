import 'package:aoc2025/src/core/puzzle.dart';
import 'package:collection/collection.dart';

class Day12 extends Puzzle {
  @override
  String solvePart1(String input) {
    final (shapes, regions) = _parseInput(input);
    final shapeArea = shapes
        .map((shape) => shape.fold(0, (acc, val) => acc + (val ? 1 : 0)))
        .toList();

    int result = 0;
    for (final region in regions) {
      final minimumArea = region.$3.foldIndexed(
        0,
        (i, acc, val) => acc + shapeArea[i] * val,
      );
      if (minimumArea < region.$1 * region.$2) {
        result += 1;
      }
    }
    return result.toString();
  }

  @override
  String solvePart2(String input) {
    // TODO: Implement solvePart2
    return '';
  }

  (List<List<bool>>, List<(int, int, List<int>)>) _parseInput(String input) {
    final lines = input.split('\n');
    int sectionIdx = 0;
    final shapes = <List<bool>>[];
    final regions = <(int, int, List<int>)>[];
    List<bool> shape = [];
    for (final line in lines) {
      if (line.isEmpty) {
        sectionIdx++;
        // print('shape: $shape');
        shapes.add(shape);
        shape = [];

        continue;
      }
      if (sectionIdx < 6) {
        if (line.endsWith(':')) continue;
        shape.addAll(line.split('').map((char) => char == '#').toList());
      } else if (sectionIdx == 6) {
        final tokens = line.split(':');
        // print('tokens: $tokens');
        final size = tokens[0].split('x').map(int.parse).toList();
        final requirements = tokens[1]
            .trim()
            .split(' ')
            .map(int.parse)
            .toList();
        // print('size: $size');
        // print('requirements: $requirements');
        regions.add((size[0], size[1], requirements));
      }
    }

    return (shapes, regions);
  }
}

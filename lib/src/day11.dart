import 'package:aoc2025/src/core/puzzle.dart';

class Day11 extends Puzzle {
  @override
  String solvePart1(String input) {
    final graph = _parseInput(input);
    final cost = <String, int>{};
    return _dfs('you', 'out', graph, cost).toString();
  }

  @override
  String solvePart2(String input) {
    final graph = _parseInput(input);
    final svr2fftCost = <String, int>{};
    final svr2fft = _dfs('svr', 'fft', graph, svr2fftCost);
    final fft2dacCost = <String, int>{};
    final fft2dac = _dfs('fft', 'dac', graph, fft2dacCost);
    final dac2OutCost = <String, int>{};
    final dac2Out = _dfs('dac', 'out', graph, dac2OutCost);
    // print('svr2fft: $svr2fft, fft2dac: $fft2dac, dac2Out: $dac2Out');
    return (svr2fft * fft2dac * dac2Out).toString();
  }

  Map<String, List<String>> _parseInput(String input) {
    final lines = input.split('\n');
    final graph = <String, List<String>>{};
    for (final line in lines) {
      final parts = line.split(':');
      final src = parts[0].trim();
      final dests = parts[1].split(' ').map((e) => e.trim()).toList();
      if (graph.containsKey(src)) {
        graph[src]!.addAll(dests);
      } else {
        graph[src] = dests;
      }
    }
    return graph;
  }

  int _dfs(
    String src,
    String dst,
    Map<String, List<String>> graph,
    Map<String, int> cost,
  ) {
    if (src == dst) return 1;
    if (cost.containsKey(src)) return cost[src]!;
    if (!graph.containsKey(src)) return 0;
    int totalCost = 0;
    for (final next in graph[src]!) {
      totalCost += _dfs(next, dst, graph, cost);
    }
    cost[src] = totalCost;
    return totalCost;
  }
}

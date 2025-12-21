import 'dart:math';
import 'package:aoc2025/src/core/puzzle.dart';

class Day10 extends Puzzle {
  static const int infinity = 1000000;

  @override
  String solvePart1(String input) {
    final lines = input.split('\n');
    int result = 0;
    for (final line in lines) {
      final (lights, buttons, joltages) = _parseInputLine(line);
      final patterns = _precalculatePatterns(buttons, lights.length);
      final parityKey = lights.join(',');
      final minCost = patterns[parityKey]!.values.reduce(
        (a, b) => a < b ? a : b,
      );

      result += minCost;
    }
    return result.toString();
  }

  @override
  String solvePart2(String input) {
    final lines = input.split('\n');
    int result = 0;
    for (final line in lines) {
      final (lights, buttons, joltages) = _parseInputLine(line);
      final patterns = _precalculatePatterns(buttons, lights.length);
      final cost = _dfs(joltages, buttons, {}, patterns);
      result += cost;
    }
    return result.toString();
  }

  (List<bool>, List<List<int>>, List<int>) _parseInputLine(String line) {
    final parts = line.split(']');
    final lights = parts[0]
        .substring(1)
        .split('')
        .map((e) => e == '#' ? true : false)
        .toList();
    final parts2 = parts[1].split('{');
    final buttons = parts2[0]
        .trim()
        .split(' ')
        .map(
          (e) => e
              .replaceAll('(', '')
              .replaceAll(')', '')
              .split(',')
              .map(int.parse)
              .toList(),
        )
        .toList();
    final joltages = parts2[1]
        .replaceAll('}', '')
        .split(',')
        .map(int.parse)
        .toList();

    return (lights, buttons, joltages);
  }

  List<bool> _toggle(List<bool> state, List<int> button) {
    final newState = List<bool>.from(state);
    for (final num in button) {
      newState[num] = !newState[num];
    }
    return newState;
  }

  List<int> _subtract(List<int> state, List<int> pattern) {
    final newState = List<int>.from(state);
    for (int i = 0; i < pattern.length; ++i) {
      newState[i] = (newState[i] - pattern[i]) ~/ 2;
    }
    return newState;
  }

  List<int> _add(List<int> state, List<int> button) {
    final newState = List<int>.from(state);
    for (int i = 0; i < button.length; ++i) {
      newState[button[i]] += 1;
    }
    return newState;
  }

  Map<String, Map<String, int>> _precalculatePatterns(
    List<List<int>> buttons,
    int size,
  ) {
    final result =
        <
          String,
          Map<String, int>
        >{}; // parity pattern -> joltage pattern -> cost
    final possibilitiesCount = 2 << (buttons.length - 1);
    for (int i = 0; i < possibilitiesCount; ++i) {
      List<bool> parityState = List.filled(size, false);
      List<int> joltageState = List.filled(size, 0);
      List<bool> pressedState = List<bool>.generate(
        buttons.length,
        (index) => (i >> index) & 1 == 1,
      );
      int cost = 0;

      for (int j = 0; j < pressedState.length; ++j) {
        if (!pressedState[j]) continue;
        parityState = _toggle(parityState, buttons[j]);
        joltageState = _add(joltageState, buttons[j]);
        cost++;
      }

      final parityStateKey = parityState.join(',');
      final countStateKey = joltageState.join(',');

      if (result.containsKey(parityStateKey)) {
        if (result[parityStateKey]!.containsKey(countStateKey)) {
          result[parityStateKey]![countStateKey] = min(
            result[parityStateKey]![countStateKey]!,
            cost,
          );
        } else {
          result[parityStateKey]![countStateKey] = cost;
        }
      } else {
        result[parityStateKey] = {countStateKey: cost};
      }
    }
    return result;
  }

  int _dfs(
    List<int> state,
    List<List<int>> buttons,
    Map<String, int> stateToCostMemo,
    Map<String, Map<String, int>> patterns,
  ) {
    String key = state.join(',');
    if (stateToCostMemo.containsKey(key)) return stateToCostMemo[key]!;

    if (state.every((value) => value == 0)) return 0;
    if (state.any((value) => value < 0)) {
      return infinity;
    }

    int minCost = infinity;

    final parityState = state.map((value) => value % 2 == 1).toList();
    final parityStateKey = parityState.join(',');
    if (!patterns.containsKey(parityStateKey)) return infinity;

    final joltagePatterns = patterns[parityStateKey]!.keys
        .map((e) => e.split(',').map(int.parse).toList())
        .toList();

    for (final p in joltagePatterns) {
      final joltagePatternKey = p.join(',');
      final newState = _subtract(state, p);
      final cost = _dfs(newState, buttons, stateToCostMemo, patterns);
      minCost = min(
        2 * cost + patterns[parityStateKey]![joltagePatternKey]!,
        minCost,
      );
      // }
    }

    stateToCostMemo[key] = minCost;
    return minCost;
  }
}

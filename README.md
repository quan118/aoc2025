# Advent of Code 2025

Solutions for [Advent of Code 2025](https://adventofcode.com/2025) written in Dart.

## Setup

1. Install Dart SDK (version 3.10.0 or higher)
2. Install dependencies:
```bash
dart pub get
```

## Running Solutions

To run a specific day and part:

```bash
dart run bin/aoc.dart <day> <part>
```

### Examples

Run Day 1, Part 1:
```bash
dart run bin/aoc.dart 1 1
```

Run Day 1, Part 2:
```bash
dart run bin/aoc.dart 1 2
```

## Project Structure

```
lib/
  src/
    core/          # Core framework (runner, input handling, puzzle base)
    day01.dart     # Day 1 solution
    day02.dart     # Day 2 solution
    ...
inputs/
  day01-1.txt      # Input for Day 1, Part 1
  day01-2.txt      # Input for Day 1, Part 2
  ...
```

## Adding New Solutions

1. Create a new file in `lib/src/` (e.g., `day02.dart`)
2. Extend the `Puzzle` class and implement `part1()` and `part2()` methods
3. Add the puzzle to the runner's registry
4. Place input files in the `inputs/` directory


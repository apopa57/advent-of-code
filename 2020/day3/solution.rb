#!/usr/bin/env ruby

lines = []
ARGF.each_line do |line|
  lines << line.strip.chars
end

def check_slope(lines, right, down)
  num_trees = 0
  i = j = 0
  while i < lines.length
    line = lines[i]
    if line[j] == '#'
      num_trees += 1
    end
    j = (j+right) % lines[0].length
    i += down
  end

  num_trees
end

def part1(lines)
  check_slope(lines, 3, 1)
end

def part2(lines)
  check_slope(lines, 1, 1) *
    check_slope(lines, 3, 1) *
    check_slope(lines, 5, 1) *
    check_slope(lines, 7, 1) *
    check_slope(lines, 1, 2)
end

puts part1(lines)
puts part2(lines)

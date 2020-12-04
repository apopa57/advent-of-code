#!/usr/bin/env ruby

def part1(input)
  input.map do |line|
    x, y, z = line.strip.split('x').map(&:to_i).sort
    3*x*y + 2*y*z + 2*z*x
  end.reduce(&:+)
end

{
  ['2x3x4'] => 58,
  ['1x1x10'] => 43
}.each do |input, expected_part1_output|
  if expected_part1_output != part1(input)
    fail "Expected #{expected_part1_output} for #{input} for part 1 but got #{part1(input)}"
  end
end

def part2(input)
  input.map do |line|
    x, y, z = line.strip.split('x').map(&:to_i).sort
    2*x + 2*y + x*y*z
  end.reduce(&:+)
end

{
  ['2x3x4'] => 34,
  ['1x1x10'] => 14
}.each do |input, expected_part2_output|
  if expected_part2_output != part2(input)
    fail "Expected #{expected_part2_output} for #{input} for part 2 but got #{part2(input)}"
  end
end

input = ARGF.lines.to_a

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

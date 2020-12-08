#!/usr/bin/env ruby

def part1(input)
  i = 0
  steps = 0
  loop do
    jump = input[i]
    input[i] += 1
    i = i + jump
    steps += 1

    if i < 0 || i >= input.length
      return steps
    end
  end
end

{
  [0, 3, 0, 1, -3] => 5
}.each do |input, expected_part1_output|
  if expected_part1_output != part1(input)
    fail "expected #{expected_part1_output} for #{input.inspect} but got #{part1(input)}"
  end
end

def part2(input)
  i = 0
  steps = 0
  loop do
    jump = input[i]
    if jump >= 3
      input[i] -= 1
    else
      input[i] += 1
    end
    i = i + jump
    steps += 1

    if i < 0 || i >= input.length
      return steps
    end
  end
end

{
  [0, 3, 0, 1, -3] => 10
}.each do |input, expected_part2_output|
  if expected_part2_output != part2(input)
    fail "expected #{expected_part2_output} for #{input.inspect} but got #{part2(input)}"
  end
end

input = ARGF.lines.to_a.map(&:strip).map(&:to_i)

puts "Part 1: #{part1(input.dup)}"
puts "Part 2: #{part2(input.dup)}"

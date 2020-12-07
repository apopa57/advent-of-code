#!/usr/bin/env ruby

def part1(input)
  n = input.length
  (0...n).map do |i|
    if input[i] == input[i-1]
      input[i].to_i
    else
      0
    end
  end.sum
end

{
  '1122' => 3,
  '1111' => 4,
  '1234' => 0,
  '91212129' => 9
}.each do |input, expected_part1_output|
  if expected_part1_output != part1(input)
    fail "Expected #{expected_part1_output} for #{input.inspect} but got #{part1(input)}"
  end
end

def part2(input)
  n = input.length
  (0...n).map do |i|
    if input[i] == input[(i + n/2) % n]
      input[i].to_i
    else
      0
    end
  end.sum
end

{
  '1212' => 6,
  '1221' => 0,
  '123425' => 4,
  '123123' => 12,
  '12131415' => 4
}.each do |input, expected_part2_output|
  if expected_part2_output != part2(input)
    fail "Expected #{expected_part2_output} for #{input.inspect} but got #{part2(input)}"
  end
end

input = ARGF.lines.first.strip

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

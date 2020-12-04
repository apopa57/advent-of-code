#!/usr/bin/env ruby

def part1(input)
  input.count('(') - input.count(')')
end

{
  "(())" => 0,
  "()()" => 0,
  "(((" => 3,
  "(()(()(" => 3,
  "))(((((" => 3,
  "())" => -1,
  "))(" => -1,
  ")))" => -3,
  ")())())" => -3
}.each do |input, expected_part1_output|
  if part1(input) != expected_part1_output
    raise "Expected #{expected_part1_output} for '#{input}' in part1 but got #{part1(input)}"
  end
end

def part2(input)
  floor = 0
  input.chars.each_with_index do |c, i|
    if c == ')'
      floor -= 1
    elsif c == '('
      floor += 1
    end

    if floor < 0
      return i+1
    end
  end
end

{
  ")" => 1,
  "()())" => 5
}.each do |input, expected_part2_output|
  if part2(input) != expected_part2_output
    raise "Expected #{expected_part2_output} for '#{input}' in part2 but got #{part2(input)}"
  end
end

input = ARGF.lines.first.strip

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

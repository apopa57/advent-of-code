#!/usr/bin/env ruby

def look_and_say(s)
  s.gsub(/(.)\1*/) { |s| s.size.to_s + s[0] }
end

{
  '1' => '11',
  '11' => '21',
  '21' => '1211',
  '1211' => '111221',
  '111221' => '312211'
}.each do |input, expected_output|
  if expected_output != look_and_say(input)
    fail "Expected #{expected_output} for #{input.inspect} but got #{look_and_say(input)}"
  end
end

def part1(input)
  s = input
  40.times do |i|
    s = look_and_say(s)
  end
  s.length
end

def part2(input)
  s = input
  50.times do |i|
    s = look_and_say(s)
  end
  s.length
end

input = '3113322113'

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

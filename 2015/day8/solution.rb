#!/usr/bin/env ruby

def part1(input)
  input.map do |s|
    s.length - s.gsub(/^"/, '').gsub(/"$/, '').gsub(/(\\"|\\\\|\\x..)/, '*').length
  end.sum
end

def part2(input)
  input.map do |s|
    2 + s.count('"') + s.count('\\')
  end.sum
end

input = ARGF.lines.to_a.map(&:strip)

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

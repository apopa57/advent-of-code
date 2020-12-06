#!/usr/bin/env ruby

def part1(input)
  count = Hash.new(0)
  sum = 0
  input.each do |line|
    if line.empty?
      sum += count.keys.length
      count = Hash.new(0)
    else
      line.chars.each { |char| count[char] += 1 }
    end
  end

  sum
end

def part2(input)
  count = Hash.new(0)
  sum = 0
  group_size = 0
  input.each do |line|
    if line.empty?
      sum += count.values.count(group_size)
      count = Hash.new(0)
      group_size = 0
    else
      line.chars.each { |char| count[char] += 1 }
      group_size += 1
    end
  end

  sum
end

input = ARGF.lines.to_a.map(&:strip)

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

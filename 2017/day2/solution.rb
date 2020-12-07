#!/usr/bin/env ruby

def part1(input)
  input.map do |row|
    row.max - row.min
  end.sum
end

def part2(input)
  input.map do |row|
    n = row.length
    result = -1
    (0...n).each do |i|
      (0...n).each do |j|
        if i != j && row[i] % row[j] == 0
          result = row[i] / row[j]
        end
      end
    end
    result
  end.sum
end

input = ARGF.lines.to_a.map { |line| line.split(/\s+/).map(&:to_i) }

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

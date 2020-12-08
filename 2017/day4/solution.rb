#!/usr/bin/env ruby

def part1(input)
  input.count do |passphrase|
    count = Hash.new(0)
    passphrase.split(/\s+/).each do |word|
      count[word] += 1
    end

    count.values.all? { |n| n == 1}
  end
end

def part2(input)
  input.count do |passphrase|
    count = Hash.new(0)
    passphrase.split(/\s+/).each do |word|
      count[word.chars.sort.join('')] += 1
    end

    count.values.all? { |n| n == 1}
  end
end

input = ARGF.lines.to_a.map(&:strip)

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

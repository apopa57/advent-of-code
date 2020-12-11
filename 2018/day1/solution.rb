#!/usr/bin/env ruby

def part1(input)
  input.sum
end

def part2(input)
  freq = 0
  seen = { 0 => true }
  loop do
    input.each do |freq_delta|
      freq += freq_delta

      if seen[freq]
        return freq
      else
        seen[freq] = true
      end
    end
  end
end

input = ARGF.lines.to_a.map(&:to_i)

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

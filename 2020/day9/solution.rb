#!/usr/bin/env ruby

def part1(input, preamble)
  i = preamble
  loop do
    n = input[i]
    found = false
    (-preamble..-2).each do |j|
      ((j+1)..-1).each do |k|
        if n == input[i+j] + input[i+k]
          found = true
        end
      end
    end

    if !found
      return n
    end

    i += 1
  end
end

def part2(input, preamble)
  invalid_number = part1(input, preamble)
  n = input.length

  (0...n).each do |i|
    ((i+1)...n).each do |j|
      seq = input[i..j]
      if seq.sum == invalid_number
        return seq.max + seq.min
      end
    end
  end
end

input = ARGF.lines.to_a.map(&:to_i)

puts "Part 1 test: #{part1([35, 20, 15, 25, 47, 40, 62, 55, 65, 95, 102, 117, 150, 182, 127, 219, 299, 277, 309, 576], 5)}"
puts "Part 1: #{part1(input, 25)}"
puts "Part 2 test: #{part2([35, 20, 15, 25, 47, 40, 62, 55, 65, 95, 102, 117, 150, 182, 127, 219, 299, 277, 309, 576], 5)}"
puts "Part 2: #{part2(input, 25)}"

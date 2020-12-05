#!/usr/bin/env ruby

def part1(input)
  n = input[0].length

  count = {
    '*' => [0] * n
  }
  ('a'..'z').each do |letter|
    count[letter] = [0] * n
  end

  max = ['*'] * n
  input.each do |line|
    line.chars.each_with_index do |char, i|
      count[char][i] = count[char][i] + 1

      if count[char][i] > count[max[i]][i]
        max[i] = char
      end
    end
  end

  max.join('')
end

def part2(input)
  n = input[0].length

  count = {}
  ('a'..'z').each do |letter|
    count[letter] = [0] * n
  end

  input.each do |line|
    line.chars.each_with_index do |char, i|
      count[char][i] = count[char][i] + 1
    end
  end

  (0...n).map do |column|
    min = 999999999999999
    min_freq_letter = '*'
    ('a'..'z').each do |letter|
      if count[letter][column] > 0 && count[letter][column] < min
        min = count[letter][column]
        min_freq_letter = letter
      end
    end

    min_freq_letter
  end.join('')
end

input = ARGF.lines.to_a.map(&:strip)

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

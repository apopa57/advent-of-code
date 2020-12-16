#!/usr/bin/env ruby

def part1(input)
  a = input.dup
  (2020-input.length).times do
    if a[0..-2].include?(a[-1])
      j = a.length - 2
      while j >= 0
        if a[j] == a[-1]
          a << (a.length-1-j)
          break
        end
        j -= 1
      end
    else
      a << 0
    end
  end

  p a

  a.last
end

def part2(input)
  last_index = {}
  next_to_last_index = {}

  input.each_with_index do |n, i|
    last_index[n] = i
  end

  last_num = input.last
  (input.length...30000000).each do |i|
    next_last_num = nil
    if next_to_last_index.key?(last_num)
      next_last_num = last_index[last_num] - next_to_last_index[last_num]
    else
      next_last_num = 0
    end

    if last_index.key?(next_last_num)
      next_to_last_index[next_last_num] = last_index[next_last_num]
      last_index[next_last_num] = i
    else
      last_index[next_last_num] = i
    end
    last_num = next_last_num
  end

  last_num
end

input = ARGF.lines.to_a[0].split(",").map(&:to_i)

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

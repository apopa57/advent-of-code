#!/usr/bin/env ruby

def part1(input, n = 150)
  count = []
  # count[i][j] => number of ways to fill i liters using the first j elements in input
  count << [1] * (input.length + 1)
  n.times { count << [0] * (input.length + 1) }

  input.each_with_index do |capacity, j|
    (1..n).each do |volume|
      count[volume][j+1] = count[volume][j]
      if volume >= capacity
        count[volume][j+1] += count[volume-capacity][j]
      end
      # puts "count[#{volume}][#{j+1}] = #{count[volume][j+1]}"
    end
  end

  count[n][input.length]
end

def part2(input, n = 150)
  (1..input.length).each do |k|
    count = 0
    input.combination(k).each do |comb|
      if comb.sum == n
        count += 1
      end
    end

    if count > 0
      return count
    end
  end
end

input = ARGF.lines.to_a.map { |line| line.strip.to_i }

p input
puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

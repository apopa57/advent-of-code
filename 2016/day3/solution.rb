#!/usr/bin/env ruby

def is_triangle(a, b, c)
  a + b > c &&
    a + c > b &&
    b + c > a
end

def part1(input)
  input.count do |a, b, c|
    is_triangle(a, b, c)
  end
end

def part2(input)
  i = 0
  num_triangles = 0
  while i < input.length
    num_triangles += 1 if is_triangle(input[i][0], input[i+1][0], input[i+2][0])
    num_triangles += 1 if is_triangle(input[i][1], input[i+1][1], input[i+2][1])
    num_triangles += 1 if is_triangle(input[i][2], input[i+1][2], input[i+2][2])
    i += 3
  end

  num_triangles
end

input = ARGF.lines.to_a.map { |line| line.strip.split(/\s+/).map(&:to_i) }

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

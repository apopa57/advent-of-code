#!/usr/bin/env ruby

def part1(input)
  dx = [1, 0, -1, 0]
  dy = [0, 1, 0, -1]
  i = 0
  x = y = 0
  m = 1
  loop do
    multiplier = if i%2 == 0
                   i/2 + 1
                 else
                   (i+1)/2
                 end

    if m >= input
      return x.abs + y.abs - (m - input)
    end

    m += multiplier
    x += multiplier*dx[i%4]
    y += multiplier*dy[i%4]

    i += 1
  end
end

{
  1 => 0,
  2 => 1,
  3 => 2,
  4 => 1,
  5 => 2,
  12 => 3,
  23 => 2,
  1024 => 31
}.each do |input, expected_part1_output|
  if expected_part1_output != part1(input)
    STDERR.puts "Expected #{expected_part1_output} for #{input} but got #{part1(input)}"
  end
end

def part2(input)
  dx = [1, 0, -1, 0]
  dy = [0, 1, 0, -1]
  grid = { 0 => { 0 => 1 }}
  row = column = 0
  i = 0
  loop do
    length = if i%2 == 0
               i/2 + 1
             else
               (i+1)/2
             end

    (1..length).each do
      row += dx[i%4]
      column += dy[i%4]

      grid[row] ||= {}
      grid[row][column] = [
        [0, 1],
        [1, 1],
        [1, 0],
        [1, -1],
        [0, -1],
        [-1, -1],
        [-1, 0],
        [-1, 1]
      ].map do |i, j|
        grid[row+i] ||= {}
        grid[row+i][column+j].to_i
      end.sum

      if grid[row][column] > input
        return grid[row][column]
      end
    end

    i += 1
  end
end

input = 361527

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"


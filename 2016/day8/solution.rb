#!/usr/bin/env ruby

def rect(screen, m, n)
  i = 0
  n.times do
    j = 0
    m.times do
      screen[i][j] = '#'
      j += 1
    end
    i += 1
  end
end

def rotate_row(screen, row, delta)
  screen[row] = screen[row].rotate(-delta)
end

def rotate_column(screen, col, delta)
  pixels = (0..5).map { |i| screen[i][col] }

  pixels.rotate(-delta).each_with_index do |pixel, i|
    screen[i][col] = pixel
  end
end

def part1(input)
  screen = [
    ['.'] * 50,
    ['.'] * 50,
    ['.'] * 50,
    ['.'] * 50,
    ['.'] * 50,
    ['.'] * 50
  ]
  input.each do |instr|
    instr.match(/rect (.*)x(.*)/) do |m|
      rect(screen, m[1].to_i, m[2].to_i)
    end

    instr.match(/rotate row y=(.*) by (.*)/) do |m|
      rotate_row(screen, m[1].to_i, m[2].to_i)
    end

    instr.match(/rotate column x=(.*) by (.*)/) do |m|
      rotate_column(screen, m[1].to_i, m[2].to_i)
    end
  end

  screen.map { |row| row.count('#') }.sum
end

def part2(input)
  # TODO
end

input = ARGF.lines.to_a

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

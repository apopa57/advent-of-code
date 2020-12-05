#!/usr/bin/env ruby

def part1(input)
  directions = %w(north east south west)
  dx = [0, 1, 0, -1]
  dy = [1, 0, -1, 0]

  facing = 0
  x = y = 0
  input.strip.split(', ').each do |instruction|
    turn = instruction[0]
    blocks = instruction[1..-1].to_i

    if turn == 'R'
      facing = (facing + 1) % 4
    elsif turn == 'L'
      facing = (facing + 3) % 4
    end

    x += dx[facing] * blocks
    y += dy[facing] * blocks
  end

  x.abs + y.abs
end

{
  'R2, L3' => 5,
  'R2, R2, R2' => 2,
  'R5, L5, R5, R3' => 12
}.each do |input, expected_part1_output|
  if expected_part1_output != part1(input)
    puts "Expected #{expected_part1_output} for '#{input}' but got #{part1(input)}"
  end
end

def part2(input)
  directions = %w(north east south west)
  dx = [0, 1, 0, -1]
  dy = [1, 0, -1, 0]

  facing = 0
  x = y = 0
  visited = {
    [0, 0] => true
  }
  input.strip.split(', ').each do |instruction|
    turn = instruction[0]
    blocks = instruction[1..-1].to_i

    if turn == 'R'
      facing = (facing + 1) % 4
    elsif turn == 'L'
      facing = (facing + 3) % 4
    end

    blocks.times do
      x += dx[facing]
      y += dy[facing]

      if visited[[x, y]]
        return x.abs + y.abs
      else
        visited[[x, y]] = true
      end
    end
  end
end

{
  'R8, R4, R4, R8' => 4
}.each do |input, expected_part2_output|
  if expected_part2_output != part2(input)
    puts "Expected #{expected_part2_output} for '#{input}' but got #{part2(input)}"
  end
end

input = ARGF.lines.first

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

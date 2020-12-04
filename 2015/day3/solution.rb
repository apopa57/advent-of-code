#!/usr/bin/env ruby

def part1(input)
  x = y = 0
  visited = {
    [x, y] => true
  }
  input.chars.each do |direction|
    if direction == '^'
      y += 1
    elsif direction == 'v'
      y -= 1
    elsif direction == '>'
      x += 1
    elsif direction == '<'
      x -= 1
    end

    visited[[x, y]] = true
  end

  visited.keys.length
end

{
  '>' => 2,
  '^>v<' => 4,
  '^v^v^v^v^v' => 2
}.each do |input, expected_part1_output|
  if expected_part1_output != part1(input)
    puts "Expected #{expected_part1_output} for '#{input}' in part 1 but got #{part1(input)}"
  end
end

def part2(input)
  santa_x = santa_y = robo_santa_x = robo_santa_y = 0
  visited = {
    [0, 0] => true
  }
  input.chars.each_with_index do |direction, i|
    if i%2 == 0
      if direction == '^'
        santa_y += 1
      elsif direction == 'v'
        santa_y -= 1
      elsif direction == '>'
        santa_x += 1
      elsif direction == '<'
        santa_x -= 1
      end

      visited[[santa_x, santa_y]] = true
    else
      if direction == '^'
        robo_santa_y += 1
      elsif direction == 'v'
        robo_santa_y -= 1
      elsif direction == '>'
        robo_santa_x += 1
      elsif direction == '<'
        robo_santa_x -= 1
      end

      visited[[robo_santa_x, robo_santa_y]] = true
    end
  end

  visited.keys.length
end

{
  '^v' => 3,
  '^>v<' => 3,
  '^v^v^v^v^v' => 11
}.each do |input, expected_part2_output|
  if expected_part2_output != part2(input)
    puts "Expected #{expected_part2_output} for '#{input}' in part 2 but got #{part2(input)}"
  end
end

input = ARGF.lines.first

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

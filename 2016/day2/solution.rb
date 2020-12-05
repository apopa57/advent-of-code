#!/usr/bin/env ruby

def part1(input)
  keypad = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9']
  ]

  i = j = 1
  code = ''
  input.each do |instruction|
    instruction.chars.each do |direction|
      if direction == 'U'
        i = [0, i-1].max
      elsif direction == 'D'
        i = [2, i+1].min
      elsif direction == 'R'
        j = [2, j+1].min
      elsif direction == 'L'
        j = [0, j-1].max
      end
    end

    code += keypad[i][j]
  end

  code
end

{
  ['ULL', 'RRDDD', 'LURDL', 'UUUUD'] => '1985'
}.each do |input, expected_part1_output|
  if expected_part1_output != part1(input)
    puts "Expected #{expected_part1_output} for #{input.inspect} but got #{part1(input)}"
  end
end

def part2(input)
  keypad = [
    [nil, nil, '1', nil, nil],
    [nil, '2', '3', '4', nil],
    ['5', '6', '7', '8', '9'],
    [nil, 'A', 'B', 'C', nil],
    [nil, nil, 'D', nil, nil]
  ]

  i = 2
  j = 0
  code = ''
  input.each do |instruction|
    instruction.chars.each do |direction|
      if direction == 'U'
        new_i = [0, i-1].max
        if keypad[new_i][j] != nil
          i = new_i
        end
      elsif direction == 'D'
        new_i = [4, i+1].min
        if keypad[new_i][j] != nil
          i = new_i
        end
      elsif direction == 'R'
        new_j = [4, j+1].min
        if keypad[i][new_j] != nil
          j = new_j
        end
      elsif direction == 'L'
        new_j = [0, j-1].max
        if keypad[i][new_j] != nil
          j = new_j
        end
      end
    end

    code += keypad[i][j]
  end

  code
end

{
  ['ULL', 'RRDDD', 'LURDL', 'UUUUD'] => '5DB3'
}.each do |input, expected_part2_output|
  if expected_part2_output != part2(input)
    puts "Expected #{expected_part2_output} for #{input.inspect} but got #{part2(input)}"
  end
end
input = ARGF.lines.to_a

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

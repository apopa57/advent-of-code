#!/usr/bin/env ruby

def part1(input)
  stack = []
  input.chars.each_with_index do |char, i|
    if stack.empty?
      stack << char
    elsif stack[-1] != char && (stack[-1] == char.downcase || stack[-1] == char.upcase)
      stack.pop
    else
      stack << char
    end

    # p stack.join('')
  end

  stack.join.length
end

def part2(input)
  min_length = input.length + 1
  ('a'..'z').each do |type|
    collapsed_length = part1(input.delete(type).delete(type.upcase))
    min_length = [min_length, collapsed_length].min
  end

  min_length
end

input = ARGF.lines.to_a[0].strip

p input.length

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

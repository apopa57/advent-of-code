#!/usr/bin/env ruby

require 'json'

def add_all_numbers(o, ignore_value = nil)
  case o
  when String
    0
  when Numeric
    o
  when Array
    o.map { |elt| add_all_numbers(elt, ignore_value) }.sum
  when Hash
    if o.values.include?(ignore_value)
      0
    else
      o.map { |k, v| add_all_numbers(v, ignore_value) }.sum
    end
  else
    fail o.inspect
  end
end

def part1(input)
  input.map do |line|
    add_all_numbers(JSON.parse(line))
  end.sum
end

def part2(input)
  input.map do |line|
    add_all_numbers(JSON.parse(line), "red")
  end.sum
end

input = ARGF.lines.to_a.map(&:strip)

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

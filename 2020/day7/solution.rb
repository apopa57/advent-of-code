#!/usr/bin/env ruby

require 'set'

def part1(input)
  q = input["shiny gold"]
  i = 0
  while i < q.length
    input[q[i]].to_a.each do |color|
      if !q.include?(color)
        q << color
      end
    end
    i += 1
  end

  q.length
end

def part2(must_contain, color)
  if must_contain[color].empty?
    return 1
  end

  1 + must_contain[color].map do |spec|
    count, inner_color = spec
    count * part2(must_contain, inner_color)
  end.reduce(&:+)
end

input = ARGF.lines.to_a

can_be_contained_in = {}
must_contain = {}
input.each do |line|
  line.match(/(.*) bags contain (.*)/) do |m|
    outer_color = m[1]
    must_contain[outer_color] = []
    if m[2] == 'no other bags'
      must_contain[outer_color] = []
    else
      m[2].split(', ').each do |bags|
        bags.match(/([0-9]+) (.*) bag/) do |m2|
          count = m2[1].to_i
          inner_color = m2[2]

          can_be_contained_in[inner_color] ||= []
          can_be_contained_in[inner_color] << outer_color

          must_contain[outer_color] << [count, inner_color]
        end
      end
    end
  end
end

puts "Part 1: #{part1(can_be_contained_in)}"
puts "Part 2: #{part2(must_contain, "shiny gold") - 1}"

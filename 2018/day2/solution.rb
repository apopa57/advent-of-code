#!/usr/bin/env ruby

def has_count(s, n)
  count = Hash.new(0)
  s.chars.each { |char| count[char] += 1 }

  count.values.include?(n)
end

def part1(input)
  input.count { |id| has_count(id, 2) } *
    input.count { |id| has_count(id, 3) }
end

def different_indexes(id1, id2)
  (0...[id1.length, id2.length].min).filter do |i|
    id1[i] != id2[i]
  end
end

def part2(input)
  input.each do |id1|
    input.each do |id2|
      indexes = different_indexes(id1, id2)
      if indexes.length == 1
        i = indexes[0]
        return id1[0...i] + id1[(i+1)..-1]
      end
    end
  end
end

input = ARGF.lines.to_a

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

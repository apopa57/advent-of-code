#!/usr/bin/env ruby

require 'digest'

def part1(input)
  n = 1
  loop do
    if Digest::MD5.hexdigest("#{input}#{n}").start_with?('00000')
      return n
    end

    n += 1
  end
end

{
  'abcdef' => 609043,
  'pqrstuv' => 1048970
}.each do |input, expected_part1_output|
  if expected_part1_output != part1(input)
    fail "Expected #{expected_part1_output} for #{input} in part 1, but got #{part1(input)}"
  end
end

def part2(input)
  n = 1
  loop do
    if Digest::MD5.hexdigest("#{input}#{n}").start_with?('000000')
      return n
    end

    n += 1
  end
end

input = 'ckczppom'

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

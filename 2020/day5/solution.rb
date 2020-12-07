#!/usr/bin/env ruby

def seat_id(seat)
  seat.gsub(/[FL]/, '0').gsub(/[BR]/, '1').to_i(2)
end

{
  'FBFBBFFRLR' => 357,
  'BFFFBBFRRR' => 567,
  'FFFBBBFRRR' => 119,
  'BBFFBBFRLL' => 820
}.each do |seat, expected_seat_id|
  if expected_seat_id != seat_id(seat)
    fail "Expected #{expected_seat_id} for '#{seat}' but got #{seat_id(seat)}"
  end
end

def part1(input)
  max = 0
  input.each do |line|
    max = [max, seat_id(line)].max
  end

  max
end

def part2(input)
  taken = [false] * 2048
  input.each do |line|
    taken[seat_id(line)] = true
  end

  (1...2047).each do |i|
    if taken[i-1] && !taken[i] && taken[i+1]
      return i
    end
  end
end

input = ARGF.lines.to_a

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

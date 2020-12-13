#!/usr/bin/env ruby

def part1(input)
  earliest_timestamp = input[0]
  buses = input[1].filter { |elt| elt != 'x' }

  best_bus = nil
  min_minutes_to_wait = 99999999999999999999
  buses.each do |bus|
    minutes_to_wait = bus - earliest_timestamp%bus

    if minutes_to_wait < min_minutes_to_wait
      min_minutes_to_wait = minutes_to_wait
      best_bus = bus
    end
  end

  best_bus * min_minutes_to_wait
end

def part2(input)
  buses = []

  input[1].each_with_index do |bus, i|
    if bus != 'x'
      buses << [bus, (bus - i) % bus]
    end
  end

  buses.sort_by! { |bus| bus[0] }

  earliest = buses[0][1]
  i = 1
  incr = buses[0][0]
  while i < buses.length
    while earliest % buses[i][0] != buses[i][1]
      earliest += incr
    end

    incr *= buses[i][0]
    i += 1
  end

  earliest
end

lines = ARGF.lines.to_a

input = [
  lines[0].to_i,
  lines[1].split(',').map do |elt|
    if elt == 'x'
      elt
    else
      elt.to_i
    end
  end
]

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

#!/usr/bin/env ruby

def part1(guard_sleep_pattern)
  id = guard_sleep_pattern.keys.max_by { |guard_id| guard_sleep_pattern[guard_id].sum }

  minute = 0
  max = guard_sleep_pattern[id][minute]
  guard_sleep_pattern[id].each_with_index do |count, i|
    if count > max
      max = count
      minute = i
    end
  end

  id * minute
end

def part2(guard_sleep_pattern)
  id = guard_sleep_pattern.keys[0]
  max_minute = 0
  guard_sleep_pattern.each do |guard_id, sleep_pattern|
    minute = 0
    sleep_pattern.each_with_index do |count, i|
      if count > guard_sleep_pattern[id][max_minute]
        id = guard_id
        max_minute = i
      end
    end
  end

  id * max_minute
end

current_guard = sleep_start = sleep_end = nil
guard_sleep_pattern = {}
ARGF.lines.to_a.sort.map do |line|
  line.match(/(.*)-(.*)-(.*) (.*):(.*). Guard #(.*) begins shift/) do |m|
    current_guard = m[6].to_i
    guard_sleep_pattern[current_guard] ||= [0] * 60
  end

  line.match(/(.*)-(.*)-(.*) (.*):(.*). falls asleep/) do |m|
    sleep_start = m[5].to_i
  end

  line.match(/(.*)-(.*)-(.*) (.*):(.*). wakes up/) do |m|
    sleep_end = m[5].to_i - 1
    (sleep_start..sleep_end).each { |minute| guard_sleep_pattern[current_guard][minute] += 1 }
  end
end

puts "Part 1: #{part1(guard_sleep_pattern)}"
puts "Part 2: #{part2(guard_sleep_pattern)}"

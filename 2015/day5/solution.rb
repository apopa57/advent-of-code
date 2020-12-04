#!/usr/bin/env ruby

def nice_part1?(s)
  !!(s.count("[aeiou]") >= 3 &&
     s =~ /([a-z])\1/ &&
     !s.include?('ab') &&
     !s.include?('cd') &&
     !s.include?('pq') &&
     !s.include?('xy')
    )
end

{
  'ugknbfddgicrmopn' => true,
  'aaa' => true,
  'jchzalrnumimnmhp' => false,
  'haegwjzuvuyypxyu' => false,
  'dvszwmarrgswjxmb' => false
}.each do |s, expected_nice|
  if expected_nice != nice_part1?(s)
    fail "Expected #{expected_nice} for '#{s}' but got #{nice_part1?(s)}"
  end
end

def nice_part2?(s)
  !!(
    s =~ /(.).\1/ &&
    s =~ /(..).*\1/
  )
end

{
  'qjhvhtzxzqqjkmpb' => true,
  'xxyxx' => true,
  'uurcxstgmygtbstg' => false,
  'ieodomkazucvgmuy' => false,
}.each do |s, expected_nice|
  if expected_nice != nice_part2?(s)
    fail "Expected #{expected_nice} for '#{s}' but got #{nice_part2?(s)}"
  end
end

input = ARGF.lines.to_a

def part1(input)
  input.count { |s| nice_part1?(s) }
end

def part2(input)
  input.count { |s| nice_part2?(s) }
end

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

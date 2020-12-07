#!/usr/bin/env ruby

def part1(g)
  nodes = g.keys.dup
  n = nodes.length
  min_total_dist = 999999999999999
  p = nil
  nodes.permutation.each do |perm|
    total_dist = (1...n).map { |i| g[perm[i-1]][perm[i]]}.sum
    if total_dist < min_total_dist
      min_total_dist = total_dist
      p = perm
    end
  end

  min_total_dist
end

{
  {
    "London" => { "Dublin" => 464, "Belfast" => 518 },
    "Dublin" => { "Belfast" => 141, "London" => 464 },
    "Belfast" => { "London" => 518, "Dublin" => 141 }
  } => 605
}.each do |g, expected_part1_output|
  if expected_part1_output != part1(g)
    fail "Expected #{expected_part1_output} for #{g} but got #{part1(g)}"
  end
end

def part2(g)
  nodes = g.keys.dup
  n = nodes.length
  max_total_dist = -1
  p = nil
  nodes.permutation.each do |perm|
    total_dist = (1...n).map { |i| g[perm[i-1]][perm[i]]}.sum
    if total_dist > max_total_dist
      max_total_dist = total_dist
      p = perm
    end
  end

  max_total_dist
end

g = {}
ARGF.each_line do |line|
  line.match(/(.*) to (.*) = (.*)/) do |m|
    src, dst, dist = m[1], m[2], m[3].to_i

    g[src] ||= {}
    g[dst] ||= {}
    g[src][dst] = g[dst][src] = dist
  end
end

puts "Part 1: #{part1(g)}"
puts "Part 2: #{part2(g)}"

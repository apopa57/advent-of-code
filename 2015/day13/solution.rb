#!/usr/bin/env ruby

def part1(units)
  units.keys.permutation.map do |p|
    change_in_happiness = (0...p.length).map do |i|
      units[p[i]][p[i-1]] + units[p[i-1]][p[i]]
    end.sum
  end.max
end

units = {}
ARGF.each_line do |line|
  line.match(/(.*) would (gain|lose) (.*) happiness units by sitting next to (.*)\./) do |m|
    name1, name2 = m[1], m[4]

    units[name1] ||= {}
    units[name1][name2] = if m[2] == 'gain'
                            m[3].to_i
                          else
                            -m[3].to_i
                          end
  end
end

puts "Part 1: #{part1(units)}"

units['*'] = {}
units.keys.each do |person|
  units['*'][person] = units[person]['*'] = 0
end

puts "Part 2: #{part1(units)}"

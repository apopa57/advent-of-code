#!/usr/bin/env ruby

require 'set'

def part1(input)

end

def part2(input)

end

input = ARGF.lines.to_a.map(&:strip)

h = {}
count = Hash.new(0)
input.each do |line|
  line.match(/(.*) .contains (.*)./) do |m|
    ingredients = Set.new(m[1].split(' '))
    allergens = m[2].split(', ')

    allergens.each do |allergen|
      if h.key?(allergen)
        h[allergen] = h[allergen] & ingredients
      else
        h[allergen] = ingredients
      end
    end

    ingredients.each do |ingredient|
      count[ingredient] += 1
    end
  end
end

allergen_for = {}
loop do
  a = nil
  h.each do |allergen, possible_ingredients|
    if possible_ingredients.length == 1
      a = allergen
    end
  end

  if a
    ingredient = h[a].first
    allergen_for[ingredient] = a
    h.delete(a)

    h.each do |allergen, possible_ingredients|
      h[allergen].delete(ingredient)
    end
  else
    break
  end
end

puts "Part 1: #{(count.keys - allergen_for.keys).map { |ingredient| count[ingredient] }.sum}"
puts "Part 2: #{allergen_for.keys.sort_by { |ingredient| allergen_for[ingredient] }.join(',')}"

#!/usr/bin/env ruby

def part1(input)
  compounds = {
    "children" => 3,
    "cats" => 7,
    "samoyeds" => 2,
    "pomeranians" => 3,
    "akitas" => 0,
    "vizslas" => 0,
    "goldfish" => 5,
    "trees" => 3,
    "cars" => 2,
    "perfumes" => 1
  }

  input.each do |aunt|
    found = true
    aunt[:compounds].each do |compound, value|
      if compounds[compound] != value
        found = false
      end
    end

    if found
      return aunt[:name].sub(/Sue /, '')
    end
  end

  nil
end

def part2(input)
  compounds = {
    "children" => 3,
    "cats" => 7,
    "samoyeds" => 2,
    "pomeranians" => 3,
    "akitas" => 0,
    "vizslas" => 0,
    "goldfish" => 5,
    "trees" => 3,
    "cars" => 2,
    "perfumes" => 1
  }

  input.each do |aunt|
    found = true
    aunt[:compounds].each do |compound, value|
      case compound
      when 'cats', 'trees'
        if value <= compounds[compound]
          found = false
        end
      when 'pomeranians', 'goldfish'
        if value >= compounds[compound]
          found = false
        end
      else
        if compounds[compound] != value
          found = false
        end
      end
    end

    if found
      return aunt[:name].sub(/Sue /, '')
    end
  end

  nil
end

input = ARGF.lines.to_a.map do |line|
  m = line.match(/(.*?): (.*)/)
  name, compounds = m[1..2]

  {
    name: name,
    compounds: compounds.split(', ').map do |pair|
      compound, value = pair.split(': ')
      [compound, value.to_i]
    end.to_h
  }
end

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

#!/usr/bin/env ruby

def part1(input)
  opposite = { 'on' => 'off', 'off' => 'on' }

  grid = []
  1000.times { grid << ['off'] * 1000 }

  input.each do |instruction|
    instruction.match(/turn (.*) (.*),(.*) through (.*),(.*)/) do |m|
      state, start_i, start_j, end_i, end_j = m[1..-1]

      start_i = start_i.to_i
      start_j = start_j.to_i
      end_i = end_i.to_i
      end_j = end_j.to_i

      (start_i..end_i).each do |i|
        (start_j..end_j).each do |j|
          grid[i][j] = state
        end
      end
    end

    instruction.match(/toggle (.*),(.*) through (.*),(.*)/) do |m|
      start_i, start_j, end_i, end_j = m[1..-1]

      start_i = start_i.to_i
      start_j = start_j.to_i
      end_i = end_i.to_i
      end_j = end_j.to_i

      (start_i..end_i).each do |i|
        (start_j..end_j).each do |j|
          grid[i][j] = opposite[grid[i][j]]
        end
      end
    end
  end

  grid.map { |row| row.count('on') }.reduce(&:+)
end

def part2(input)
  increment = { 'turn on' => 1, 'turn off' => -1, 'toggle' => 2 }
  grid = []
  1000.times { grid << [0] * 1000 }

  input.each do |instruction|
    instruction.match(/(.*) (.*),(.*) through (.*),(.*)/) do |m|
      state, start_i, start_j, end_i, end_j = m[1..-1]

      start_i = start_i.to_i
      start_j = start_j.to_i
      end_i = end_i.to_i
      end_j = end_j.to_i

      (start_i..end_i).each do |i|
        (start_j..end_j).each do |j|
          grid[i][j] = [grid[i][j] + increment[state], 0].max
        end
      end
    end
  end

  grid.map { |row| row.reduce(&:+) }.reduce(&:+)
end

input = ARGF.lines.to_a

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

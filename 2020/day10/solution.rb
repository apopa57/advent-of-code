#!/usr/bin/env ruby

def num_pairs_with_diff(a, diff)
  (1...a.length).count do |i|
    a[i] - a[i-1] == diff
  end
end
def part1(input)
  num_pairs_with_diff(input, 1) * num_pairs_with_diff(input, 3)
end

def part2(input)
  count = [0] * input.length

  count[-1] = 1
  j = input.length - 2
  while j >= 0
    ((j+1)...input.length).each do |k|
      if input[k] - input[j] <= 3
        count[j] += count[k]
      end
    end
    j -= 1
  end

  count[0]
end

input = ARGF.lines.to_a.map(&:to_i)

input = [0] + input.sort + [input.max + 3]

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

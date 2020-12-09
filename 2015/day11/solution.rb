#!/usr/bin/env ruby

def part1(input)
  arr = input.chars.map { |char| char.ord - 'a'.ord }
  bad_letters = 'iol'.chars

  loop do
    i = arr.length - 1
    while arr[i] == 25
      arr[i] = 0
      i -= 1
    end

    arr[i] += 1

    next if bad_letters.any? { |bad_letter| arr.include?(bad_letter.ord - 'a'.ord) }

    pair = {}
    (1...(arr.length)).each do |i|
      if arr[i] == arr[i-1]
        pair[arr[i]] = true
      end
    end

    next if pair.length < 2

    (2...(arr.length)).each do |i|
      if [arr[i] - arr[i-1], arr[i-1] - arr[i-2]] == [1, 1]
        return arr.map { |num| (num + 'a'.ord).chr }.join('')
      end
    end
  end
end

input = 'hepxcrrq'

next_password = part1(input)
puts "Part 1: #{next_password}"
puts "Part 2: #{part1(next_password)}"

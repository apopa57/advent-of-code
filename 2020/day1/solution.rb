#!/usr/bin/env ruby

h = {}

ARGF.each_line do |line|
  n = line.strip.to_i
  h[n] = true
end

part_1_done = part_2_done = false
h.keys.each do |i|
  h.keys.each do |j|
    if !part_1_done && i + j == 2020
      puts "answer for part 1: #{i*j}"
      part_1_done = true
    end

    h.keys.each do |k|
      if !part_2_done && i + j + k == 2020
        puts "answer for part 2:#{i*j*k}"
        part_2_done = true
      end
    end
  end
end

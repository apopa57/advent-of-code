#!/usr/bin/env ruby

num_correct_passwords = 0
num_correct_passwords_phase2 = 0
ARGF.each_line do |line|
  line.match(/([0-9]+)-([0-9]+) ([a-z]): (.*)\n/) do |m|
    min, max, letter, password = m[1..-1]

    min = min.to_i
    max = max.to_i

    if "#{min}-#{max} #{letter}: #{password}" != line.strip
      puts line
      puts "#{min}-#{max} #{letter}: #{password}"
      STDERR.puts "ERROR"
      exit
    end

    count = password.chars.count(letter)

    if min <= count && count <= max
      num_correct_passwords += 1
    end

    if [password[min-1], password[max-1]].count(letter) == 1
      puts line
      num_correct_passwords_phase2 += 1
    end
  end
end

puts num_correct_passwords
puts num_correct_passwords_phase2

#!/usr/bin/env ruby

require 'digest'

input = 'cxdnnyjw'

def part1(input)
  n = 1
  password = ''
  loop do
    hash = Digest::MD5.hexdigest("#{input}#{n}")
    if hash.start_with?('00000')
      password += hash[5]
      if password.length == 8
        return password
      end
    end

    n += 1
  end
end

def part2(input)
  n = 1
  password = '        '
  loop do
    hash = Digest::MD5.hexdigest("#{input}#{n}")
    if hash.start_with?('00000') && ('0'..'7').include?(hash[5])
      puts "#{hash} looks promising"
      i = hash[5].to_i
      if password[i] == ' '
        password[i] = hash[6]
        puts "Password is: #{password}"
      else
        puts "Bummer"
      end
    end

    n += 1
  end
end

# puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

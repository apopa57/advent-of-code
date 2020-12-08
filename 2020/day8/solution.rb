#!/usr/bin/env ruby

def part1(input)
  ip = 0
  acc = 0
  executed = [false] * input.length
  loop do
    if executed[ip] || ip == input.length
      return acc
    end

    cmd, num = input[ip]
    if cmd == 'acc'
      acc += num
      executed[ip] = true
      ip += 1
    elsif cmd == 'jmp'
      executed[ip] = true
      ip += num
    elsif cmd == 'nop'
      executed[ip] = true
      ip += 1
    end
  end
end

def has_loop(input)
  ip = 0
  acc = 0
  executed = [false] * input.length
  loop do
    if executed[ip]
      return true
    end

    if ip == input.length
      return false
    end

    cmd, num = input[ip]
    if cmd == 'acc'
      acc += num
      executed[ip] = true
      ip += 1
    elsif cmd == 'jmp'
      executed[ip] = true
      ip += num
    elsif cmd == 'nop'
      executed[ip] = true
      ip += 1
    end
  end
end

def part2(input)
  (0...(input.length)).each do |i|
    if input[i][0] == 'nop'
      input[i][0] = 'jmp'
      if !has_loop(input)
        return part1(input)
      end
      input[i][0] = 'nop'
    elsif input[i][0] == 'jmp'
      input[i][0] = 'nop'
      if !has_loop(input)
        return part1(input)
      end
      input[i][0] = 'jmp'
    end
  end
end

input = ARGF.lines.to_a.map do |line|
  cmd, num = line.split
  [cmd, num.to_i]
end

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

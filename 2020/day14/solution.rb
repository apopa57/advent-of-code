#!/usr/bin/env ruby

def part1(input)
  mem = Hash.new(0)
  mask = nil
  input.each do |instr|
    instr.match(/mask = (.*)/) { |m| mask = m[1].rjust(36, '0') }

    instr.match(/mem\[(.*)\] = (.*)/) do |m|
      address = m[1].to_i
      value = m[2].to_i.to_s(2).rjust(36, '0')

      value.chars.each_with_index do |bit, i|
        if mask[i] != 'X'
          value[i] = mask[i]
        end
      end

      mem[address] = value.to_i(2)
    end
  end

  mem.values.sum
end

def all_addresses(address_pattern)
  if !address_pattern.include?('x')
    return [address_pattern]
  end

  all_addresses(address_pattern.sub('x', '0')) +
    all_addresses(address_pattern.sub('x', '1'))
end

def part2(input)
  mem = Hash.new(0)
  mask = nil
  input.each do |instr|
    instr.match(/mask = (.*)/) { |m| mask = m[1].rjust(36, '0') }

    instr.match(/mem\[(.*)\] = (.*)/) do |m|
      address = m[1].to_i.to_s(2).rjust(36, '0')
      value = m[2].to_i

      address_pattern = []
      (0..36).each do |i|
        if mask[i] == '0'
          address_pattern << address[i]
        elsif mask[i] == '1'
          address_pattern << '1'
        elsif mask[i] == 'X'
          address_pattern << 'x'
        end
      end

      address_pattern = address_pattern.join

      all_addresses(address_pattern).each do |addr|
        mem[addr.to_i(2)] = value
      end
    end
  end

  mem.values.sum
end

input = ARGF.lines.to_a

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

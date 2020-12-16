#!/usr/bin/env ruby

require 'set'

def part1(input)
  field_ranges = {}
  processing = false
  ticket_scanning_error_rate = 0
  input.each do |line|
    line.match(/(.*): (.*)-(.*) or (.*)-(.*)/) do |m|
      field_ranges[m[1]] = [
        (m[2].to_i..m[3].to_i),
        (m[4].to_i..m[5].to_i)
      ]
    end

    if line =~ /nearby tickets/
      processing = true
    end

    if processing
      values = line.split(',').map(&:to_i)
      values.each do |val|
        if(field_ranges.keys.all? do |field|
          !field_ranges[field][0].include?(val) &&
            !field_ranges[field][1].include?(val)
        end)
          ticket_scanning_error_rate += val
        end
      end
    end
  end

  ticket_scanning_error_rate
end

def part2(input)
  field_ranges = {}
  processing = false
  valid_tickets = []
  final_field = {}
  my_ticket = []
  input.each_with_index do |line, i|
    line.match(/(.*): (.*)-(.*) or (.*)-(.*)/) do |m|
      field_ranges[m[1]] = [
        (m[2].to_i..m[3].to_i),
        (m[4].to_i..m[5].to_i)
      ]
    end

    if line =~ /your ticket/
      my_ticket = input[i+1].split(',').map(&:to_i)
    end

    if line =~ /nearby tickets/
      processing = true

      field_ranges.length.times do |i|
        final_field[i] = Set.new(field_ranges.keys)
      end
    end

    if processing
      ticket = line.split(',').map(&:to_i)

      ticket.each_with_index do |field_val, i|
        possible_fields = Set.new

        field_ranges.each do |field, ranges|
          if ranges[0].include?(field_val) || ranges[1].include?(field_val)
            possible_fields << field
          end
        end

        if possible_fields.any?
          final_field[i] = final_field[i] & possible_fields
        end
      end
    end
  end

  mapping = {}
  loop do
    next_index = -1
    final_field.each do |i, fields|
      if fields.length == 1
        mapping[i] = fields.to_a[0]
        next_index = i
      end
    end

    if next_index == -1
      break
    end

    final_field.each do |i, fields|
      fields.delete(mapping[next_index])
    end
  end

  prod = 1
  my_ticket.each_with_index do |val, i|
    if mapping[i].start_with?('departure')
      prod = prod*val
    end
  end

  prod
end

input = ARGF.lines.to_a

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

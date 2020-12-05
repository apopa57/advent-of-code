#!/usr/bin/env ruby

def checksum(encrypted_name)
  count = Hash.new(0)
  encrypted_name.gsub(/-/, '').chars.each do |char|
    count[char] += 1
  end

  top5_counts = count.values.dup.sort.reverse.take(5)

  count.keys.dup.filter do |char|
    top5_counts.include?(count[char])
  end.sort do |a, b|
    if count[a] != count[b]
      count[b] <=> count[a]
    else
      a <=> b
    end
  end.take(5).join('')
end

{
  'aaaaa-bbb-z-y-x' => 'abxyz',
  'a-b-c-d-e-f-g-h' => 'abcde'
}.each do |encrypted_room_name, expected_checksum|
  if expected_checksum != checksum(encrypted_room_name)
    fail "Expected #{expected_checksum} for #{encrypted_room_name.inspect} but got #{checksum(encrypted_room_name)}"
  end
end

def part1(input)
  input.map do |line|
    m = line.match(/(.*)-(\d+)\[(.*)\]/)
    encrypted_name, sector_id, chk = m[1..-1]

    if chk == checksum(encrypted_name)
      sector_id.to_i
    else
      0
    end
  end.reduce(&:+)
end

def decrypt(encrypted_room_name, sector_id)
  encrypted_room_name.chars.map do |char|
    if char == '-'
      ' '
    elsif char.ord + (sector_id % 26) <= 'z'.ord
      (char.ord + (sector_id % 26)).chr
    else
      (char.ord - (26 - (sector_id % 26))).chr
    end
  end.join('')
end

def part2(input)
  input.map do |line|
    m = line.match(/(.*)-(\d+)\[(.*)\]/)
    encrypted_name, sector_id, chk = m[1..-1]

    if chk == checksum(encrypted_name)
      if decrypt(encrypted_name, sector_id.to_i) =~ /north.*pole/i
        return sector_id
      end
    end
  end
end

input = ARGF.lines.to_a

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

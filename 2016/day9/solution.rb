#!/usr/bin/env ruby

def part1(input)
  decompressed_length = 0
  s = ''
  len = count = nil
  i = 0
  while i < input.length
    incr = 1

    case input[i]
    when '('
      s = ''
    when 'x'
      len = s.to_i
      s = ''
    when ')'
      count = s.to_i
      incr += len
      decompressed_length += count*len
    when /\d/
      s += input[i]
    else
      decompressed_length += 1
    end

    i += incr
  end

  decompressed_length
end

def part2(input)
  decompressed_length = 0
  i = 0
  len = count = nil
  unaccounted_count = 0
  s = ''
  while i < input.length
    incr = 1

    case input[i]
    when '('
      s = ''
    when 'x'
      len = s.to_i
      s = ''
    when ')'
      count = s.to_i
      decompressed_length += part2(input[(i+1)..(i+len)]) * count
      incr += len
    when /\d/
      s += input[i]
    else
      decompressed_length += 1
    end

    i += incr
  end

  decompressed_length
end

{
  '(3x3)XYZ' => 9,
  'X(8x2)(3x3)ABCY' => 20,
  '(27x12)(20x12)(13x14)(7x10)(1x12)A' => 241920,
  '(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN' => 445
}.each do |input, expected_part2_output|
  if expected_part2_output != part2(input)
    fail "Expected #{expected_part2_output} for #{input.inspect} but got #{part2(input)}"
  end
end

input = ARGF.lines.to_a[0].strip

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

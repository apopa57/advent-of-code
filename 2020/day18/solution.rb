#!/usr/bin/env ruby

def part1(input)
  input.map do |expr|
    stack = []

    expr.chars.each do |char|
      if char != ' '
        stack << char
      end

      loop do
        changed = false

        if stack[-1] =~ /\d/
          op = stack[-2]
          case op
          when '*'
            rhs = stack.pop
            stack.pop
            lhs = stack.pop
            stack << "#{lhs.to_i * rhs.to_i}"
            changed = true
          when '+'
            rhs = stack.pop
            stack.pop
            lhs = stack.pop
            stack << "#{lhs.to_i + rhs.to_i}"
            changed = true
          end
        elsif stack[-1] == ')' && stack[-3] == '('
          stack.pop
          val = stack.pop
          stack.pop

          stack << val
          changed = true
        end

        break if !changed
      end
    end
    stack[0].to_i
  end.sum
end

def perform_additions(stack)
  while stack[-1].integer? && stack[-2] == '+'
    rhs = stack.pop
    stack.pop # +
    lhs = stack.pop
    stack << lhs + rhs
  end
end

def perform_multiplications(stack)
  while stack[-1].integer? && stack[-2] == '*'
    rhs = stack.pop
    stack.pop # +
    lhs = stack.pop
    stack << lhs * rhs
  end
end

def part2(input)
  input.map do |expr|
    stack = []

    expr.chars.each_with_index do |char, i|
      if char =~ /\d/
        stack << char.to_i
        perform_additions(stack)
      elsif char == '(' || char == '+' || char == '*'
        stack << char
      elsif char == ')'
        perform_additions(stack)
        perform_multiplications(stack)
        val = stack.pop
        stack.pop # (
        stack << val
        perform_additions(stack)
      end
    end

    perform_additions(stack)
    perform_multiplications(stack)

    if stack.length > 1
      fail
    end

    stack[0].to_i
  end.sum
end

input = ARGF.lines.to_a.map(&:strip)

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

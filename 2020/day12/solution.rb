#!/usr/bin/env ruby

def part1(input)
  north, east, south, west = [0, 1, 2, 3]
  incr = {
    north => [0, 1],
    'N' => [0, 1],
    east => [1, 0],
    'E' => [1, 0],
    south => [0, -1],
    'S' => [0, -1],
    west => [-1, 0],
    'W' => [-1, 0]
  }
  position = [0, 0]
  direction = east

  input.each do |move|
    case move[0]
    when /[NESW]/
      position[0] += incr[move[0]][0] * move[1]
      position[1] += incr[move[0]][1] * move[1]
    when 'F'
      position[0] += incr[direction][0] * move[1]
      position[1] += incr[direction][1] * move[1]
    when 'R'
      direction = (direction + move[1] / 90) % 4
    when 'L'
      direction = (direction + 4 - move[1] / 90) % 4
    end
  end

  position[0].abs + position[1].abs
end

def rotate_waypoint_right(waypoint_x, waypoint_y, count)
  x, y = waypoint_x, waypoint_y
  count.times do
    x, y = y, -x
  end

  [x, y]
end

def rotate_waypoint_left(waypoint_x, waypoint_y, count)
  x, y = waypoint_x, waypoint_y
  count.times do
    x, y = -y, x
  end

  [x, y]
end

def part2(input)
  north, east, south, west = [0, 1, 2, 3]
  incr = {
    north => [0, 1],
    'N' => [0, 1],
    east => [1, 0],
    'E' => [1, 0],
    south => [0, -1],
    'S' => [0, -1],
    west => [-1, 0],
    'W' => [-1, 0]
  }
  position = [0, 0]
  direction = east
  waypoint = [10, 1]

  input.each do |move|
    case move[0]
    when /[NESW]/
      waypoint[0] += incr[move[0]][0] * move[1]
      waypoint[1] += incr[move[0]][1] * move[1]
    when 'F'
      position[0] += move[1] * waypoint[0]
      position[1] += move[1] * waypoint[1]
    when 'R'
      waypoint= rotate_waypoint_right(*waypoint, move[1]/90)
    when 'L'
      waypoint= rotate_waypoint_left(*waypoint, move[1]/90)
    end
  end

  position[0].abs + position[1].abs
end

input = ARGF.lines.to_a.map do |line|
  m = line.match(/(.)(.*)/)
  [
    m[1],
    m[2].to_i
  ]
end

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

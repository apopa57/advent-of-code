#!/usr/bin/env ruby

def part1(grid)
  grid.map { |row| row.count { |val| val > 1 } }.sum
end

def part2(claims, grid)
  claims.find do |claim|
    overlaps = false
    i = claim[:top]
    claim[:height].times do
      j = claim[:left]
      claim[:width].times do
        if grid[i][j] > 1
          overlaps = true
        end
        j += 1
      end
      i += 1
    end

    !overlaps
  end[:id]
end

claims = ARGF.lines.to_a.map do |line|
  m = line.match(/#(.*) @ (.*),(.*): (.*)x(.*)/)
  id, left, top, width, height = m[1..-1]
  {
    id: id.to_i,
    left: left.to_i,
    top: top.to_i,
    width: width.to_i,
    height: height.to_i
  }
end


width = claims.map { |claim| claim[:left] + claim[:width] }.max
height = claims.map { |claim| claim[:top] + claim[:height] }.max

grid = []
height.times { grid << [0] * width }

claims.each do |claim|
  i = claim[:top]
  claim[:height].times do
    j = claim[:left]
    claim[:width].times do
      grid[i][j] += 1
      j += 1
    end
    i += 1
  end
end

puts "Part 1: #{part1(grid)}"
puts "Part 2: #{part2(claims, grid)}"

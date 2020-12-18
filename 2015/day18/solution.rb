#!/usr/bin/env ruby

def on?(grid, i, j)
  if i < 0 || j < 0 || i >= grid.length || j >= grid[i].length
    false
  else
    grid[i][j] == '#'
  end
end

def num_on_neighbors(grid, i, j)
  [
    [-1, -1],
    [-1,  0],
    [-1,  1],
    [0,  -1],
    [0,   1],
    [1,  -1],
    [1,   0],
    [1,   1]
  ].count do |di, dj|
    on?(grid, i+di, j+dj)
  end
end

def next_grid(grid)
  new_grid = []
  grid.each_with_index do |row, i|
    new_row = []
    row.each_with_index do |light, j|
      on_neighbors = num_on_neighbors(grid, i, j)

      if light == '#'
        if (2..3).include?(on_neighbors)
          new_row << '#'
        else
          new_row << '.'
        end
      else
        if on_neighbors == 3
          new_row << '#'
        else
          new_row << '.'
        end
      end
    end
    new_grid << new_row
  end

  new_grid
end

def part1(input)
  grid = input
  100.times do
    grid = next_grid(grid)
  end

  grid.map { |row| row.count('#') }.sum
end

def part2(input)
  grid = input
  100.times do
    grid[0][0] = grid[0][-1] = grid[-1][0] = grid[-1][-1] = '#'
    grid = next_grid(grid)
  end

  grid[0][0] = grid[0][-1] = grid[-1][0] = grid[-1][-1] = '#'
  grid.map { |row| row.count('#') }.sum
end

input = ARGF.lines.to_a.map(&:strip).map(&:chars)

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

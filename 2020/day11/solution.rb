#!/usr/bin/env ruby

def num_occupied_seats_around(grid, i, j)
  n = grid.length
  m = grid[0].length

  count = 0
  [-1, 0, 1].each do |di|
    [-1, 0, 1].each do |dj|
      if di != 0 || dj != 0
        i1 = i+di
        j1 = j+dj

        next if i1 < 0 || i1 >= n || j1 < 0 || j1 >= m

        if grid[i1][j1] == '#'
          # puts "+1 for #{[i1, j1].inspect}"
          count += 1
        else
          # puts "0 for #{[i1, j1].inspect}"
        end
      end
    end
  end

  count
end

def part1(input)
  grid = input.map { |line| line.chars }

  n = grid.length
  m = grid[0].length

  loop do
    changed = false

    new_grid = []
    (0...n).each do |i|
      new_grid[i] = []
      (0...m).each do |j|
        # p [i, j, num_occupied_seats_around(grid, i, j)]
        if grid[i][j] == 'L' && num_occupied_seats_around(grid, i, j) == 0
          new_grid[i][j] = '#'
          changed = true
        elsif grid[i][j] == '#' && num_occupied_seats_around(grid, i, j) >= 4
          new_grid[i][j] = 'L'
          changed = true
        else
          new_grid[i][j] = grid[i][j]
        end
      end
    end

    grid = new_grid

    # puts grid.map { |line| line.join('')}.join("\n")
    # puts "\n"

    if !changed
      return grid.map { |line| line.count('#') }.sum
    end
  end
end

def num_occupied_seats_around2(grid, i, j)
  n = grid.length
  m = grid[0].length

  count = 0
  [
    [-1, -1],
    [-1, 0],
    [-1, 1],
    [0, -1],
    [0, 1],
    [1, -1],
    [1, 0],
    [1, 1]
  ].each do |di, dj|
    i1 = i + di
    j1 = j + dj
    while i1 >= 0 && i1 < n && j1 >= 0 && j1 < m
      if grid[i1][j1] == '#'
        count += 1
        break
      elsif grid[i1][j1] == 'L'
        break
      end

      i1 += di
      j1 += dj
    end
  end

  count
end

def part2(input)
  grid = input.map { |line| line.chars }

  n = grid.length
  m = grid[0].length

  loop do
    changed = false

    new_grid = []
    (0...n).each do |i|
      new_grid[i] = []
      (0...m).each do |j|
        # p [i, j, num_occupied_seats_around2(grid, i, j)]
        if grid[i][j] == 'L' && num_occupied_seats_around2(grid, i, j) == 0
          new_grid[i][j] = '#'
          changed = true
        elsif grid[i][j] == '#' && num_occupied_seats_around2(grid, i, j) >= 5
          new_grid[i][j] = 'L'
          changed = true
        else
          new_grid[i][j] = grid[i][j]
        end
      end
    end

    grid = new_grid

    # puts grid.map { |line| line.join('')}.join("\n")
    # puts "\n"

    if !changed
      return grid.map { |line| line.count('#') }.sum
    end
  end
end

input = ARGF.lines.to_a.map(&:strip)

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

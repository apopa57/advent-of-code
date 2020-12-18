#!/usr/bin/env ruby

def next_slices(slices)

  slices.map.with_index do |slice, k|
    slice.map.with_index do |row, i|
      row.map.with_index do |cube, j|
        if k < 1 || k >= slices.length-1 || i<1 || i >= slice.length-1 || j < 1 || j >= row.length-1
          '.'
        else
          num_active_neighbors = 0
          dir.each do |di, dj, dk|
            if slices[k+dk][i+di][j+dj] == '#'
              num_active_neighbors += 1
            end
          end

          if cube == '#'
            if (2..3).include?(num_active_neighbors)
              '#'
            else
              '.'
            end
          elsif cube == '.'
            if num_active_neighbors == 3
              '#'
            else
              '.'
            end
          end
        end
      end
    end
  end
end

def part1(input)
  dir = []

  (-1..1).each { |i| (-1..1).each { |j| (-1..1).each { |k| dir << [i, j, k] if [0, 0, 0] != [i, j, k] }}}

  h = {}

  input.each_with_index do |row, i|
    row.each_with_index do |cube, j|
      h[[0, i, j]] = cube
    end
  end

  n = input.length
  m = input[0].length

  (1..6).each do |round|
    h1 = {}

    (-round..round).each do |k|
      ((-round)...(n+round)).each do |i|
        ((-round)...(m+round)).each do |j|
          num_active_neighbors = dir.count { |di, dj, dk| h[[k+dk, i+di, j+dj]] == '#' }

          h1[[k, i, j]] = if h[[k, i, j]] == '#'
                            if (2..3).include?(num_active_neighbors)
                              '#'
                            else
                              '.'
                            end
                          else
                            if num_active_neighbors == 3
                              '#'
                            else
                              '.'
                            end
                          end
        end
      end
    end

    h = h1
  end

  num_active_cubes = 0
  h.each do |_, cube|
    if cube == '#'
      num_active_cubes += 1
    end
  end

  num_active_cubes
end

def part2(input)
  dir = []

  (-1..1).each { |i| (-1..1).each { |j| (-1..1).each { |k| (-1..1).each { |l| dir << [i, j, k, l] if [0, 0, 0, 0] != [i, j, k, l] }}}}

  p dir.length
  h = {}

  input.each_with_index do |row, i|
    row.each_with_index do |cube, j|
      h[[0, 0, i, j]] = cube
    end
  end

  n = input.length

  (1..6).each do |round|
    h1 = {}

    (-round..round).each do |k|
      ((-round)...(n+round)).each do |l|
        ((-round)...(n+round)).each do |i|
          ((-round)...(n+round)).each do |j|
            num_active_neighbors = dir.count { |di, dj, dk, dl| h[[k+dk, l+dl, i+di, j+dj]] == '#' }

            h1[[k, l, i, j]] = if h[[k, l, i, j]] == '#'
                                 if (2..3).include?(num_active_neighbors)
                                   '#'
                                 else
                                   '.'
                                 end
                               else
                                 if num_active_neighbors == 3
                                   '#'
                                 else
                                   '.'
                                 end
                               end
          end
        end
      end
    end

    h = h1
  end

  num_active_cubes = 0
  h.each do |_, cube|
    if cube == '#'
      num_active_cubes += 1
    end
  end

  num_active_cubes
end

input = ARGF.lines.to_a.map { |line| line.strip.chars.to_a }

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

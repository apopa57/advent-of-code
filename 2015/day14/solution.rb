#!/usr/bin/env ruby

def part1(input, race_duration)
  input.map do |name, speed, fly_time, rest_time|
    cycle_time = fly_time + rest_time
    full_cycles = race_duration / cycle_time

    final_flight_time = [fly_time, race_duration%cycle_time].min

    speed * (full_cycles*fly_time + final_flight_time)
  end.max
end

class Reindeer
  attr_reader :distance, :name
  attr_accessor :points

  def initialize(name, speed, fly_time, rest_time)
    @name = name
    @speed = speed
    @fly_time = fly_time
    @rest_time = rest_time
    @distance = 0
    @in_flight = true
    @seconds_in_flight = 0
    @resting = false
    @seconds_resting = 0
    @points = 0
  end

  def tick
    if @in_flight
      if @seconds_in_flight < @fly_time
        @seconds_in_flight += 1
        @distance += @speed
      else
        @resting = true
        @in_flight = false
        @seconds_resting = 1
      end
    elsif @resting
      if @seconds_resting < @rest_time
        @seconds_resting += 1
      else
        @resting = false
        @in_flight = true
        @seconds_in_flight = 1
        @distance += @speed
      end
    end
  end
end

def part2(input, race_duration)
  status = {}

  reindeer = input.map { |name, speed, fly_time, rest_time| Reindeer.new(name, speed, fly_time, rest_time) }

  race_duration.times do |i|
    puts "At the end of second #{i+1}"

    reindeer.each { |r| r.tick }

    # update points
    max_distance = reindeer.max_by(&:distance).distance
    puts "max_distance is #{max_distance}"

    reindeer.each do |r|
      if r.distance == max_distance
        r.points += 1
      end
      puts "#{r.name} has #{r.points} points"
    end
  end

  reindeer.max_by(&:points).points
end

input = ARGF.lines.map do |line|
  m = line.match(/(.*) can fly (.*) km\/s for (.*) seconds, but then must rest for (.*) seconds/)

  [
    m[1],
    m[2].to_i,
    m[3].to_i,
    m[4].to_i
  ]
end

race_duration = 2503
puts "Part 1: #{part1(input, race_duration)}"
puts "Part 2: #{part2(input, race_duration)}"

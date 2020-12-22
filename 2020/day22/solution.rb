#!/usr/bin/env ruby

def score(cards)
  s = 0
  n = cards.length
  cards.each do |card|
    s += (card * n)
    n -= 1
  end

  s
end

def part1(deck1, deck2)
  player1 = deck1.dup
  player2 = deck2.dup
  loop do
    if player1.empty?
      return score(player2)
    elsif player2.empty?
      return score(player1)
    end

    a = player1.shift
    b = player2.shift

    if a > b
      player1 << a
      player1 << b
    else
      player2 << b
      player2 << a
    end
  end
end

def recursive_combat(deck1, deck2)
  player1 = deck1.dup
  player2 = deck2.dup

  seen = {}

  round = 1
  loop do
    config = "#{player1.inspect}#{player2.inspect}"
    if seen[config]
      return :player1, player1
    elsif player1.empty?
      return :player2, player2
    elsif player2.empty?
      return :player1, player1
    else
      seen[config] = true
    end

    top1 = player1.shift
    top2 = player2.shift

    if top1 <= player1.length && top2 <= player2.length
      winner, _ = recursive_combat(player1.take(top1), player2.take(top2))
      if winner == :player1
        player1 += [top1, top2]
      elsif winner == :player2
        player2 += [top2, top1]
      else
        fail 'Not supposed to happen'
      end
    elsif top1 > top2
      player1 += [top1, top2]
    else
      player2 += [top2, top1]
    end

    round += 1
  end
end

def part2(deck1, deck2)
  recursive_combat(deck1, deck2)[1]
end

player1 = []
player2 = []
player = nil
input = ARGF.lines.to_a.map do |line|
  if line =~ /Player 1/
    player = player1
  elsif line =~ /Player 2/
    player = player2
  elsif line =~ /\d/
    player << line.to_i
  end
end

puts "Part 1: #{part1(player1, player2)}"
puts "Part 2: #{score(part2(player1, player2))}"

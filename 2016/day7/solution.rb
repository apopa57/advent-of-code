#!/usr/bin/env ruby

require 'set'

# TODO: figure out what's wrong with this algorithm
# def supports_tls(ip)
#   has_abba_outside_square_brackets = false
#   has_abba_inside_square_brackets = false
#   has_abba = false
#   ip.chars.each_with_index do |char, i|
#     if char == '['
#       has_abba_outside_square_brackets ||= has_abba
#       has_abba = false
#     elsif char == ']'
#       has_abba_inside_square_brackets ||= has_abba
#       has_abba = false
#     elsif i >= 3 && ip[i] != ip[i-1] && ip[i-3] == ip[i] && ip[i-2] == ip[i-1]
#       has_abba = true
#     end
#   end
#
#   has_abba_outside_square_brackets && !has_abba_inside_square_brackets
# end

def supports_tls(ip)
  m = ip.match(/\[[a-z]*(.)(.)\2\1/)
  if m && m[1] != m[2]
    return false
  end

  m = ip.match(/(.)(.)\2\1/)
  if m && m[1] != m[2]
    return true
  end

  false
end

{
  'abba[mnop]qrst' => true,
  'abcd[bddb]xyyx' => false,
  'aaaa[qwer]tyui' => false,
  'ioxxoj[asdfgh]zxcvbn' => true,
  'xdsqxnovprgovwzkus[fmadbfsbqwzzrzrgdg]aeqornszgvbizdm' => false,
  'itgslvpxoqqakli[arktzcssgkxktejbno]wsgkbwwtbmfnddt[zblrboqsvezcgfmfvcz]iwyhyatqetsreeyhh' => false
}.each do |ip, expected_supports_tls|
  if expected_supports_tls != supports_tls(ip)
    fail "Exected #{expected_supports_tls} for #{ip.inspect} but got #{supports_tls(ip).inspect}"
  end
end

def part1(input)
  input.count { |ip| supports_tls(ip) }
end

def supports_ssl(ip)
  abas = Set.new
  babs = Set.new
  in_square_brackets = false
  ip.chars.each_with_index do |char, i|
    case char
    when '['
      in_square_brackets = true
    when ']'
      in_square_brackets = false
    else
      if i < 2
        next
      elsif in_square_brackets
        if ip[i] == ip[i-2] && ip[i-1] != '['
          abas << "#{ip[i-1]}#{ip[i]}#{ip[i-1]}"
        end
      else
        if ip[i] == ip[i-2] && ip[i-1] != ']'
          babs << "#{ip[i-2]}#{ip[i-1]}#{ip[i]}"
        end
      end
    end
  end

  abas.intersect?(babs)
end

{
  'aba[bab]xyz' => true,
  'xyx[xyx]xyx' => false,
  'aaa[kek]eke' => true,
  'zazbz[bzb]cdb' => true
}.each do |ip, expected_supports_ssl|
  if expected_supports_ssl != supports_ssl(ip)
    fail "Exected #{expected_supports_ssl} for #{ip.inspect} but got #{supports_ssl(ip)}"
  end
end
def part2(input)
  input.count { |ip| supports_ssl(ip) }
end

input = ARGF.lines.to_a

puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"

#!/usr/bin/env ruby

def valid_passport?(passport)
  passport.key?('pid') &&
    passport.key?('ecl') &&
    passport.key?('hcl') &&
    passport.key?('hgt') &&
    passport.key?('eyr') &&
    passport.key?('iyr') &&
    passport.key?('byr')
end

def valid_height?(hgt)
  if hgt.end_with?('cm')
    cm = hgt[0..-3].to_i
    (150..193).include?(cm)
  elsif hgt.end_with?('in')
    inch = hgt[0..-3].to_i
    (59..76).include?(inch)
  end
end

def valid_passport_phase2?(passport)
  byr = passport['byr']
  iyr = passport['iyr']
  eyr = passport['eyr']
  hgt = passport['hgt']
  hcl = passport['hcl']
  ecl = passport['ecl']
  pid = passport['pid']
  # byr (Birth Year) - four digits; at least 1920 and at most 2002.
  # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
  # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
  # hgt (Height) - a number followed by either cm or in:
  # If cm, the number must be at least 150 and at most 193.
  # If in, the number must be at least 59 and at most 76.
  # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
  # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
  # pid (Passport ID) - a nine-digit number, including leading zeroes.
  # cid (Country ID) - ignored, missing or not.
  valid_passport?(passport) &&
    (1920..2002).include?(byr.to_i) &&
    (2010..2020).include?(iyr.to_i) &&
    (2020..2030).include?(eyr.to_i) &&
    valid_height?(hgt) &&
    hcl =~ /^#[0-9a-f]{6}/ &&
    ecl =~ /^(amb|blu|brn|gry|grn|hzl|oth)$/ &&
    pid =~ /^[0-9]{9}$/
end

h = {}
passports = []
ARGF.each_line do |line|
  if line.strip.empty?
    passports << h
    h = {}
  else
    line.split(/\s+/).each do |token|
      field, value = token.split(':')
      h[field] = value
    end
  end
end

puts "Total: #{passports.length}"
puts "Phase 1: #{passports.count { |p| valid_passport?(p) }}"
puts "Phase 2: #{passports.count { |p| valid_passport_phase2?(p) }}"

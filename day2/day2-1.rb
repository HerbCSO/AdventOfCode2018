#!/usr/bin/env ruby
counts2 = 0
counts3 = 0
open(ARGV[0]) do |file|
  file.each do |line|
    letters = Hash.new { |k, v| k = k; v = 0 }
    line.scan(/./) do |char|
      letters[char] += 1
    end
    counts2 += 1 if letters.any? { |_k, v| v == 2 }
    counts3 += 1 if letters.any? { |_k, v| v == 3 }
  end
end
puts "Checksum = #{counts2 * counts3}"

#!/usr/bin/env ruby
open("data-day1.txt") do |file|
  final_frequency = 0
  file.each do |line|
    final_frequency += line.to_i
  end
  puts final_frequency
end

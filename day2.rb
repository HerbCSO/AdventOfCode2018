#!/usr/bin/env ruby
require 'awesome_print'

frequencies = Hash.new { |k, v| k = k; v = 0 }
# frequencies[0] += 1
current_frequency = 0
iteration = 0
while true do
  puts "Iteration #{iteration+=1}"
  open(ARGV[0]) do |file|
     file.each do |line|
      current_frequency += line.to_i
      # puts "Input: #{line} Converted: #{line.to_i} current_frequency: #{current_frequency}"
      frequencies[current_frequency] += 1
      if frequencies[current_frequency] > 1
        puts "******* RESULT: #{current_frequency} *******"
        found = true
        exit
      end
    end
  end
end

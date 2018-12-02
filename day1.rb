#!/usr/bin/env ruby
open("data-day1.txt") do |file|
  puts file.map{ |line| line.to_i }.reduce(0, :+)
end

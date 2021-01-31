#!/usr/bin/env ruby
def parse_line(line)
  # puts line
  nil if line.to_s.strip.empty?
  claim_number, x_pos, y_pos, x_length, y_length = line.split(/ @ |,|: |x/)
  [claim_number, x_pos.to_i, y_pos.to_i, x_length.to_i, y_length.to_i]
end

def fill_fabric(fabric, claim_number, x_pos, y_pos, x_length, y_length)
  # puts x_pos+x_length
  # puts y_pos+y_length
  (x_pos...x_pos+x_length).each do |x|
    (y_pos...y_pos+y_length).each do |y|
      # puts "#{x}, #{y}, #{claim_number}"
      fabric[[x, y]] << claim_number
      # pp fabric
    end
  end
end

fabric = Hash.new { |h, k| h[k] = [] }
open(ARGV[0]) do |file|
  file.each do |line|
    claim_number, x_pos, y_pos, x_length, y_length = parse_line(line)
    # puts "#{claim_number}, #{x_pos}, #{y_pos}, #{x_length}, #{y_length}"
    fill_fabric(fabric, claim_number, x_pos, y_pos, x_length, y_length)
  end
end
assignments = fabric.values.flatten.uniq
dupes = fabric.select { |_coords, assigned| assigned.length > 1 }.values.flatten.uniq
puts assignments - dupes

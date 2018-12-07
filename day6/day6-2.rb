#!/usr/bin/env ruby
require 'ostruct'
require 'pry'

def parse_line(line)
  nil if line.to_s.strip.empty?
  x, y = line.split(/, /)
  [x.to_i, y.to_i]
end

def distance_to(x, y, coord)
  # pp "x: #{x} y: #{y} coord: #{coord}"
  dist = (x - coord.x).abs + (y - coord.y).abs
  # pp "dist: #{dist}"
  OpenStruct.new(coord: coord, distance: dist)
end

coords = []
open(ARGV[0]) do |file|
  file.each_with_index do |line, point|
    x, y = parse_line(line)
    coords << OpenStruct.new(point: point, x: x, y: y)
  end
end
# pp coords
min_x = coords.min_by {|e| e.x}.x
max_x = coords.max_by {|e| e.x}.x
min_y = coords.min_by {|e| e.y}.y
max_y = coords.max_by {|e| e.y}.y
grid = Array.new(max_y - min_y + 1) { Array.new(max_x - min_x + 1) }
# pp grid
grid.each_with_index do |col, y|
  col.each_with_index do |row, x|
    coord_distances = 0
    coords.each do |coord|
      coord_distances += distance_to(x + min_x, y + min_y, coord).distance
    end
    # min_distances = coord_distances.group_by { |coord| coord.distance }.min
    # pp "min_distances: #{min_distances}"
    grid[y][x] = coord_distances
  end
end

# points_to_remove = []
# points_to_remove << grid.first.compact.map(&:last).map(&:first).map{|e|e.coord.point}.uniq
# points_to_remove << grid.last.compact.map(&:last).map(&:first).map{|e|e.coord.point}.uniq
# points_to_remove << grid.map(&:first).compact.map(&:last).map(&:first).map(&:coord).map(&:point).uniq
# points_to_remove << grid.map(&:last).compact.map(&:last).map(&:first).map(&:coord).map(&:point).uniq
# points_to_remove.flatten!.uniq!
# pp points_to_remove
# pp grid
# grid.each_with_index do |col, y|
#   col.each_with_index do |row, x|
#     grid[y][x] = nil if grid[y][x] && points_to_remove.include?(grid[y][x].last.last.coord.point)
#   end
# end
# binding.pry
# pp grid.map(&:compact).map{|col|col.map(&:last)}.flatten.map(&:coord).map(&:point).group_by(&:to_i).max_by{|e|e.last.length}.last.length
# pp grid = grid.flatten.group_by { |coord| coord }.tap { |h| h.delete(nil) }
# pp grid.max_by { |e| e.last.length }.last.length
# pp grid
pp grid.flatten.select { |row| row < 10000 }.length

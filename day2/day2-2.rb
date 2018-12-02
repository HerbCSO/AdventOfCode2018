#!/usr/bin/env ruby
require "awesome_print"

# Shamelessly copied from https://stackoverflow.com/a/46410685
def levenshtein_distance(s, t)
  v0 = (0..t.length).to_a
  v1 = []

  s.chars.each_with_index do |s_ch, i|
    v1[0] = i + 1

    t.chars.each_with_index do |t_ch, j|
      cost = s_ch == t_ch ? 0 : 1
      v1[j + 1] = [v1[j] + 1, v0[j + 1] + 1, v0[j] + cost].min
    end
    v0 = v1.dup
  end

  v0[t.length]
end

open(ARGV[0]) do |file|
  previous_line = nil
  file.sort.each do |line|
    if previous_line
      if levenshtein_distance(previous_line, line) == 1
        previous_letters = previous_line.scan(/./)
        current_letters = line.scan(/./)
        puts previous_letters.delete_if { |e| e == (previous_letters - current_letters).first }.join
      end
    end
    previous_line = line
  end
end

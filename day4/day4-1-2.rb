#!/usr/bin/env ruby
require 'time'

def parse_line(line)
  nil if line.to_s.strip.empty?
  _, time, action = line.split(/\[|\] /)
  if action =~ /Guard #(\d+) begins shift/
    guard_num = $1
    action = :begin_shift
  end
  if action =~ /falls asleep/
    action = :asleep
  end
  if action =~ /wakes up/
    action = :wakeup
  end
  [Time.parse(time), action, guard_num]
end

guard_asleep_at = Hash.new { |h, k| h[k] = Hash.new { |hi, ki| hi[ki] = 0 } }
guard_asleep_minutes = Hash.new { |h, k| h[k] = 0 }
open(ARGV[0]) do |file|
  current_guard = nil
  start_time, end_time = nil
  file.sort.each do |line|
    time, action, guard_num = parse_line(line)
    current_guard = guard_num unless guard_num.nil?
    if action == :asleep
      start_time = time
    end
    if action == :wakeup
      end_time = time
      (start_time.min...end_time.min).each do |minute|
        guard_asleep_at[current_guard][minute] += 1
        guard_asleep_minutes[current_guard] += 1
      end if start_time && end_time
    end
  end
end
guard_asleep_longest = guard_asleep_minutes.select{ |_k, v| v == guard_asleep_minutes.values.max }.first.first
guard_asleep_most = guard_asleep_at[guard_asleep_longest]
guard_asleep_most_minute = guard_asleep_most.select{ |_k, v| v == guard_asleep_most.values.max }.first.first
puts guard_asleep_most_minute * guard_asleep_longest.to_i
guard, minute = guard_asleep_at.map { |k, v| { k.to_i => v.max_by { |_ki, vi| vi } } }.map{|e|e.first}.to_h.max_by { |_k, v| v.last }
puts guard * minute.first

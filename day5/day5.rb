#!/usr/bin/env ruby

# dabAcCaCBAcCcaDA  The first 'cC' is removed.
# dabAaCBAcCcaDA    This creates 'Aa', which is removed.
# dabCBAcCcaDA      Either 'cC' or 'Cc' are removed (the result is the same).
# dabCBAcaDA        No further actions can be taken.

original_data = open(ARGV[0]).read.strip
# puts data

def opposite_pair?(pair)
  pair.first.downcase == pair.last.downcase && pair.first != pair.last
end

def process_by_pairs(data)
  result = []
  skip_next = false
  (data + " ").scan(/./).each_cons(2) do |slice|
    if skip_next
      # puts "Skipping slice #{slice}"
      skip_next = false
      next
    end
    # puts "slice: #{slice}"
    if opposite_pair?(slice)
      skip_next = true
      # puts "Removing pair #{slice}"
    else
      result << slice.first
    end
    # puts "original: #{data}"
    # puts "result:   #{result.join}"
  end
  result
end

def process_data(original_data)
  data = original_data.dup
  current_length = data.length
  previous_length = nil
  while current_length != previous_length do
    data = process_by_pairs(data).flatten.join
    previous_length = current_length
    current_length = data.length
  end
  data.length
end

puts "Reduced original: #{process_data(original_data)}"

lengths = []
("a".."z").each do |letter|
  data = original_data.dup.gsub!(/#{letter}/i, "")
  length = process_data(data)
  lengths << length
  puts "Removing letter #{letter} gives #{length}"
end
puts "Minimum length: #{lengths.min}"

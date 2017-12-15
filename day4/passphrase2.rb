nr_valid = 0

def is_valid(words)
    anagrams = words.map {|s| s.split("").sort}
    real = words.length
    filtered = anagrams.sort.uniq.length
    real == filtered
end


File.open(ARGV[0]).each_line do |line|
    if line === "\n"
        next
    end

    if is_valid(line.chop.split(" "))
        nr_valid += 1
    else
        puts "Anagrams in: #{line}"
    end
end

puts "Valid phrases: #{nr_valid}"


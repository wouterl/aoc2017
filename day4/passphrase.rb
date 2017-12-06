nr_valid = 0
File.open(ARGV[0]).each_line do |line|
    if line === "\n"
        next
    end

    words = line.split(" ")
    nrwords = words.length
    nruniq = words.sort.uniq.length

    if nrwords != nruniq
        puts "Duplicates in: #{line}"
    else
        nr_valid += 1
    end
end

puts "Valid phrases: #{nr_valid}"

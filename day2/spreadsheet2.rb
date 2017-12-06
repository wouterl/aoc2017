checksum = 0
File.open(ARGV[0]).each_line do |line|
    nrs = line.split(" ").map { |s| s.to_i }
	p nrs

    multiple = 0
    nrs.each do |nr|
        divisors = nrs.select { |i| nr % i == 0 && nr != i }
        if divisors.length > 1
            puts "ERROR: too many divisors"
        end

        if divisors.length == 1
            if multiple != 0
                puts "ERROR: already found a divisor"
            else
                multiple = nr / divisors.first
                # puts "Found multiple #{multiple}"
            end
        end
    end

    checksum += multiple
end

puts "Checksum: #{checksum}"

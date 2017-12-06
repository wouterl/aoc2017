checksum = 0
File.open(ARGV[0]).each_line do |line|
    nrs = line.split(" ").map { |s| s.to_i }
    p nrs

    checksum += nrs.max - nrs.min
end

puts "Checksum: #{checksum}"

def funny_sum(input)
    tokens = input.chop.split("").map { |s| s.to_i }

    # Array rotated by one
    tokens_rot = tokens[1..-1] + tokens[0..0]

    sum = 0
    pairs = tokens.zip tokens_rot
    pairs.each do |p|
        if p.first == p.last
            sum += p.first
        end
    end

    sum
end

File.open("inversecaptcha.in").each do |line|
    puts line
    sum = funny_sum line
    puts "+++ #{sum}"
end

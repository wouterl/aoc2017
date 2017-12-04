
def funny_sum_skip(input)
    tokens = input.strip().split("").map { |s| s.to_i }
    offset = tokens.length / 2

    # Array rotated by one
    tokens_rot = tokens[offset..-1] + tokens[0..(offset - 1)]

    sum = 0
    pairs = tokens.zip tokens_rot
    pairs.each do |p|
        if p.first == p.last
            sum += p.first
        end
    end

    sum
end

File.open("inversecaptcha2.in").each do |line|
    puts line
    sum = funny_sum_skip line
    puts "+++ #{sum}"
end

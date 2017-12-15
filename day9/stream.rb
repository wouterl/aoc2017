def score_stream(str)
    depth = 0
    garbage = false
    nrgroups = 0
    score = 0
    garbage_count = 0

    i = 0
    while i < str.length
        if garbage
            # escape next character
            if str[i] == "!"
                i += 2
                next
            end

            # leaving garbage
            if str[i] == ">"
                garbage = false
            else
                garbage_count += 1
            end
        else 
            # start of garbage
            if str[i] == "<"
                garbage = true
            end

            # opening of new group
            if str[i] == "{"
                nrgroups += 1
                depth += 1
                score += depth
            end

            # closing of group
            if str[i] == "}"
                depth -= 1
            end
        end

        i += 1
    end

    return nrgroups, score, garbage_count
end


File.open("stream.in").each_line do |line|
    p line
    p score_stream(line)
end



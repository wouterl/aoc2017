def reallocate(memory)
    val, idx = memory.each_with_index.max_by(&:first)

    memory[idx] = 0
    l = memory.length
    1.upto val do |offset|
        memory[(idx + offset) % l] += 1
    end
    memory
end

def steps_until_cycle(memory)
    curr = memory

    seen = {}
    seen[curr] = true

    count = 0
    loop do
        count += 1
        curr = reallocate(curr)
        break if seen[curr]
        seen[curr] = true
    end

    count
end

File.open("cycle.in").each_line do |line|
    memory = line.chop.split(" ").map {|s| s.to_i}
    p memory
    p steps_until_cycle memory
end



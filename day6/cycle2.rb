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

    count = 0
    seen = {}
    seen[curr] = count

    loop do
        count += 1
        curr = reallocate(curr)
        break if seen[curr]
        seen[curr] = count
    end

    return count, count - seen[curr]
end

File.open("cycle.in").each_line do |line|
    memory = line.chop.split(" ").map {|s| s.to_i}
    p memory
    step, length = steps_until_cycle memory
    puts "Cycling at step #{step}, length is #{length}"
end



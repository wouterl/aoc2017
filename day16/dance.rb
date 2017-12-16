def dance_with_file len, file
    moves = File.read(file).chop.split(",")
    nodes = ("a"...("a".ord + len).chr).to_a
    dance nodes, moves
end

def dance nodes, moves
    moves.each do |m|
        cmd = m[0]
        rest = m[1..-1]
        case cmd
        when "s"
            len = rest.to_i
            head = nodes[0...-len]
            tail = nodes[-len..-1]
            nodes = tail + head
        when "x"
            i1, i2 = rest.split("/").map {|s| s.to_i}
            tmp = nodes[i1]
            nodes[i1] = nodes[i2]
            nodes[i2] = tmp
        when "p"
            n1, n2 = rest.split("/")
            i1 = nodes.find_index(n1)
            i2 = nodes.find_index(n2)
            tmp = nodes[i1]
            nodes[i1] = nodes[i2]
            nodes[i2] = tmp
        end
    end
    nodes
end

p (dance_with_file 5, "dance.in").join("")
p (dance_with_file 16, "dance.in.1").join("")

# dance ["a", "b", "c", "d", "e"], ["s3"]

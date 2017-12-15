def hash_step list, lengths, pos, skip
    len = list.length

    lengths.each do |l|
        segment = (list + list)[pos...(pos+l)]
        segment.reverse!

        list[pos...(pos+l)] = segment[0...(len - pos)]

        if pos + l >= len
            list[0...(pos+l-len)] = segment[(len-pos)..-1]
        end

        pos = (pos + l + skip) % len
        skip += 1
    end
    return list, pos, skip
end

SUFFIX = [17, 31, 73, 47, 23]
def string_to_input str
    str.split("").map { |c| c.ord } + SUFFIX
end

def sparse_hash str
    pos = 0
    skip = 0
    list = (0..255).to_a
    lengths = string_to_input str
    64.times do
        list, pos, skip = hash_step list, lengths, pos, skip
    end
    list
end

def make_dense list
    res = []
    while !list.empty?
        block = list.take(16)
        res.push block.inject(0) { |v,s| s = s ^ v }
        list = list.drop(16)
    end
    res
end

def dense_hash str
    perm = sparse_hash str
    return make_dense perm
end

def dense_hash_str str
    list = dense_hash str
    list.map { |v| sprintf("%02x", v) }.join("")
end

p make_dense [65, 27, 9, 1, 4, 3, 40, 50, 91, 7, 6, 0, 2, 5, 68, 22]
p string_to_input("1,2,3")

list = (0..255).to_a
res, pos, skip = hash_step list, [34,88,2,222,254,93,150,0,199,255,39,32,137,136,1,167], 0, 0
p res
p res[0] * res[1]

p dense_hash_str ""
p dense_hash_str "AoC 2017"
p dense_hash_str "1,2,3"
p dense_hash_str "1,2,4"

def byte_as_grid v
    s = v.to_s(2)
    s = "0" * (8 - s.length) + s
    s.gsub("0", ".").gsub("1", "#")
end

def hamming_weight byte
    s = byte.to_s(2)
    s.gsub("0", "").length
end

def hamming_weight_list list
    list.map {|v| hamming_weight(v)}.inject(0) {|v,s| s += v}
end

def grid_used input
    total = 0
    (0..127).each do |i|
        input_str = input + "-" + i.to_s
        bytes = dense_hash input_str
        total += hamming_weight_list bytes
    end
    total
end

def make_grid input
    total = 0
    grid = Array.new(128)
    (0..127).each do |row|
        input_str = input + "-" + row.to_s
        bytes = dense_hash input_str
        grid[row] = bytes.map { |b| byte_as_grid(b) }.join("").split("").map { |v|
            if v == "#"
                true
            else
                false
            end
        }
    end
    grid
end

def count_regions grid
    regions = Array.new(128) {Array.new(128, 0)}
    nr_regions = 0

    (0..127).each do |row|
        (0..127).each do |col|
            if grid[row][col] && regions[row][col] == 0
                nr_regions += 1
                regions = mark_region grid, regions, row, col, nr_regions
            end
        end
    end

    nr_regions
end

def mark_region grid, regions, row, col, marker
    if row < 0 || col < 0 || row >= grid.length || col >= grid[0].length
        return regions
    end

    if regions[row][col] > 0
        return regions
    end

    if grid[row][col]
        # Mark this point
        regions[row][col] = marker

        # Recursively mark all neighbors
        regions = mark_region grid, regions, row + 1, col, marker
        regions = mark_region grid, regions, row - 1, col, marker
        regions = mark_region grid, regions, row, col + 1, marker
        regions = mark_region grid, regions, row, col - 1, marker
    end
    
    regions
end



p byte_as_grid(15)
p byte_as_grid(17)
p byte_as_grid(65)

puts "\n\n\n"

(0..8).each do |i|
    input = "flqrgnkx-" + i.to_s
    bytes = dense_hash input
    p byte_as_grid bytes[0]
end

puts "\n\n\n"

p grid_used "flqrgnkx"
p grid_used "uugsqrei"

grid = make_grid "flqrgnkx"
p count_regions grid

grid = make_grid "uugsqrei"
p count_regions grid

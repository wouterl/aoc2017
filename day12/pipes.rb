nodes = []
neighbors = Hash.new([])

def connected_component start, nodes, neighbors
  visited = Hash.new(false)

  i = 0
  stack = [start]
  visited[start] = true
  while i < stack.length
    node = stack[i]

    neighbors[node].each do |n|
      if !visited[n] && nodes.include?(n)
        stack.push n
        visited[n] = true
      end
    end

    i += 1
  end

  stack
end

def nr_groups nodes, neighbors
  nr_groups = 0
  while !nodes.empty?
    group = connected_component nodes[0], nodes, neighbors
    nr_groups += 1
    nodes = nodes - group
  end
  nr_groups
end

File.open(ARGV[0]).each do |line| 
  nstr, cstr = line.split(" <-> ")
  node = nstr.to_i
  neighbors[node] = cstr.split(",").map { |s| s.to_i }
  nodes.push node
end

comp = connected_component 0, nodes, neighbors
p comp
p comp.length

p nr_groups nodes, neighbors

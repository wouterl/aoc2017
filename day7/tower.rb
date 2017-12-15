
nodes = {}
parent = {}
leafs = []

File.open(ARGV[0]).each_line do |line|
    str_node, str_children = line.chop.split(" -> ")

    # processing node
    node, str_weight = str_node.split(" ")
    weight = str_weight[1..-2].to_i
    # puts "Node #{node} of weight #{weight}"

    # process children
    if str_children
        str_children.split(", ").each do |child|
            parent[child] = node
            # puts "Parent of #{child} is #{node}"
        end
    else
        leafs.push node
    end
end
p leafs

# finding parent for leafs[0]
curr = leafs[0]
while parent[curr]
    curr = parent[curr]
end
puts "Root is #{curr}"

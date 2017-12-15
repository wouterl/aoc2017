
nodes = {}
parent = {}
leafs = []

class TreeNode
    attr_accessor :name, :parent, :children

    def initialize line
        str_name, str_children = line.chop.split(" -> ")

        # processing node
        @name, str_weight = str_name.split(" ")
        @weight = str_weight[1..-2].to_i

        # process children
        @children_by_name = []
        if str_children
            @children_by_name = str_children.split(", ")
        else
            @isleaf = true
        end

        @parent = nil
    end

    def reconstruct nodes_by_name
        @children = @children_by_name.map do |c|
            nodes_by_name[c]
        end

        @children.each do |c|
            c.parent = self
        end
    end

    def tower_weight
        total = @weight
        @children.each do |c|
            total += c.tower_weight
        end
        total
    end

    def print_tree depth
        tweight = self.tower_weight
        puts " " * depth + "Node: #{@name} of weight #{@weight} -> tower is #{tweight}"
        @children.each do |c|
            c.print_tree (depth + 2)
        end
    end

    def is_balanced
        @children.map { |c| c.tower_weight }.uniq.length == 1
    end

    def wrong_child
        child_weights = @children.map { |c| c.tower_weight }
        p child_weights

        occurences = Hash.new(0)
        child_weights.each { |w| occurences[w] += 1 }
        p occurences
        p occurences.size

        if occurences.size > 2
            puts "ERROR: too many options"
            exit 1
        end

        unless occurences.values.include? 1
            puts "ERROR: ambigues"
            exit 1
        end

        odd_weight = nil
        occurences.each { |k,v| odd_weight = k if v == 1 }
        p odd_weight

        p child_weights
        child_weights.delete(odd_weight)
        normal_weight = child_weights[0]

        odd_child = nil
        @children.each do |c|
            odd_child = c if c.tower_weight == odd_weight
        end

        puts "RETURNING"
        p odd_child
        p normal_weight

        return odd_child, normal_weight
    end

    def balance target
        if is_balanced
            diff = target - tower_weight
            puts "Name: #{@name}, weight = #{@weight}, target = #{@weight + diff}"
            return diff
        else
            next_child, target = wrong_child
            next_child.balance target
        end
    end
end

nodes_by_name = {}
nodes = []
File.open(ARGV[0]).each_line do |line|

    t = TreeNode.new line
    nodes_by_name[t.name] = t
    nodes.push t
end

nodes.each do |n|
    n.reconstruct nodes_by_name
end

# finding parent for leafs[0]
curr = nodes[0]
while curr.parent
    curr = curr.parent
end
root = curr

root.print_tree 0

p root.is_balanced
root.wrong_child

root.balance nil

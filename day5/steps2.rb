def step(maze, pos)
    jump = maze[pos]

    if jump >= 3
        maze[pos] -= 1
    else
        maze[pos] += 1
    end

    return maze, pos + jump
end

lines = File.readlines(ARGV[0])
maze = lines.select { |s| s != "\n" }.map { |s| s.to_i }

pos = 0
steps = 0
while pos < maze.length
    maze, pos = step maze, pos
    steps += 1
end
p steps

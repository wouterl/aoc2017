def find_square(n)
    side = Math.sqrt(n)

    side = side.ceil
    if side % 2 == 0
        side += 1
    end

    side
end

def find_coord(side, n)
    delta = side / 2  # integer division

    pos = (side - 2)**2 + 1
    target = n - pos

    length = side - 1

    if target < length
        x = delta
        y = -(delta - 1) + target
    elsif target < 2*length
        x = delta - 1 - (target - length)
        y = delta
    elsif target < 3*length
        x = -delta
        y = delta - 1 - (target - 2*length)
    elsif target < 4*length
        x = -(delta - 1) + (target - 3*length)
        y = -delta
    end

    return x, y
end

def distance(n)
    side = find_square(n)
    x, y = find_coord(side, n)
    puts "loc of #{n}: #{x},#{y}"

    x.abs + y.abs
end

def adjacent_sum(grid, xr, yr)
    sum = 0
    sum += grid[xr + 1][yr + 0]
    sum += grid[xr + 1][yr + 1]
    sum += grid[xr + 0][yr + 1]
    sum += grid[xr - 1][yr + 1]
    sum += grid[xr - 1][yr + 0]
    sum += grid[xr - 1][yr - 1]
    sum += grid[xr + 0][yr - 1]
    sum += grid[xr + 1][yr - 1]
    sum
end

max_side = ARGV[0].to_i
target = ARGV[1].to_i

side = max_side + 2
delta = side / 2

grid = Array.new(side){Array.new(side, 0)}
grid[delta][delta] = 1


2.upto max_side**2 do |n|
    s = find_square n
    x, y = find_coord s, n

    xr = x + delta
    yr = y + delta

    sum = adjacent_sum grid, xr, yr
    grid[xr][yr] = sum

    if sum > target
        puts "Solution: #{sum}"
        exit 0
    end
end

puts "No solution"
exit 1

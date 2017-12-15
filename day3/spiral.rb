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

File.open("spiral.in").each_line do |line|
    n = line.to_i
    d = distance(n)
    puts "#{n}: distance #{d}"
end

AFACTOR = 16807
BFACTOR = 48271

def print_binary(a)
    s = a.to_s(2)
    puts "0" * (32 - s.length) + s
end

def count_matches a, b
    matches = 0
    (40 * 10**6).times do
        a = (a * AFACTOR) % 2147483647
        b = (b * BFACTOR) % 2147483647

        if (a % 2**16) == (b % 2** 16)
            matches += 1
        end
    end
    return matches
end

def count_matches2 a, b
    matches = 0
    (5*10**6).times do
        loop do
            a = (a * AFACTOR) % 2147483647
            break if a % 4 == 0
        end

        loop do
            b = (b * BFACTOR) % 2147483647
            break if b % 8 == 0
        end

        if (a % 2**16) == (b % 2** 16)
            matches += 1
        end
    end
    return matches
end

p count_matches 516, 190
p count_matches2 516, 190

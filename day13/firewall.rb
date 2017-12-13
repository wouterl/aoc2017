sentries = {}

File.open(ARGV[0]).each do |line| 
  depth, range = line.split(": ").map { |i| i.to_i }
  sentries[depth] = range
end

# 0 1 2 3 2 1 0 (for range 4)
# 0 1 2 3 4 5 0 ( so we compute mod 6)

# 0 1 2 3 4 3 2 1 0 (for range 5) 2*r - 1 items
# 0 1 2 3 4 5 6 7 0 ( so we compute mod 8) 2*(r - 1)

p sentries

def advance_sentries steps, sentry_pos, sentries
  sentries.keys.each do |k| 
    sentry_pos[k] = (sentry_pos[k] + steps) % (2*(sentries[k] - 1))
  end

  return sentry_pos
end

def traversal_cost start, sentries
  depth = sentries.keys.max
  severity = 0
  caught = false

  sentry_pos = {}
  sentries.keys.each do |k|
    sentry_pos[k] = k
  end
  sentry_pos = advance_sentries start, sentry_pos, sentries

  caught_positions = sentry_pos.values.select { |v| v == 0 }
  caught = caught_positions.length != 0
  
  sentry_pos.each do |k, v|
    if v == 0
      severity += k * sentries[k]
    end
  end 

  return severity, caught
end

puts "Cost starting at 0: #{traversal_cost 0, sentries}"

wait = -1
caught = true
print "Finding wait time"
while caught
  wait += 1

  cost, caught = traversal_cost wait, sentries
  if wait > 0 && wait % 10000 == 0
    print "."
  end
end
puts " DONE."

puts "When waiting #{wait} picoseconds, you are never caught"

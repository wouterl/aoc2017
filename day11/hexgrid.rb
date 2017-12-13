def getPositionSequence movements
  seq = []
  x = 0
  y = 0
  seq.push [x,y]

  movements.each do |m|
    case m
    when "n"
      y += 1
    when "s"
      y -= 1
    when "ne"
      x += 1
      y += 1
    when "se"
      x += 1
    when "nw"
      x -= 1
    when "sw"
      x -= 1
      y -= 1
    end

    seq.push [x,y]
  end

  return seq
end

def getPosition movements
  getPositionSequence(movements).last
end

def distance pos
  # compute distance from origin
  steps = 0

  x, y = pos
  cx, cy = [0,0]

  steps += x.abs

  # moving to right
  if x >= 0
    if y >= 0 && y <= steps
      # We can get there by taking the right turns
      return steps
    elsif y >= 0 && y > steps
      return steps + (y - steps)
    else # y < 0
      return steps + y.abs
    end
  else 
    # moving to left
    if y <= 0 && -y <= steps
      # We can get there by taking the right turns
      return steps
    elsif y <= 0 && -y > steps
      return steps + (-y - steps)
    else # y > 0
      return steps + y
    end
  end
end

File.open("hexgrid.in").each do |line|
  input = line.chop.split(",")
  pos = getPosition input
  puts "Final position: #{pos}"
  puts "Shortest distance to end: #{distance pos}"

  maxDistance = getPositionSequence(input).map { |p| distance p }.max
  puts "Maximum distance: #{maxDistance}"
end

instructions = []
File.open(ARGV[0]).each do |line|
  puts line
  instructions.push line
end

registers = instructions.map { |l| l.split(" ").first }.sort.uniq
p registers

# initialize registers
reg = {}
registers.each do |r|
  reg[r] = 0
end

max_during = 0
instructions.each do |instr|
  r, cmdstr, amount, *condition = instr.split(" ")

  cmd = ""
  if cmdstr == "inc"
    cmd = "+="
  elsif cmdstr == "dec"
    cmd = "-="
  else
    puts "ERROR: unknown command #{cmdstr}"
  end

  condition[1] = "reg[\"#{condition[1]}\"]"

  evalstr = "reg[\"#{r}\"] #{cmd} #{amount} #{condition.join(" ")}"
  eval evalstr

  # updating running maximum
  curr_max = reg.values.max
  max_during = curr_max if curr_max > max_during
end
p reg

puts "Maximum register value: #{reg.values.max}"
puts "Maximum register value during execution: #{max_during}"

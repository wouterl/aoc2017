def hash_step list, lengths, pos, skip
  len = list.length

  lengths.each do |l|
    # get sublist
    sublist = (list + list)[pos...(pos + l)]
    sublist.reverse!

    # write sublist
    list[pos..(pos + l - 1)] = sublist

    if list.length > len
      tail = list[len..-1]
      list = list[0...len]
      list[0...tail.length] = tail
    end

    # update indices
    pos += l + skip
    pos = pos % list.length
    skip += 1
  end

  return list, pos, skip
end

SUFFIX = [17, 31, 73, 47, 23]

def to_input(str)
  str.split("").map{ |c| c.ord } + SUFFIX
end

def sparse_hash(str)
  lengths = to_input str

  pos = 0
  skip = 0
  list = (0..255).to_a
  64.times do
    list, pos, skip = hash_step list, lengths, pos, skip
  end

  return list
end

def dense_hash str
  perm = sparse_hash str

  res = ""
  while perm.length > 0
    chunk = perm.take(16)

    s = chunk.inject(0) { |e,s| e = e^s }
    res += sprintf("%02x", s)
    perm = perm.drop(16)
  end

  return res
end

File.open(ARGV[0]).each do |line|
  p dense_hash line.chop
end

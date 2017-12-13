def compute_hash list, lengths
  p list
  p lengths

  pos = 0
  skip = 0
  len = list.length

  lengths.each do |l|
    # get sublist
    sublist = (list + list)[pos...(pos + l)]
    p sublist
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

  return list[0] * list[1]
end

File.open(ARGV[1]).each do |line|
  max_idx = ARGV[0].to_i - 1
  list = (0..max_idx).to_a
  lengths = line.split(",").map { |s| s.to_i }
  p compute_hash list, lengths
end

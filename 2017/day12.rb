#
#
# Tree traversal
#

pipes = []
File.open('./day12_input.txt').readlines.each do |line|
  p, ps = line.split(' <-> ')
  connected = ps.split(',').map(&:strip).map(&:to_i)
  pipes[p.to_i] ||= []
  pipes[p.to_i] += connected
  connected.each do |sp|
    pipes[sp] ||= []
    pipes[sp].push p.to_i
  end
end

pipes = pipes.map(&:uniq)

def connected?(pipes, from:, to: 0, seen: { 0 => true }, chain: [])
  return seen[from] if seen.key? from
  return seen[from] = false if chain.include? from

  chain.push from

  pipes[from].each do |program|
    sub_connected = connected?(pipes,
                               from: program, to: to,
                               seen: seen, chain: chain)
    return seen[from] = true if sub_connected
  end
  chain.pop from
  seen[from] = false
end

seen = { 0 => true }
count = pipes.each_with_index.select do |_, program|
  result = connected?(pipes, from: program, seen: seen)
  result
end.size

puts count

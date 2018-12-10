#

instructions = File.open('./day5_ji.txt').readlines.map do |line|
  line.chomp.to_i
end

ip = 0
size = instructions.size
steps = 0

while !ip.negative? && ip < size
  jumps = instructions[ip]
  instructions[ip] += 1
  ip += jumps
  steps += 1
end

puts steps

instructions = File.open('./day5_ji.txt').readlines.map do |line|
  line.chomp.to_i
end

ip = 0
size = instructions.size
steps = 0

while !ip.negative? && ip < size
  jumps = instructions[ip]
  instructions[ip] += if jumps > 2
                        -1
                      else
                        1
                      end
  ip += jumps
  steps += 1
end

puts steps

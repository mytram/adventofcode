banks = [0, 5, 10, 0, 11, 14, 13, 4, 11, 8, 8, 7, 1, 4, 12, 11]

def seen_again(banks, times = 1)
  banks = [*banks]
  configs = { banks.join('.') => true }

  steps = 0
  seen = 0

  loop do
    steps += 1

    # m, i = banks.each_with_index.max
    m = banks.max
    i = banks.index(m)

    banks[i] = 0
    next_bank = i
    m.times do
      next_bank += 1
      next_bank = 0 if next_bank == banks.size
      banks[next_bank] += 1
    end

    config = banks.join('.')
    if configs.key? config
      seen += 1
      return steps if seen == times
      steps = 0
      configs = {}
    end
    configs[config] = true
  end
end

steps = seen_again banks
puts steps
steps = seen_again(banks, 2)
puts steps

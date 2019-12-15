# --- Day 4: Secure Container ---

# You arrive at the Venus fuel depot only to discover it's protected
# by a password. The Elves had written the password on a sticky note,
# but someone threw it out.

# However, they do remember a few key facts about the password:

# It is a six-digit number.
# The value is within the range given in your puzzle input.
# Two adjacent digits are the same (like 22 in 122345).
# Going from left to right, the digits never decrease; they only ever
# increase or stay the same (like 111123 or 135679).

# Other than the range rule, the following are true:

# 111111 meets these criteria (double 11, never decreases).
# 223450 does not meet these criteria (decreasing pair of digits 50).
# 123789 does not meet these criteria (no double).

# How many different passwords within the range given in your puzzle
# input meet these criteria?

# Your puzzle input is 254032-789860

def check_rule?(number)
  digits = number.to_s.chars.map(&:to_i)

  rule1 = (1...digits.size).all? do |i|
    digits[i] >= digits[i - 1]
  end

  rule2 = (1...digits.size).any? do |i|
    digits[i] == digits[i - 1]
  end

  rule1 && rule2
end

def check_repeat_rule?(digits)
  counts = {}

  digits.each do |d|
    counts[d] ||= 0
    counts[d] += 1
  end

  counts.reject! { |_, v| v < 2 }

  max_key = counts.keys.max

  counts[max_key] == 2
end

def check_full_rule?(number)
  digits = number.to_s.chars.map(&:to_i)

  rule1 = (1...digits.size).all? do |i|
    digits[i] >= digits[i - 1]
  end

  rule2 = (1...digits.size).any? do |i|
    digits[i] == digits[i - 1]
  end

  rule1 && rule2 && check_repeat_rule?(digits)
end


puts (254032..789860).filter { |number| check_rule?(number) }.size

puts (254032..789860).filter { |number| check_full_rule?(number) }.size

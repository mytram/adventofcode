def valid_passphrase?(phrase)
  words = phrase.split
  words.size == words.uniq.size
end

count = File.open('./day4_passphrases.txt').readlines.select do |line|
  valid_passphrase? line
end.size

puts count

def valid_no_anagrams?(phrase)
  words = phrase.split.map(&:chars).map(&:sort)
  words.size == words.uniq.size
end

count = File.open('./day4_passphrases.txt').readlines.select do |line|
  valid_no_anagrams? line
end.size

puts count

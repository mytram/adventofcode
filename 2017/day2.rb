def spreadsheet_checksum(data)
  data.map { |row| row.max - row.min }.reduce(&:+)
end

data = File.open('./day2_spreadsheet.txt').readlines.map do |line|
  line.split.map(&:to_i)
end

puts spreadsheet_checksum(data)

# Part 2
def find_evenly_divisible_numbers(row)
  row = row.sort
  size = row.size
  row.each_with_index do |number, i|
    next if number.zero?

    row[(i + 1)...size].each do |other_number|
      return [number, other_number] if (other_number % number).zero?
    end
  end
end

sum = data.map do |row|
  divisor, dividend = find_evenly_divisible_numbers(row)
  dividend / divisor
end.reduce(&:+)

puts sum

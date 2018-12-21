require './lib/solver'

maker = Day14Solver::RecipeMaker.new
puts maker.display.inspect

maker.generate

while maker.number_of_recipes < (2018 + 20)
  maker.generate
end

# assert maker.display, [3,7,1,0,1,0,1,2,4,5,1,5,8,9,1,6,7,7,9,2]

assert maker.recipes[5...15].join, '0124515891'
assert maker.recipes[9...19].join, '5158916779'
assert maker.recipes[2018...2028].join, '5941429882'


while maker.number_of_recipes < (430971 + 20)
  maker.generate
end

puts maker.recipes[430971...(430971 + 10)].join


maker = Day14Solver::RecipeMaker.new
10.times { maker.generate }

last_10 = maker.recipes[-10..-1]

loop do
  new_recipes = maker.generate
  check = last_10 + new_recipes

  # puts check.inspect
  # break if /508216/.match(check.join)
  break if /430971/.match(check.join)

  last_10 = check[-10..-1]
end

x, = maker.recipes.join.split('430971')

# x, = maker.recipes.join.split('508216')

# puts maker.recipes.join

puts x.size

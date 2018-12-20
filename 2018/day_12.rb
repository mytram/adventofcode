require './lib/solver'

initial_state = '#..#.#..##......###...###'

recipe = {
  '...##'.chars => '#',
  '..#..'.chars => '#',
  '.#...'.chars => '#',
  '.#.#.'.chars => '#',
  '.#.##'.chars => '#',
  '.##..'.chars => '#',
  '.####'.chars => '#',
  '#.#.#'.chars => '#',
  '#.###'.chars => '#',
  '##.#.'.chars => '#',
  '##.##'.chars => '#',
  '###..'.chars => '#',
  '###.#'.chars => '#',
  '####.'.chars => '#'
}

plantation = Day12Solver::Plantation.new(
  initial_state: initial_state,
  recipe: recipe
)

plants_by_generation = [
  '...#..#.#..##......###...###...........',
  '...#...#....#.....#..#..#..#...........',
  '...##..##...##....#..#..#..##..........',
  '..#.#...#..#.#....#..#..#...#..........',
  '...#.#..#...#.#...#..#..##..##.........',
  '....#...##...#.#..#..#...#...#.........',
  '....##.#.#....#...#..##..##..##........',
  '...#..###.#...##..#...#...#...#........',
  '...#....##.#.#.#..##..##..##..##.......',
  '...##..#..#####....#...#...#...#.......',
  '..#.#..#...#.##....##..##..##..##......',
  '...#...##...#.#...#.#...#...#...#......',
  '...##.#.#....#.#...#.#..##..##..##.....',
  '..#..###.#....#.#...#....#...#...#.....',
  '..#....##.#....#.#..##...##..##..##....',
  '..##..#..#.#....#....#..#.#...#...#....',
  '.#.#..#...#.#...##...#...#.#..##..##...',
  '..#...##...#.#.#.#...##...#....#...#...',
  '..##.#.#....#####.#.#.#...##...##..##..',
  '.#..###.#..#.#.#######.#.#.#..#.#...#..',
  '.#....##....#####...#######....#.#..##.',
]

new_gen = plantation.plants.gsub('.', ' ').strip.gsub(' ', '.')
assert new_gen, plants_by_generation[0].gsub('.', ' ').strip.gsub(' ', '.')

plants_by_generation[1..-1].each_with_index.map do |plants, i|
  plantation.spawn
  new_gen = plantation.plants.gsub('.', ' ').strip.gsub(' ', '.')
  assert new_gen, plants.gsub('.', ' ').strip.gsub(' ', '.')
end

assert plantation.sum_of_plant_pots, 325

solver = Day12Solver.new
assert solver.initial_state, '####....#...######.###.#...##....#.###.#.###.......###.##..##........##..#.#.#..##.##...####.#..##.#'

# ["#", "#", ".", ".", "#"]=>"."
assert solver.recipe.size, 32
assert solver.recipe.fetch('###..'.chars), '.'
assert solver.call(20), 2063

solver = Day12Solver.new
puts solver.call(50000000000)

__END__

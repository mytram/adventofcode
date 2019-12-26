"""Advent of code 2019 day24"""

BUG = '#'
SPACE = '.'
RECURSION = '?'

UP = 'up'
RIGHT = 'right'
DOWN = 'down'
LEFT = 'left'

UP_INDEX = 0
RIGHT_INDEX = 1
DOWN_INDEX = 2
LEFT_INDEX = 3

def tile_positions(x_size, y_size):
    '''Generate a list of tile positions'''
    return tuple((x, y) for x in range(x_size) for y in range(y_size))

def make_grid(x_size, y_size, element=None):
    '''Make a  grid'''
    return [[element] * y_size for _ in range(x_size)]

class BugWorldGrid:
    """A bug world"s grid"""
    def __init__(self, grid):
        self.grid = [list(_) for _ in grid]

        self.x_size = len(grid)
        self.y_size = len(grid[0])

        self.middle = int(self.x_size / 2), int(self.y_size / 2)

        x, y = self.middle

        self.around_middle_positions = (
            (x - 1, y), # up
            (x, y + 1), # right
            (x + 1, y), # down
            (x, y - 1)  # left
        )

        self.tile_positions = tile_positions(self.x_size, self.y_size)

        self.bioratings = self._init_bioratings()

    def new_grid(self):
        return BugWorldGrid(
            [[SPACE] * self.y_size for _ in range(self.x_size)]
        )

    @property
    def top_side_tiles(self):
        return (self.grid[0][y] for y in range(self.y_size))

    @property
    def right_side_tiles(self):
        y_max = self.y_size - 1
        return (self.grid[x][y_max] for x in range(self.x_size))

    @property
    def bottom_side_tiles(self):
        x_max = self.x_size - 1
        return (self.grid[x_max][y] for y in range(self.y_size))

    @property
    def left_side_tiles(self):
        return (self.grid[x][0] for x in range(self.x_size))

    @property
    def count(self):
        return len([True for x, y in self.tile_positions if self.grid[x][y] == BUG])

    def display(self):
        for row in self.grid:
            print(''.join(str(e) for e in row))

    def is_bug_at(self, tile_x, tile_y):
        if self.is_out_of_bound(tile_x, tile_y):
            return False

        return self.grid[tile_x][tile_y] == BUG

    def is_out_of_bound(self, tile_x, tile_y):
        return tile_x < 0 or tile_x >= self.x_size or tile_y < 0 or tile_y >= self.y_size

    def is_space_at(self, tile_x, tile_y):
        if self.is_out_of_bound(tile_x, tile_y):
            return True

        return self.grid[tile_x][tile_y] == SPACE

    def get_tile(self, x, y):
        return self.grid[x][y]

    def set_bug(self, tile_x, tile_y):
        self.grid[tile_x][tile_y] = BUG

    def set_space(self, tile_x, tile_y):
        self.grid[tile_x][tile_y] = SPACE

    def update(self, dead_bugs=[], born_bugs=[]):
        for position in dead_bugs:
            self.set_space(*position)

        for position in born_bugs:
            self.set_bug(*position)

    def get_grid(self):
        return tuple(tuple(self.grid[x]) for x in range(self.x_size))

    def biorating(self):
        '''current biorating'''
        rating = 0
        for tile in self.tile_positions:
            if self.is_space_at(*tile):
                continue
            rating += self.bioratings[tile[0]][tile[1]]
        return rating

    def _init_bioratings(self):
        ratings = make_grid(self.x_size, self.y_size)

        power = 0
        for (tile_x, tile_y) in self.tile_positions:
            ratings[tile_x][tile_y] = 2 ** power
            power += 1

        return tuple(tuple(_) for _ in ratings)

class BugWorld:
    '''A bug's world'''
    def __init__(self, grid, level=0, recursive=False, higher_world=None, lower_world=None):
        self.level = level

        self.grid = grid

        # Set up worlds
        self.recursive = recursive

        self.higher_world = higher_world
        self.lower_world = lower_world

        self.recursion_position = self.grid.middle
        self.recursion_surrounding_positions = self.grid.around_middle_positions

    @property
    def is_higher_world(self):
        return self.level < 0

    @property
    def is_lower_world(self):
        return self.level > 0

    def count_of_bugs(self):
        count = self.grid.count

        if not self.is_lower_world and self.higher_world:
            count += self.higher_world.count_of_bugs()

        if not self.is_higher_world and self.lower_world:
            count += self.lower_world.count_of_bugs()

        return count

    def display(self):
        if self.level <= 0 and self.higher_world:
            self.higher_world.display()

        print('Level %d' % self.level)

        self.grid.display()

        if self.level >= 0 and self.lower_world:
            self.lower_world.display()

    def simulate(self):
        '''simulate one step'''

        dead_bugs, born_bugs = self._die_or_beget()

        if self.recursive:
            self._simulate_higher_world()
            self._simulate_lower_world()

        self.grid.update(dead_bugs=dead_bugs, born_bugs=born_bugs)

    def _has_effect_on_higher_world(self):
        if BUG in self.grid.bottom_side_tiles:
            return True
        if BUG in self.grid.top_side_tiles:
            return True
        if BUG in self.grid.right_side_tiles:
            return True
        if BUG in self.grid.left_side_tiles:
            return True

        return False

    def _has_effect_on_lower_world(self):
        for position in self.recursion_surrounding_positions:
            if self.grid.is_bug_at(*position):
                return True
        return False

    def _simulate_higher_world(self):
        if self.is_lower_world:
            return

        if self._has_effect_on_higher_world() and self.higher_world is None:
            self.higher_world = self._create_higher_world()

        if self.higher_world:
            self.higher_world.simulate()

    def _create_higher_world(self):
        return BugWorld(
            self.grid.new_grid(),
            level=self.level - 1,
            recursive=True,
            higher_world=None,
            lower_world=self # circular reference
        )

    def _simulate_lower_world(self):
        if self.is_higher_world:
            return

        if self._has_effect_on_lower_world() and self.lower_world is None:
            self.lower_world = self._create_lower_world()

        if self.lower_world:
            self.lower_world.simulate()

    def _create_lower_world(self):
        return BugWorld(
            self.grid.new_grid(),
            level=self.level + 1,
            recursive=True,
            higher_world=self, # circular reference
            lower_world=None
        )

    def _adjacent_tiles(self, tile_x, tile_y):
        return (
            e for tiles in (
                self._adjacent_tiles_at(tile_x - 1, tile_y, UP),
                self._adjacent_tiles_at(tile_x, tile_y + 1, RIGHT),
                self._adjacent_tiles_at(tile_x + 1, tile_y, DOWN),
                self._adjacent_tiles_at(tile_x, tile_y - 1, LEFT)
            ) for e in tiles
        )

    def _adjacent_tiles_at(self, tile_x, tile_y, direction):
        if self.recursive:
            return self._recursive_adjacent_tiles_at(tile_x, tile_y, direction)

        if self.grid.is_space_at(tile_x, tile_y):
            return (SPACE, )
        return (BUG, )

    def _recursive_adjacent_tiles_at(self, tile_x, tile_y, direction):
        if self.grid.is_out_of_bound(tile_x, tile_y):
            return self._adjacent_tiles_at_recursion_position(self.higher_world,
                                                              direction)

        if (tile_x, tile_y) == self.recursion_position:
            return self._adjacent_tiles_at_one_side(self.lower_world, direction)

        return (self.grid.get_tile(tile_x, tile_y), )

    def _adjacent_tiles_at_recursion_position(self, other_world, direction):
        if other_world is None:
            return ()

        tile_x, tile_y = (None, None)
        if direction == UP:
            tile_x, tile_y = self.recursion_surrounding_positions[UP_INDEX]
        elif direction == RIGHT:
            tile_x, tile_y = self.recursion_surrounding_positions[RIGHT_INDEX]
        elif direction == DOWN:
            tile_x, tile_y = self.recursion_surrounding_positions[DOWN_INDEX]
        elif direction == LEFT:
            tile_x, tile_y = self.recursion_surrounding_positions[LEFT_INDEX]
        else:
            raise 'should not be here'

        return (other_world.grid.get_tile(tile_x, tile_y), )

    def _adjacent_tiles_at_one_side(self, other_world, direction):
        if other_world is None:
            return ()

        if direction == UP: # enter the lower world when going up
            return other_world.grid.bottom_side_tiles
        if direction == DOWN:
            return other_world.grid.top_side_tiles
        if direction == LEFT:
            return other_world.grid.right_side_tiles
        if direction == RIGHT:
            return other_world.grid.left_side_tiles

        raise 'should not be here'

    def _is_subworld_at(self, tile_x, tile_y):
        return self.recursive and (tile_x, tile_y) == self.recursion_position

    def _die_or_beget(self):
        dead_bugs, born_bugs = [], []

        for tile in self.grid.tile_positions:
            if self._is_subworld_at(*tile):
                continue

            tiles = self._adjacent_tiles(*tile)

            count_of_bugs = self._count_of_bugs(tiles)

            if self.grid.is_space_at(*tile):
                if count_of_bugs in (1, 2):
                    born_bugs.append(tile)
            else: # is_bug_at
                if count_of_bugs != 1:
                    dead_bugs.append(tile)

        return tuple(dead_bugs), tuple(born_bugs)

    def _count_of_bugs(self, tiles):
        return sum(1 for t in tiles if t == '#')

class BugsLife:
    '''A bug's life sim'''
    def __init__(self, world, recursive=False):
        self.bug_world = BugWorld(
            BugWorldGrid(world),
            level=0,
            recursive=recursive
        )

    def run(self, minutes=1):
        '''Run the simulation for a given number of minutes'''
        for _ in range(minutes):
            self.bug_world.simulate()

        return self.bug_world.grid.get_grid()

    def biorating(self):
        '''biorating'''
        return self.bug_world.grid.biorating()

def verify_bugslife():
    '''verify bugslife'''
    initial_world = (
        '....#',
        '#..#.',
        '#..##',
        '..#..',
        '#....'
    )

    current_world = BugsLife(initial_world).run(4)

    for row in current_world:
        print(''.join(row))

    expected_world = tuple(tuple(_) for _ in (
        '####.',
        '....#',
        '##..#',
        '.....',
        '##...',
    ))

    assert expected_world == current_world

def verify_biorating():
    '''verify biorating'''
    initial_world = (
        '.....',
        '.....',
        '.....',
        '#....',
        '.#...',
    )

    biorating = BugsLife(initial_world).biorating()

    assert biorating == 2129920

class Solver:
    '''Day 24 solver'''
    def __init__(self):
        self.world = (
            '..##.',
            '..#..',
            '##...',
            '#....',
            '...##'
        )

    def solve_a(self):
        '''part a'''
        life = BugsLife(self.world)
        seen_grids = []

        while life.run() not in seen_grids:
            seen_grids.append(life.bug_world.grid.get_grid())

        return life.biorating()

    def solve_b(self, world=None, minutes=200):
        '''part b'''
        life = BugsLife(world or self.world, recursive=True)

        life.run(minutes)

        return life.bug_world.count_of_bugs()

verify_bugslife()
verify_biorating()

if __name__ == '__main__':
    result = Solver().solve_a()

    print('part a %d' % result)
    assert result == 28903899
    a_grid = (
        '....#',
        '#..#.',
        '#..##',
        '..#..',
        '#....'
    )
    result = Solver().solve_b(a_grid, minutes=10)
    assert result == 99

    result = Solver().solve_b()
    assert result == 1896
    print('part b %d' % result)

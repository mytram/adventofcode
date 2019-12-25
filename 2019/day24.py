BUG = "#"
SPACE = "."

def tile_positions(x_size, y_size):
    """Generate a list of tile positions"""
    return tuple((x, y) for x in range(x_size) for y in range(y_size))

def make_grid(x_size, y_size, element=None):
    """Make a  grid"""
    return list([None] * y_size for _ in range(x_size))

class BugWorld:
    """A bug's world"""
    def __init__(self, grid):
        grid = [list(_) for _ in grid]

        self.x_size = len(grid)
        self.y_size = len(grid[0])

        self.tile_positions = tile_positions(self.x_size, self.y_size)
        self.grid = grid
        self.bioratings = self.__init_bioratings()

        self.current_grid = self.__clone_grid(self.grid)

    def biorating(self):
        """current biorating"""
        rating = 0
        for tile in self.tile_positions:
            if self.__is_space_at(*tile):
                continue
            rating += self.bioratings[tile[0]][tile[1]]
        return rating

    def simulate(self):
        """simulate one step"""

        dead_bugs, born_bugs = self.__die_or_beget()

        for (tile_x, tile_y) in dead_bugs:
            self.grid[tile_x][tile_y] = SPACE

        for (tile_x, tile_y) in born_bugs:
            self.grid[tile_x][tile_y] = BUG

        self.current_grid = self.__clone_grid(self.grid)

    def __adjacent_tiles(self, tile_x, tile_y):
        return tuple(
            e for tiles in
            (
                self.get_tiles(tile_x - 1, tile_y),
                self.get_tiles(tile_x, tile_y + 1),
                self.get_tiles(tile_x + 1, tile_y),
                self.get_tiles(tile_x, tile_y - 1)
            ) for e in tiles
        )

    def get_tiles(self, tile_x, tile_y):
        if self.__is_space_at(tile_x, tile_y):
            return (SPACE)
        return (BUG)

    def get_up_tiles(self):
        return tuple(self.current_grid[0][y] for y in range(self.y_size))

    def get_right_tiles(self):
        y_max = self.y_size - 1
        return tuple(self.current_grid[x][y_max] for x in range(self.x_size))

    def get_down_tiles(self):
        x_max = self.x_size - 1
        return tuple(self.current_grid[x_max][y] for y in range(self.y_size))

    def get_left_tiles(self):
        return tuple(self.current_grid[x][0] for x in range(self.x_size))

    def __init_bioratings(self):
        ratings = make_grid(self.x_size, self.y_size)

        power = 0
        for (tile_x, tile_y) in self.tile_positions:
            ratings[tile_x][tile_y] = 2 ** power
            power += 1

        return tuple(tuple(_) for _ in ratings)

    def __clone_grid(self, grid):
        return tuple([tuple(grid[x]) for x in range(self.x_size)])

    def __die_or_beget(self):
        dead_bugs, born_bugs = [], []

        for tile in self.tile_positions:
            count_of_bugs = self.__count_of_bugs(
                self.__adjacent_tiles(*tile)
            )

            if self.__is_space_at(*tile):
                if count_of_bugs in (1, 2):
                    born_bugs.append(tile)
            else: # is_bug_at
                if count_of_bugs != 1:
                    dead_bugs.append(tile)

        return (tuple(dead_bugs), tuple(born_bugs))

    def __count_of_bugs(self, tiles):
        return len([True for t in tiles if t == "#"])

    def __is_bug_at(self, tile_x, tile_y):
        return not self.__is_space_at(tile_x, tile_y)

    def __is_space_at(self, tile_x, tile_y):
        if tile_x < 0 or tile_x >= self.x_size or tile_y < 0 or tile_y >= self.y_size:
            return True

        return self.grid[tile_x][tile_y] == "."

class BugsLife:
    """A bug's life sim"""
    def __init__(self, world):
        self.bug_world = BugWorld(world)

    def run(self, minutes=1):
        """Run the simulation for a given number of minutes"""
        for _ in range(minutes):
            self.bug_world.simulate()

        return self.bug_world.current_grid

    def biorating(self):
        """biorating"""
        return self.bug_world.biorating()

def verify_bugslife():
    """verify bugslife"""
    initial_world = (
        "....#",
        "#..#.",
        "#..##",
        "..#..",
        "#...."
    )

    current_world = BugsLife(initial_world).run(4)

    for row in current_world:
        print("".join(row))

    expected_world = tuple(tuple(_) for _ in (
        "####.",
        "....#",
        "##..#",
        ".....",
        "##...",
    ))

    assert expected_world == current_world

def verify_biorating():
    """verify biorating"""
    initial_world = (
        ".....",
        ".....",
        ".....",
        "#....",
        ".#...",
    )

    biorating = BugsLife(initial_world).biorating()

    assert biorating == 2129920

class Solver:
    """Day 24 solver"""
    def __init__(self):
        self.world = (
            "..##.",
            "..#..",
            "##...",
            "#....",
            "...##"
        )

    def solve_a(self):
        """part a"""
        life = BugsLife(self.world)
        seen_grids = []

        while life.run() not in seen_grids:
            seen_grids.append(life.bug_world.current_grid)

        return life.biorating()

    def solve_b(self):
        """part b"""

verify_bugslife()
verify_biorating()

if __name__ == "__main__":
    result = Solver().solve_a()

    print("part a %d" % result)
    assert result == 28903899

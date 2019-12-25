class BugWorld:
    """A bug's world"""
    def __init__(self, grid):
        grid = [list(_) for _ in grid]

        self.tile_x_size = len(grid)
        self.tile_y_size = len(grid[0])

        self.tiles = self.__set_tiles()
        self.grid = grid
        self.bioratings = self.__init_bioratings()

        self.current_grid = self.__clone_grid(self.grid)

    def biorating(self):
        """current biorating"""
        rating = 0
        for tile in self.tiles:
            if self.__is_bug(*tile):
                rating += self.bioratings[tile[0]][tile[1]]
        return rating

    def __adjacent_tiles(self, tile_x, tile_y):
        return (
            (tile_x - 1, tile_y),
            (tile_x, tile_y + 1),
            (tile_x + 1, tile_y),
            (tile_x, tile_y - 1)
        )

    def __set_tiles(self):
        return tuple((x, y) for x in range(self.tile_x_size) for y in range(self.tile_y_size))

    def __init_bioratings(self):
        ratings = tuple(
            [None] * self.tile_y_size for _ in range(self.tile_x_size)
        )
        power = 0
        for (tile_x, tile_y) in self.tiles:
            ratings[tile_x][tile_y] = 2 ** power
            power += 1

        return tuple(tuple(_) for _ in ratings)

    def __clone_grid(self, grid):
        return tuple([tuple(grid[x]) for x in range(self.tile_x_size)])

    def __die_or_beget(self):
        dead_bugs, born_bugs = [], []

        for tile in self.tiles:
            count_of_bugs = self.__count_of_bugs(
                self.__adjacent_tiles(*tile)
            )

            if self.__is_space(*tile):
                if count_of_bugs in (1, 2):
                    born_bugs.append(tile)
            else: # is_bug
                if count_of_bugs != 1:
                    dead_bugs.append(tile)

        return (tuple(dead_bugs), tuple(born_bugs))

    def simulate(self):
        """simulate one step"""

        dead_bugs, born_bugs = self.__die_or_beget()

        for (tile_x, tile_y) in dead_bugs:
            self.grid[tile_x][tile_y] = "."

        for (tile_x, tile_y) in born_bugs:
            self.grid[tile_x][tile_y] = "#"

        self.current_grid = self.__clone_grid(self.grid)

    def __count_of_bugs(self, tiles):
        return len([True for t in tiles if not self.__is_space(*t)])

    def __is_bug(self, tile_x, tile_y):
        return not self.__is_space(tile_x, tile_y)

    def __is_space(self, tile_x, tile_y):
        if tile_x < 0 or tile_x >= self.tile_x_size or tile_y < 0 or tile_y >= self.tile_y_size:
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

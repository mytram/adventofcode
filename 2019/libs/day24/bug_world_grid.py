"""BugWorldGrid"""

from .constants import SPACE, BUG

class BugWorldGrid:
    """A bug world"s grid"""
    def __init__(self, data):
        self.grid = [list(_) for _ in data]

        self.x_size = len(self.grid)
        self.y_size = len(self.grid[0])

        self.tile_positions = tuple((x, y) for x in range(self.x_size) for y in range(self.y_size))

        self.middle = int(self.x_size / 2), int(self.y_size / 2)

        self.bioratings = self._init_bioratings()

        self._update_properties()

    def new_grid(self):
        return BugWorldGrid([[SPACE] * self.y_size for _ in range(self.x_size)])

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

    def get_top_tile_of(self, tile_x, tile_y):
        return self.get_tile(tile_x - 1, tile_y)

    def get_bottom_tile_of(self, tile_x, tile_y):
        return self.get_tile(tile_x + 1, tile_y)

    def get_left_tile_of(self, tile_x, tile_y):
        return self.get_tile(tile_x, tile_y - 1)

    def get_right_tile_of(self, tile_x, tile_y):
        return self.get_tile(tile_x, tile_y + 1)

    def is_out_of_bound(self, tile_x, tile_y):
        return tile_x < 0 or tile_x >= self.x_size or tile_y < 0 or tile_y >= self.y_size

    def is_bug_at(self, tile_x, tile_y):
        if self.is_out_of_bound(tile_x, tile_y):
            return False

        return self.grid[tile_x][tile_y] == BUG

    def is_space_at(self, tile_x, tile_y):
        if self.is_out_of_bound(tile_x, tile_y):
            return True

        return self.grid[tile_x][tile_y] == SPACE

    def get_tile(self, x, y):
        if self.is_out_of_bound(x, y):
            return SPACE
        return self.grid[x][y]

    def update(self, dead_bugs=[], born_bugs=[]):
        """dead or born"""
        for position in dead_bugs:
            self._set_space(*position)

        for position in born_bugs:
            self._set_bug(*position)

        self._update_properties()

    def display(self):
        """Display grid"""
        for row in self.grid:
            print(''.join(str(e) for e in row))

    def biorating(self):
        '''current biorating'''
        rating = 0
        for tile in self.tile_positions:
            if self.is_space_at(*tile):
                continue
            rating += self.bioratings[tile[0]][tile[1]]
        return rating

    def _init_bioratings(self):
        ratings = [[SPACE] * self.y_size for _ in range(self.x_size)]

        power = 0
        for (tile_x, tile_y) in self.tile_positions:
            ratings[tile_x][tile_y] = 2 ** power
            power += 1

        return tuple(tuple(_) for _ in ratings)

    def _update_properties(self):
        self.number_of_bugs = sum(1 for x, y in self.tile_positions if self.grid[x][y] == BUG)
        self.current_grid = tuple(tuple(self.grid[x]) for x in range(self.x_size))

    def _set_bug(self, tile_x, tile_y):
        if self.is_out_of_bound(tile_x, tile_y):
            return
        self.grid[tile_x][tile_y] = BUG

    def _set_space(self, tile_x, tile_y):
        if self.is_out_of_bound(tile_x, tile_y):
            return

        self.grid[tile_x][tile_y] = SPACE

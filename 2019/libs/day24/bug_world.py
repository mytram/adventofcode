"""BugWorld"""

from .constants import UP, DOWN, RIGHT, LEFT, BUG

def count_bugs(tiles):
    """Number of bugs in tiles"""
    return sum(1 for t in tiles if t == BUG)

def adjacent_tiles_at_one_side(bug_world, direction):
    """Return the tiles at one side of the bug world"""
    if bug_world is None:
        return ()

    if direction == UP: # enter the lower world when going up
        return bug_world.grid.bottom_side_tiles

    if direction == DOWN:
        return bug_world.grid.top_side_tiles

    if direction == LEFT:
        return bug_world.grid.right_side_tiles

    if direction == RIGHT:
        return bug_world.grid.left_side_tiles

    raise 'should not be here'

def adjacent_tiles_at_position(bug_world, direction, position):
    """Adjacent tiles at a position"""
    if bug_world is None:
        return ()

    if direction == UP:
        return (bug_world.grid.get_top_tile_of(*position), )

    if direction == RIGHT:
        return (bug_world.grid.get_right_tile_of(*position), )

    if direction == DOWN:
        return (bug_world.grid.get_bottom_tile_of(*position), )

    if direction == LEFT:
        return (bug_world.grid.get_left_tile_of(*position), )

    raise 'should not be here'

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
        self.recursion_surrounding_positions = (
            (self.recursion_position[0] - 1, self.recursion_position[1]),
            (self.recursion_position[0], self.recursion_position[1] + 1),
            (self.recursion_position[0] + 1, self.recursion_position[1]),
            (self.recursion_position[0], self.recursion_position[1] - 1)
        )

    @property
    def is_higher_world(self):
        """True if it's a higher world"""
        return self.level < 0

    @property
    def is_lower_world(self):
        """True if it's a lower world"""
        return self.level > 0

    @property
    def count_of_bugs(self):
        """Return this number of bugs in the world of worlds"""
        count = self.grid.number_of_bugs

        if not self.is_lower_world and self.higher_world:
            count += self.higher_world.count_of_bugs

        if not self.is_higher_world and self.lower_world:
            count += self.lower_world.count_of_bugs

        return count

    def display(self):
        """Display the worlds"""
        if self.level <= 0 and self.higher_world:
            self.higher_world.display()

        print('Level %d' % self.level)

        self.grid.display()

        if self.level >= 0 and self.lower_world:
            self.lower_world.display()

    def simulate(self):
        """simulate one minute of life"""

        dead_bugs, born_bugs = self._die_or_beget()

        if self.recursive:
            self._simulate_higher_world()
            self._simulate_lower_world()

        self.grid.update(dead_bugs=dead_bugs, born_bugs=born_bugs)

    def _has_effect_on_higher_world(self):
        #
        # Can be improved by looping through tiles and short
        # circuiting if a bug is found
        #
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

        return self.grid.get_tile(tile_x, tile_y)

    def _recursive_adjacent_tiles_at(self, tile_x, tile_y, direction):
        if self.grid.is_out_of_bound(tile_x, tile_y):
            return adjacent_tiles_at_position(bug_world=self.higher_world,
                                              direction=direction,
                                              position=self.recursion_position)

        if (tile_x, tile_y) == self.recursion_position:
            return adjacent_tiles_at_one_side(bug_world=self.lower_world,
                                              direction=direction)

        return (self.grid.get_tile(tile_x, tile_y), )

    def _die_or_beget(self):
        dead_bugs, born_bugs = [], []

        positions = self.grid.tile_positions
        if self.recursive:
            positions = (p for p in positions if p != self.recursion_position)

        for position in positions:
            tiles = self._adjacent_tiles(*position)

            number_of_bugs = count_bugs(tiles)

            if self.grid.is_space_at(*position):
                if number_of_bugs in (1, 2):
                    born_bugs.append(position)
            else: # is_bug_at
                if number_of_bugs != 1:
                    dead_bugs.append(position)

        return tuple(dead_bugs), tuple(born_bugs)

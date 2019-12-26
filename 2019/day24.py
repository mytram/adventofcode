"""Advent of code 2019 day24"""

from libs.day24 import BugsLife
from libs.day24 import verify

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
            seen_grids.append(life.bug_world.grid.current_grid)

        return life.biorating()

    def solve_b(self, world=None, minutes=200):
        '''part b'''
        life = BugsLife(world or self.world, recursive=True)

        life.run(minutes)

        return life.bug_world.count_of_bugs

verify.verify_bugslife()
verify.verify_biorating()

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

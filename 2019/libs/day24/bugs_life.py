from .bug_world import BugWorld
from .bug_world_grid import BugWorldGrid

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

        return self.bug_world.grid.current_grid

    def biorating(self):
        '''biorating'''
        return self.bug_world.grid.biorating()

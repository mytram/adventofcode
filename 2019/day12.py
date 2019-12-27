"""day 12"""
import functools
import math
from libs.day12 import Moon

class Solver:
    def solve_a(self, moons, steps):
        for _ in range(steps):
            self._simulate_time_step(moons)

        return sum(moon.energy for moon in moons)

    def solve_b(self, moons):
        x_steps = self._simulate_time_step_on(moons, 'x')
        y_steps = self._simulate_time_step_on(moons, 'y')
        z_steps = self._simulate_time_step_on(moons, 'z')

        # least common multiples

        lcm = (x_steps * y_steps) // math.gcd(x_steps, y_steps)
        return (lcm * z_steps) // math.gcd(lcm, z_steps)

    # private methods
    def _simulate_time_step(self, moons):
        for moon in moons:
            moon.apply_gravity(moons)

        for moon in moons:
            moon.apply_velocity()

    def _get_axis_config(self, moons, axis):
        axis_pos = ".".join(str(m.position[axis]) for m in moons)
        axis_vel = ".".join(str(m.velocity[axis]) for m in moons)

        return f'{axis_pos}-{axis_vel}'

    def _simulate_time_step_on(self, moons, axis):
        steps = 0
        seen = {}

        while True:
            axis_config = self._get_axis_config(moons, axis)

            if axis_config in seen:
                return steps

            seen[axis_config] = True
            steps += 1

            for moon in moons:
                moon.apply_gravity_on(moons, axis)

            for moon in moons:
                moon.apply_velocity_on(axis)

if __name__ == '__main__':
    moons = (
        Moon(name='Io', x=-1, y=0, z=2),
        Moon(name='Europa', x=2, y=-10, z=-7),
        Moon(name='Ganymede', x=4, y=-8, z=8),
        Moon(name='Callisto', x=3, y=5, z=-1)
    )

    # solver = Solver()
    # print(solver.solve_a(moons, 10))

    moons = (
        Moon(name='Io', x=-8, y=-10, z=0),
        Moon(name='Europa', x=5, y=5, z=10),
        Moon(name='Ganymede', x=2, y=-7, z=3),
        Moon(name='Callisto', x=9, y=-8, z=-3)
    )

    # solver=Solver()
    # print(solver.solve_a(moons, 100))

    puzzle_input = (
        Moon(name='Io', x=-10, y=-10, z=-13),
        Moon(name='Europa', x=5, y=5, z=-9),
        Moon(name='Ganymede', x=3, y=8, z=-16),
        Moon(name='Callisto', x=1, y=3, z=-3)
    )

    solver = Solver()
    result = solver.solve_a(puzzle_input, 1000)
    assert result == 6678
    print(f'part a - {result}')

    moons = (
        Moon(name='Io', x=-8, y=-10, z=0),
        Moon(name='Europa', x=5, y=5, z=10),
        Moon(name='Ganymede', x=2, y=-7, z=3),
        Moon(name='Callisto', x=9, y=-8, z=-3)
    )

    result = solver.solve_b(moons)
    assert result == 4686774924

    solver = Solver()
    result = solver.solve_b(puzzle_input)
    print(f'part b - {result}')

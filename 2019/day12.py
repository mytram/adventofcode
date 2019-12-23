#
class Moon:
    def __init__(self, name, x, y, z):
        self.name = name
        self.position = { "x": x, "y": y, "z": z }
        self.velocity = { "x": 0, "y": 0, "z": 0 }

    def apply_gravity(self, moons):
        for axis in ("x", "y", "z"):
            delta = self.__calculate_velocity_delta(moons, axis)
            self.velocity[axis] += delta

    def apply_velocity(self):
        for axis in ("x", "y", "z"):
            self.position[axis] += self.velocity[axis]

    def energy(self):
        return self.potential_energy() * self.kinetic_energy()

    def potential_energy(self):
        return sum(abs(x) for x in self.position.values())

    def kinetic_energy(self):
        return sum(abs(x) for x in self.velocity.values())

    def __calculate_velocity_delta(self, moons, axis):
        delta = 0

        for moon in (x for x in moons if x.name != self.name):
            diff = moon.position[axis] - self.position[axis]

            if diff == 0: continue

            if diff > 0:
                delta += 1
            else:
                delta -= 1

        return delta

class Solver:
    def solve_a(self, moons, steps):
        for i in range(0, steps):
            self.__simulate_time_step(moons)

        return sum((moon.energy() for moon in moons))

    def solve_b(self, moons):
        steps = 0
        while True:

            pass

        return steps

    # private methods
    def __simulate_time_step(self, moons):
        for moon in moons:
            moon.apply_gravity(moons)

        for moon in moons:
            moon.apply_velocity()

if __name__ == "__main__":
    # file = open("./data/day12.txt", "r")

    moons = (
        Moon(name = "Io", x=-1, y=0, z=2),
        Moon(name = "Europa", x=2, y=-10, z=-7),
        Moon(name = "Ganymede", x=4, y=-8, z=8),
        Moon(name = "Callisto", x=3, y=5, z=-1)
    )

    # solver = Solver()
    # print(solver.solve_a(moons, 10))

    moons = (
        Moon(name = "Io", x=-8, y=-10, z=0),
        Moon(name = "Europa", x=5, y=5, z=10),
        Moon(name = "Ganymede", x=2, y=-7, z=3),
        Moon(name = "Callisto", x=9, y=-8, z=-3)
    )

    # solver = Solver()
    # print(solver.solve_a(moons, 100))

    moons = (
        Moon(name = "Io", x=-10, y=-10, z=-13),
        Moon(name = "Europa", x=5, y=5, z=-9),
        Moon(name = "Ganymede", x=3, y=8, z=-16),
        Moon(name = "Callisto", x=1, y=3, z=-3)
    )

    solver = Solver()
    print(solver.solve_a(moons, 1000))

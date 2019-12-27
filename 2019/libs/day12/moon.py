class Moon:
    def __init__(self, name, x, y, z):
        self.name = name
        self.position = {'x': x, 'y': y, 'z': z}
        self.velocity = {'x': 0, 'y': 0, 'z': 0}
        self._update_energies()

    def apply_gravity_on(self, moons, axis):
        self.velocity[axis] += self.__calculate_velocity_delta(moons, axis)

    def apply_velocity_on(self, axis):
        self.position[axis] += self.velocity[axis]

    def apply_gravity(self, moons):
        for axis in ('x', 'y', 'z'):
            self.apply_gravity_on(moons, axis)

        self._update_energies()

    def apply_velocity(self):
        for axis in ('x', 'y', 'z'):
            self.apply_velocity_on(axis)

        self._update_energies()

    def __calculate_velocity_delta(self, moons, axis):
        delta = 0

        for moon in (x for x in moons if x.name != self.name):
            diff = moon.position[axis] - self.position[axis]

            if diff == 0:
                continue

            if diff > 0:
                delta += 1
            else:
                delta -= 1

        return delta

    def _update_energies(self):
        self.kinetic_energy = sum(abs(x) for x in self.velocity.values())
        self.potential_energy = sum(abs(x) for x in self.position.values())
        self.energy = self.potential_energy * self.kinetic_energy

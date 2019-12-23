from collections import defaultdict

class Solver:
    def solve_a(self, lines):
        asteroids = self.locate_asteroids(lines)

        observed = defaultdict(list)

        for source in asteroids:
            for target in asteroids:
                if self.is_target_observable(source, target, observed, asteroids):
                    observed[source].append(target)

        return sorted(observed.items(), key=lambda item: len(item[1]))[-1]

    # private methods

    def locate_asteroids(self, lines):
        asteroids = []

        y = 0
        for line in lines:
            x = 0
            for o in line:
                if o == "#": asteroids.append((x, y))
                x += 1
            y += 1

        return tuple(asteroids)

    def is_target_observable(self, source, target, observed, asteroids):
        if source == target: return False

        if target in observed:
            if source not in observed[target]: return False
        else:
            if self.is_blocked(source, target, asteroids): return False

        return True

    def is_blocked(self, source, target, asteroids):
        blocking_asteroid = next(
            (a for a in asteroids if self.is_crossed_in_between(source, a, target)),
            None
        )
        return blocking_asteroid != None

    def is_crossed_in_between(self, source, other, target):
        if not self.is_in_between(other, source, target):
            return False

        return self.tangent(source, other) == self.tangent(target, other)

    def is_in_between(self, other, source, target):
        return (source > other and target < other) or (source < other and target > other)

    def tangent(self, point1, point2):
        delta_x = point2[0] - point1[0]

        if delta_x == 0: return None

        return (point2[1] - point1[1]) / delta_x

if __name__ == '__main__':
    file = open("./data/day10.txt", "r")
    # file = open("./data/day10_sample_1.txt", "r")
    # file = open("./data/day10_sample_2.txt", "r")
    # file = open("./data/day10_sample_5x8x32.txt", "r")
    # file = open("./data/day10_sample_1x2x35.txt", "r")
    # file = open("./data/day10_sample_6x3x41.txt", "r")
    lines = [ l.strip() for l in file.readlines() ]
    solver = Solver()
    # ((20, 18), 280))
    found = solver.solve_a(lines)
    print("(%s, %s)" % (found[0], len(found[1])))

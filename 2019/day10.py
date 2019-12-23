#
from collections import defaultdict

class Solver:
    X = 0
    Y = 1

    def solve_a(self, lines):
        asteroids = self.locate_asteroids(lines)

        observed = defaultdict(int)

        for source in asteroids:
            for target in asteroids:
                if self.is_blocked(source, target, asteroids): continue

                observed[source] += 1

        return sorted(observed.items(), key=lambda item: item[1])[-1]

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

    def is_blocked(self, source, target, asteroids):
        if source == target: return True

        for other in asteroids:
            if self.is_crossed_in_between(source, other, target): return True

        return False

    def is_crossed_in_between(self, source, other, target):
        if (source > other and target < other) or (source < other and target > other):
            return self.tangent(source, other) == self.tangent(other, target)

        return False

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
    print(solver.solve_a(lines))

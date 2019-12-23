#

import os
import psutil

class FFT:
    def __init__(self, base_pattern, data, phase):
        self.base_pattern      = base_pattern
        self.base_pattern_size = len(base_pattern)

        self._data       = data
        self.data_size   = len(data)
        self.data_buffer = [None] * self.data_size

        self.patterns = {}

        self.pattern_size = self.data_size + 1
        self.pattern      = [None] * self.pattern_size

        self.phase = phase

    def apply(self):
        self.data = list(self._data)

        for _ in range(0, self.phase): self.apply_phase()

        return self.data

    def apply_phase(self):
        for position in range(1, self.data_size + 1):
            self.data_buffer[position - 1] = self.__calculate_digit_at(position)

        self.data, self.data_buffer = self.data_buffer, self.data

        return self.data

    def __calculate_digit_at(self, position):
        self.__generate_pattern(position)
        return abs(sum(self.data[i] * self.pattern[i+1] for i in range(0, self.data_size))) % 10

    def __generate_pattern(self, position):
        pattern_pointer, pattern_index = 0, 0

        while True:
            for i in range(0, position):
                self.pattern[pattern_index] = self.base_pattern[pattern_pointer]

                pattern_index += 1
                if pattern_index >= self.pattern_size: return

            pattern_pointer += 1

            if pattern_pointer >= self.base_pattern_size:
                pattern_pointer = 0

class Solver:
    def __init__(self, base_pattern = (0, 1, 0, -1)):
        self.base_pattern      = base_pattern
        self.base_pattern_size = len(base_pattern)
        self.patterns          = {}

    def solve_a(self, data, phase):
        fft = FFT(self.base_pattern, data, phase)
        result = fft.apply()

        return "".join(str(_) for _ in result[0:8])

if __name__ == "__main__":
    line = "12345678"
    solver = Solver()
    solution = solver.solve_a(data = tuple(int(e) for e in line), phase = 4)
    assert solution == "01029498"

    line = "80871224585914546619083218645595"
    solver = Solver()
    solution = solver.solve_a(data = tuple(int(e) for e in line), phase = 100)
    assert solution == "24176176"

    # 19617804207202209144916044189917 becomes 73745418.
    line = "19617804207202209144916044189917"
    solver = Solver()
    solution = solver.solve_a(data = tuple(int(e) for e in line), phase = 100)
    assert solution == "73745418"

    # 69317163492948606335995924319873 becomes 52432133.
    line = "69317163492948606335995924319873"
    solver = Solver()
    solution = solver.solve_a(data = tuple(int(e) for e in line), phase = 100)
    assert solution == "52432133"

    file = open("./data/day16.txt", "r")
    line = file.readline().strip()
    solver = Solver()
    solution = solver.solve_a(data = tuple(int(e) for e in line), phase = 100)
    assert "88323090" == solution
    print(solution)

    # 03036732577212944063491565474664 becomes 84462026
    # line = "03036732577212944063491565474664"
    # solver = Solver()
    # solution = solver.solve_b(data = tuple(int(e) for e in line), phase = 100)
    # assert solution == "84462026"

    process = psutil.Process(os.getpid())
    print("%dM" % (process.memory_info().rss / (1024 * 1024)))

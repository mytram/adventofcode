#

import os
import psutil

def check_mem(msg = ""):
    process = psutil.Process(os.getpid())
    print("%s mem usage: %dM" % (msg, process.memory_info().rss / (1024 * 1024)))

class FFT:
    def __init__(self, data, phase):
        self.base_pattern = (0, 1, 0, -1)

        self._data       = data
        self.data_size   = len(data)
        self.data_buffer = [None] * self.data_size

        self.phase = phase

    def str(self):
        return ",".join(str(_) for _ in self.data)

    def apply(self):
        self.data = list(self._data)

        for p in range(0, self.phase):
            # check_mem(str(p))
            self.apply_phase()
            # print(self.str())

        return self.data

    def apply_phase(self):
        for position in range(1, int(self.data_size / 2) + 1):
            self.data_buffer[position - 1] = self.__calculate_digit(position)

        self.data_buffer[-1] = self.data[-1]

        for position in range(self.data_size - 1, int(self.data_size / 2), -1):
            self.data_buffer[position - 1] = self.data_buffer[position] + self.data[position - 1]

        for i in range(0, self.data_size):
            self.data_buffer[i] = abs(self.data_buffer[i]) % 10

        self.data, self.data_buffer = self.data_buffer, self.data

        return self.data

    def __calculate_digit(self, position):
        pointer, digit = (0, 0)

        base_pattern_pointer = 0

        if position == 1:
            base_pattern_pointer = 1

        while pointer < self.data_size:
            pattern_value = self.base_pattern[base_pattern_pointer]

            steps = position

            if pointer == 0:
                steps = max(1, steps - 1)

            end_pointer = min(pointer + steps, self.data_size)

            if pattern_value == 1:
                digit += sum(self.data[pointer:end_pointer])
            elif pattern_value == -1:
                digit -= sum(self.data[pointer:end_pointer])

            pointer = end_pointer

            if base_pattern_pointer == 3:
                base_pattern_pointer = 0
            else:
                base_pattern_pointer += 1

        return digit

class Solver:
    def solve_a(self, data, phase):
        fft = FFT(data, phase)
        result = fft.apply()

        return "".join(str(_) for _ in result[0:8])

    def solve_b(self, data, phase, repeat = 10_000):
        offset = int("".join(str(_) for _ in data[0:7]))
        fft = FFT((data * repeat)[offset:], phase)
        result = fft.apply()

        return "".join(str(_) for _ in result[0:8])

def verify_part_a():
    line = "12345678"
    solver = Solver()
    solution = solver.solve_a(data = tuple(int(e) for e in line), phase = 4)
    assert solution == "01029498"

    line = "80871224585914546619083218645595"
    solver = Solver()
    solution = solver.solve_a(data = tuple(int(e) for e in line), phase = 100)
    assert solution == "24176176"

    # # 19617804207202209144916044189917 becomes 73745418.
    line = "19617804207202209144916044189917"
    solver = Solver()
    solution = solver.solve_a(data = tuple(int(e) for e in line), phase = 100)
    assert solution == "73745418"

    # # 69317163492948606335995924319873 becomes 52432133.
    line = "69317163492948606335995924319873"
    solver = Solver()
    solution = solver.solve_a(data = tuple(int(e) for e in line), phase = 100)
    assert solution == "52432133"

if __name__ == "__main__":
    verify_part_a()

    file = open("./data/day16.txt", "r")
    line = file.readline().strip()
    solver = Solver()
    solution = solver.solve_a(data = tuple(int(e) for e in line), phase = 100)
    assert "88323090" == solution

    # 03036732577212944063491565474664 becomes 84462026
    # line = "03036732577212944063491565474664"
    # solver = Solver()
    # solution = solver.solve_b(data = tuple(int(e) for e in line), phase = 100)
    # print(solution)
    # assert solution == "84462026"

    # line = "69317163492948606335995924319873"
    # solver = Solver()
    # solution = solver.solve_b(data = tuple(int(e) for e in line), phase = 100, repeat = 1)
    # print(solution)
    # assert solution == "52432133"

    check_mem()

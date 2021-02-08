#
import os
import psutil

def check_mem(msg = ""):
    process = psutil.Process(os.getpid())
    print("%s mem usage: %dM" % (msg, process.memory_info().rss / (1024 * 1024)))

class FFT:
    def __init__(self, data, phase):
        self.base_pattern = (0, 1, 0, -1)
        self.base_pattern_size = len(self.base_pattern)

        self._data       = data
        self.data_size   = len(data)
        self.data_buffer = [None] * self.data_size

        self.phase = phase

    def apply(self, offset = 0):
        self.data = list(self._data)

        for _ in range(self.phase): self.__apply_phase(offset)

        return self.data

    # Private methods
    def __apply_phase(self, offset):
        half_way = int((self.data_size - 1)/2)

        stop_at = max(offset, half_way)

        # Second half
        self.data_buffer[-1] = self.data[-1]
        for position in range(self.data_size - 2, stop_at, -1):
            self.data_buffer[position] = (self.data_buffer[position + 1] + self.data[position]) % 10

        if stop_at == offset:
            self.data, self.data_buffer = self.data_buffer, self.data
            return

        # First half
        self.data_buffer[0] = 0
        for position in range(1, half_way + 1):
            self.data_buffer[position] = abs(self.__calculate_digit(position)) % 10

        self.data, self.data_buffer = self.data_buffer, self.data

    # This is written to gain some optimisation by skipping zeros and
    # preserving memory. However, it is still too slow for part b. In
    # the end, the solution of part b is to bypass this part. I could
    # have written it in a more readable way for part a.

    def __calculate_digit(self, position):
        pointer, digit, base_pattern_pointer = (0, 0, 0)

        while pointer < self.data_size:
            pattern_value = self.base_pattern[base_pattern_pointer]

            end_pointer = min(pointer + position, self.data_size)

            if pattern_value == 1:
                digit += sum(self.data[pointer:end_pointer])
            elif pattern_value == -1:
                digit -= sum(self.data[pointer:end_pointer])

            pointer = end_pointer

            base_pattern_pointer = (base_pattern_pointer + 1) % self.base_pattern_size

        return digit

class Solver:
    def solve_a(self, data, phase = 100):
        data = (0, ) + data
        fft = FFT(data, phase)
        result = fft.apply()

        return "".join(str(_) for _ in result[1:9])

    def solve_b(self, data, phase = 100, repeat = 10_000):
        offset = int("".join(str(_) for _ in data[0:7]))
        data = (0, ) + data * repeat

        # print("offset %d data size %d" % (offset, len(data)))

        fft = FFT(data, phase)
        result = fft.apply(offset)

        return "".join(str(_) for _ in result[offset+1:offset+9])

def verify_part_a():
    line = "12345678"
    solver = Solver()
    solution = solver.solve_a(data = tuple(int(e) for e in line), phase = 4)
    assert solution == "01029498"

    line = "80871224585914546619083218645595"
    solver = Solver()
    solution = solver.solve_a(data = tuple(int(e) for e in line))
    assert solution == "24176176"

    # # 19617804207202209144916044189917 becomes 73745418.
    line = "19617804207202209144916044189917"
    solver = Solver()
    solution = solver.solve_a(data = tuple(int(e) for e in line))
    assert solution == "73745418"

    # # 69317163492948606335995924319873 becomes 52432133.
    line = "69317163492948606335995924319873"
    solver = Solver()
    solution = solver.solve_a(data = tuple(int(e) for e in line))
    assert solution == "52432133"

def verify_part_b():
    # 03036732577212944063491565474664 becomes 84462026
    line = "03036732577212944063491565474664"
    solver = Solver()
    solution = solver.solve_b(data = tuple(int(e) for e in line))
    assert solution == "84462026"

    # 02935109699940807407585447034323 becomes 78725270.
    line = "02935109699940807407585447034323"
    solver = Solver()
    solution = solver.solve_b(data = tuple(int(e) for e in line))
    assert solution == "78725270"

    # 03081770884921959731165446850517 becomes 53553731.
    line = "03081770884921959731165446850517"
    solver = Solver()
    solution = solver.solve_b(data = tuple(int(e) for e in line))
    assert solution == "53553731"

if __name__ == "__main__":
    file = open("./data/day16.txt", "r")
    line = file.readline().strip()
    data = tuple(int(e) for e in line)

    # Part a
    verify_part_a()

    solver = Solver()
    solution = solver.solve_a(data)
    print("part a: %s" % solution)
    assert "88323090" == solution

    check_mem()

    # Part b
    print("""
Part b is computationally feasible only if the offset is larger than
half of the data size.

Since the bottom half of the coefficient matrix, i.e. the expanded
base patterns is a reversed triangle of 1s, therefore the computation
is reduced to one sum plus a mod 10, as such:
    row[i] = (row[i - 1] + data[i]) % 10
""")

    verify_part_b()

    solver = Solver()
    solution = solver.solve_b(data = data)
    print("part b: %s" % solution)

    check_mem()

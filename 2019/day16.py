#

class Solver:
    def __init__(self, base_pattern = (0, 1, 0, -1)):
        self.base_pattern      = base_pattern
        self.base_pattern_size = len(base_pattern)
        self.patterns          = {}

    def solve_a(self, data, phase):
        data_size = len(data)
        data = list(data)
        data_output = [None] * len(data)

        for _ in range(0, phase):
            self.__apply_fft(data, data_size, data_output)
            data, data_output = data_output, data

        return "".join(str(_) for _ in data[0:8])

    def __apply_fft(self, data, data_size, data_output):
        for p in range(1, data_size + 1):
            data_output[p - 1] = self.__calculate_digit(data, data_size, p)

    def __calculate_digit(self, data, data_size, position):
        pattern = self.__get_pattern(data_size, position)
        return abs(sum(data[i] * pattern[i] for i in range(0, data_size))) % 10

    def __get_pattern(self, data_size, position):
        if position not in self.patterns:
            self.patterns[position] = self.__generate_pattern(data_size, position)

        return self.patterns[position]

    def __generate_pattern(self, data_size, position):
        pattern_size = data_size + 1
        pattern = ()
        pattern_pointer = 0

        while len(pattern) < pattern_size:
            pattern += (self.base_pattern[pattern_pointer], ) * position
            pattern_pointer += 1

            if pattern_pointer >= self.base_pattern_size:
                pattern_pointer = 0

        return pattern[1:pattern_size]

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
    print(solution)

    # 03036732577212944063491565474664 becomes 84462026
    # line = "03036732577212944063491565474664"
    # solver = Solver()
    # solution = solver.solve_b(data = tuple(int(e) for e in line), phase = 100)
    # assert solution == "84462026"

''' Advent of code 2019 - day 7 '''

import itertools
from libs.day07 import Computer

class Solver:
    def solve_a(self, codes, phase_settings):
        """Solve a"""
        all_settings = itertools.permutations(phase_settings)
        return max(self._calculate_phase_settings(codes, s) for s in all_settings)

    def solve_b(self, program, phase_settings):
        """Solve b"""
        all_settings = itertools.permutations(phase_settings)
        signals = []
        for settings in all_settings:
            signals.append(self._run_amps(program, settings))

        return max(signals)

    def _calculate_phase_settings(self, codes, settings):
        computer = Computer()
        output = 0

        for setting in settings:
            computer.restart()
            inputs = [setting, output]
            computer.load(codes)
            computer.run(inputs)
            output = computer.get_outputs()[0]

        return output

    def _run_amps(self, program, settings):
        """Run phase loopback"""

        num_of_amps = len(settings)
        amps = tuple(Computer() for _ in range(num_of_amps))

        for amp in amps:
            amp.load(program)

        signal_buffer = [list() for _ in range(num_of_amps)]

        for i, setting in enumerate(settings):
            signal_buffer[i].append(setting)

        signal_buffer[0].append(0)

        has_more = True

        while has_more:
            has_more = False

            for i, amp in enumerate(amps):
                amp.run(signal_buffer[i])
                signal_buffer[i] = []

                if not amp.has_output:
                    continue

                has_more = True

                next_amp_pos = (i + 1) % num_of_amps

                signal_buffer[next_amp_pos] += amp.get_outputs()

                last_signal = signal_buffer[next_amp_pos][-1]

        return last_signal

def main():
    """Entry point"""
    with(open("./data/day07.txt", "r")) as file:
        program = [int(x.strip()) for x in file.readline().strip().split(',')]

    solver = Solver()
    result = solver.solve_a(program, [1, 0, 4, 3, 2])
    print(f'part a - {result}')
    assert result == 929_800

    solver = Solver()
    # program  = [3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,
    #             -5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,
    #             53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10    ]
    # program = [
    #     3, 26, 1001, 26, -4, 26, 3, 27, 1002, 27, 2,
    #     27, 1, 27, 26, 27, 4, 27, 1001, 28, -1, 28, 1005, 28, 6, 99,
    #     0, 0, 5
    # ]

    result = solver.solve_b(program, [9, 8, 7, 6, 5])
    print(f'part b - {result}')

if __name__ == '__main__':
    main()

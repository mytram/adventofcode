"""IntcodeComputer"""
ADD = {'code': 1, 'length': 4, 'num_of_params': 2}
MUL = {'code': 2, 'length': 4, 'num_of_params': 2}
IN  = {'code': 3, 'length': 2, 'num_of_params': 1}
OUT = {'code': 4, 'length': 2, 'num_of_params': 1}
JIT = {'code': 5, 'length': 3, 'num_of_params': 2}
JIF = {'code': 6, 'length': 3, 'num_of_params': 2}
LT  = {'code': 7, 'length': 4, 'num_of_params': 2}
EQ  = {'code': 8, 'length': 4, 'num_of_params': 2}

HALT = 99

MODE_POSITION  = 0
MODE_IMMEDIATE = 1

def get_param_value(position, program, param_mode):
    """Get param value"""
    if param_mode == MODE_IMMEDIATE:
        return program[position]

    return program[program[position]]

class IntcodeComputer:
    """Intcode computer"""

    def __init__(self):
        self.restart()

    def load(self, program):
        """Local program"""
        self.restart()
        self._program = list(program)
        self._instruction_counter = 0

    def restart(self):
        self._program = None
        self._instruction_counter = None
        self._outputs = []
        self.halted = False
        self.waiting_for_input = False

    @property
    def has_output(self):
        return len(self._outputs) > 0

    def get_outputs(self):
        tmp_buffer = list(self._outputs)
        self._outputs = []
        return tmp_buffer

    def run(self, inputs):
        """Run the program"""

        inputs = list(inputs)

        if self.halted:
            return

        if not self._program:
            raise "Load program first"

        if self.waiting_for_input and len(inputs) == 0:
            return

        self.waiting_for_input = False

        while True:
            self._instruction_counter = self._execute(inputs)

            if self.waiting_for_input:
                return

            if self.halted:
                return

    def _execute(self, inputs):
        instruction_counter = self._instruction_counter
        program = self._program
        outputs = self._outputs

        instruction = program[instruction_counter]
        opcode, param_modes = self._parse_instruction(instruction)

        if opcode == ADD['code']:
            a, b = self._get_params(instruction_counter, program, param_modes, 2)
            program[program[instruction_counter + 3]] = a + b

            return instruction_counter + ADD['length']

        if opcode == MUL['code']:
            a, b = self._get_params(instruction_counter, program, param_modes, 2)
            program[program[instruction_counter + 3]] = a * b

            return instruction_counter + MUL['length']

        if opcode == IN['code']:
            if len(inputs) == 0:
                self.waiting_for_input = True
                return instruction_counter

            program[program[instruction_counter + 1]] = inputs.pop(0)

            return instruction_counter + IN['length']

        if opcode == OUT['code']:
            value, = self._get_params(instruction_counter, program, param_modes, 1)
            outputs.append(value)

            return instruction_counter + OUT['length']

        if opcode == JIT['code']:
            a, b = self._get_params(instruction_counter, program, param_modes, 2)

            if not a == 0:
                return b

            return instruction_counter + JIT['length']

        if opcode == JIF['code']:
            a, b = self._get_params(instruction_counter, program, param_modes, 2)

            if a == 0:
                return b

            return instruction_counter + JIT['length']

        if opcode == LT['code']:
            a, b = self._get_params(instruction_counter, program, param_modes, 2)
            program[program[instruction_counter + 3]] = 1 if a < b else 0

            return instruction_counter + LT['length']

        if opcode == EQ['code']:
            a, b = self._get_params(instruction_counter, program, param_modes, 2)
            program[program[instruction_counter + 3]] = 1 if a == b else 0

            return instruction_counter + EQ['length']

        if opcode == HALT:
            self.halted = True
            return None

        raise 'should not be here'

    def _parse_instruction(self, instruction):
        digits = list(str(instruction))

        opcode = digits

        if len(digits) > 2:
            opcode = digits[-2:]

        opcode = int("".join(opcode))

        param_modes = tuple(int(e) for e in reversed(digits[0:-2]))

        return opcode, param_modes

    def _get_params(self, instruction_counter, program, param_modes, number):
        params = []

        for i in range(number):
            param_mode = param_modes[i] if i < len(param_modes) else MODE_POSITION
            value = get_param_value(instruction_counter + i + 1, program, param_mode)
            params.append(value)

        return params

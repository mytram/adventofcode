"""IntcodeComputer"""
ADD = {'code': 1, 'length': 4, 'num_of_params': 2}
MUL = {'code': 2, 'length': 4, 'num_of_params': 2}
IN  = {'code': 3, 'length': 2, 'num_of_params': 1}
OUT = {'code': 4, 'length': 2, 'num_of_params': 1}
JIT = {'code': 5, 'length': 3, 'num_of_params': 2}
JIF = {'code': 6, 'length': 3, 'num_of_params': 2}
LT  = {'code': 7, 'length': 4, 'num_of_params': 2}
EQ  = {'code': 8, 'length': 4, 'num_of_params': 2}
AR  = {'code': 9, 'length': 2, 'num_of_params': 1}

HALT = 99

MODE_POSITION  = 0
MODE_IMMEDIATE = 1
MODE_RELATIVE  = 2

class IntcodeComputer:
    """Intcode computer"""

    def __init__(self):
        self.restart()

    def load(self, program):
        """Load program"""
        self.restart()
        self._program = list(program)
        self._instruction_counter = 0

    def restart(self):
        self._program = None
        self._instruction_counter = None
        self._outputs = []
        self.halted = False
        self.waiting_for_input = False
        self._relative_base = 0
        self._memory = []

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

    # memory management
    def _ensure_memory(self, address):
        if address < len(self._memory):
            return

        temp_memory = self._memory
        self._memory = [0] * (address * 2)
        self._memory[0:len(temp_memory)] = temp_memory[0:]

    def _load(self, address):
        if address >= len(self._program):
            self._ensure_memory(address)
            return self._memory[address]

        return self._program[address]

    def _store(self, address, value):
        if address >= len(self._program):
            self._ensure_memory(address)
            self._memory[address] = value
            return

        self._program[address] = value

    def _execute_binary_operation(self, param_modes, operation):
        address_a, address_b, store, = self._get_addresses(param_modes, 3)

        operand_a, operand_b = self._load(address_a), self._load(address_b)

        self._store(store, operation(operand_a, operand_b))

    def _execute(self, inputs):
        instruction_counter = self._instruction_counter
        program = self._program
        outputs = self._outputs

        instruction = program[instruction_counter]
        opcode, param_modes = self._parse_instruction(instruction)

        if opcode == ADD['code']:
            self._execute_binary_operation(param_modes, lambda a, b: a + b)

            return instruction_counter + ADD['length']

        if opcode == MUL['code']:
            self._execute_binary_operation(param_modes, lambda a, b: a * b)

            return instruction_counter + MUL['length']

        if opcode == IN['code']:
            if len(inputs) == 0:
                self.waiting_for_input = True
                return instruction_counter

            address, = self._get_addresses(param_modes, 1)

            self._store(address, inputs.pop(0))

            return instruction_counter + IN['length']

        if opcode == OUT['code']:
            address, = self._get_addresses(param_modes, 1)
            value = self._load(address)
            outputs.append(value)

            return instruction_counter + OUT['length']

        if opcode == JIT['code']:
            operand_a, operand_b = [self._load(addr) for addr in self._get_addresses(param_modes, 2)]

            if not operand_a == 0:
                return operand_b

            return instruction_counter + JIT['length']

        if opcode == JIF['code']:
            operand_a, operand_b = [self._load(addr) for addr in self._get_addresses(param_modes, 2)]

            if operand_a == 0:
                return operand_b

            return instruction_counter + JIT['length']

        if opcode == LT['code']:
            self._execute_binary_operation(param_modes, lambda a, b: 1 if a < b else 0)

            return instruction_counter + LT['length']

        if opcode == EQ['code']:
            self._execute_binary_operation(param_modes, lambda a, b: 1 if a == b else 0)

            return instruction_counter + EQ['length']

        if opcode == AR['code']:
            address, = self._get_addresses(param_modes, 1)
            self._relative_base += self._load(address)

            return instruction_counter + AR['length']

        if opcode == HALT:
            self.halted = True
            return None

        raise Exception(f'unknown opcode {opcode}')

    def _parse_instruction(self, instruction):
        digits = list(str(instruction))

        opcode = digits

        if len(digits) > 2:
            opcode = digits[-2:]

        opcode = int("".join(opcode))

        param_modes = tuple(int(e) for e in reversed(digits[0:-2]))

        return opcode, param_modes

    def _get_addresses(self, param_modes, number):
        addresses = []

        for i in range(number):
            param_mode = param_modes[i] if i < len(param_modes) else MODE_POSITION
            addr = self._get_address(self._instruction_counter + i + 1, param_mode)
            addresses.append(addr)

        return addresses

    def _get_address(self, address, param_mode):
        if param_mode == MODE_IMMEDIATE:
            return address

        if param_mode == MODE_POSITION:
            return self._program[address]

        if param_mode == MODE_RELATIVE:
            address = self._program[address] + self._relative_base
            return address

        raise Exception(f'unknown param mode {param_mode} at address {address}')

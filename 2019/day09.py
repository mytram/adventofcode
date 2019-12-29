from libs.day07 import Computer
from libs.day09 import INPUT

def verify_a():
    program = [109, 1, 204, -1, 1001, 100, 1, 100, 1008, 100, 16, 101, 1006, 101, 0, 99]
    computer = Computer()
    computer.load(program)
    computer.run([])

    assert program == computer.get_outputs()

    program = [1102, 34915192, 34915192, 7, 4, 7, 99, 0]
    computer.load(program)
    computer.run([])
    assert computer.get_outputs() == [1219070632396864]

    program = [104, 1125899906842624, 99]
    computer.load(program)
    computer.run([])
    assert computer.get_outputs() == [1125899906842624]

verify_a()

computer = Computer()
computer.load(INPUT)
computer.run([1])
result = computer.get_outputs()
assert result == [2932210790]

computer = Computer()
computer.load(INPUT)
computer.run([2])
result = computer.get_outputs()
assert result == [73144]

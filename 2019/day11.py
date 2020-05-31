from libs.day07 import Computer
from libs.day11 import INPUT

computer = Computer()
computer.load(INPUT)
computer.run([0])
result = computer.get_outputs()
print(result)

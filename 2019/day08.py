#
class Solver:
    TRANSPARENT = 2

    def solve_a(self, images, width, height):
        """Solve a"""
        layers = self.create_layers(images, width, height)

        zero_counts = [len([x for x in layer if x == 0]) for layer in layers]

        layer_of_min_zero = layers[zero_counts.index(min(zero_counts))]

        ones, twos = 0, 0

        for x in layer_of_min_zero:
            if x == 1:
                ones += 1
            elif x == 2:
                twos += 1

        return ones * twos

    def solve_b(self, images, width, height):
        display_layer = self.make_list(width * height)
        layers = self.create_layers(images, width, height)
        number_of_layers = len(layers)

        for position in range(width * height):
            pixels = [layers[i][position] for i in range(number_of_layers)]
            display_layer[position] = self.find_first_colored_pixel(pixels)

        return '\n'.join(list(self.get_layer_lines(display_layer, width)))

    #
    # private methods
    #
    def get_layer_lines(self, layer, width):
        for row in list(self.chunks(layer, width)):
            line = ''.join([str(p) for p in row]).replace('0', ' ').replace('1', 'O')
            yield line

    def chunks(self, lst, n):
        for i in range(0, len(lst), n):
            yield lst[i:i + n]

    def find_first_colored_pixel(self, pixels):
        for pix in pixels:
            if pix != self.TRANSPARENT: return pix

    def make_list(self, length):
        return [None] * length

    def make_layers(self, number, size):
        return [self.make_list(size) for _ in range(number)]

    def create_layers(self, images, width, height):
        size_of_layer = width * height
        number_of_layers = int(len(images) / size_of_layer)

        layers = self.make_layers(number_of_layers, size_of_layer)

        for sequence in range(0, number_of_layers):
            self.assign_layer(images         = images,
                              layer          = layers[sequence],
                              layer_sequence = sequence,
                              width          = width,
                              height         = height)

        return layers

    def assign_layer(self, images, layer, layer_sequence, width, height):
        offset = layer_sequence * (width * height)

        for w in range(0, width):
            for h in range(0, height):
                position_of_layer = w + h * width
                layer[position_of_layer] = images[offset + position_of_layer]

def main():
    with open("./data/day08.txt", "r") as file:
        data = [int(x) for x in file.readline().strip()]
    solver = Solver()
    print(solver.solve_a(data, 25, 6))
    print(solver.solve_b(data, 25, 6))

if __name__ == "__main__":
    main()

from .bugs_life import BugsLife

def verify_bugslife():
    '''verify bugslife'''
    initial_world = (
        '....#',
        '#..#.',
        '#..##',
        '..#..',
        '#....'
    )

    current_world = BugsLife(initial_world).run(4)

    for row in current_world:
        print(''.join(row))

    expected_world = tuple(tuple(_) for _ in (
        '####.',
        '....#',
        '##..#',
        '.....',
        '##...',
    ))

    assert expected_world == current_world

def verify_biorating():
    '''verify biorating'''
    initial_world = (
        '.....',
        '.....',
        '.....',
        '#....',
        '.#...',
    )

    biorating = BugsLife(initial_world).biorating()

    assert biorating == 2129920

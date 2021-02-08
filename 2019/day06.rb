#

class Solver
  CENTER_OF_MASS = 'COM'

  attr_reader :full_orbit_map

  def solve_a(direct_orbits)
    direct_orbit_map = build_direct_orbit_map(direct_orbits)
    full_orbit_map = build_full_orbit_map(direct_orbit_map)

    return unless verified_full_orbit_map?(full_orbit_map)

    full_orbit_map.sum { |_, orbits| orbits.size }
  end

  def solve_b(direct_orbits)
    direct_orbit_map = build_direct_orbit_map(direct_orbits)
    @full_orbit_map = build_full_orbit_map(direct_orbit_map)

    return unless verified_full_orbit_map?(full_orbit_map)

    you_orbits = full_orbit_map['YOU']
    san_orbits = full_orbit_map['SAN']

    intersection_point = (you_orbits & san_orbits).first

    you_distance = (0...you_orbits.size).find { |x| you_orbits[x] == intersection_point }
    san_distance = (0...san_orbits.size).find { |x| san_orbits[x] == intersection_point }

    you_distance + san_distance
  end

  private

  def verified_full_orbit_map?(full_orbit_map)
    return false if full_orbit_map.nil?

    if full_orbit_map.find { |_, values| values.last != CENTER_OF_MASS }
      puts "[X] all orbits must end at COM"
      return false
    end

    true
  end

  def build_direct_orbit_map(direct_orbits)
    direct_orbits.each_with_object({}) do |orbit, orbit_map|
      orbitee, orbiter = orbit.split(')')
      orbit_map[orbiter] = orbitee
    end
  end

  def build_full_orbit_map(direct_orbit_map)
    direct_orbit_map.keys.each_with_object({}) do |orbiter, orbit_map|
      build_full_orbits(orbiter,
                        direct_orbit_map,
                        orbit_map)
    end
  end

  def build_full_orbits(orbiter, direct_orbit_map, orbit_map)
    return if orbit_map[orbiter] || orbiter == CENTER_OF_MASS

    orbitee = direct_orbit_map[orbiter]

    orbit_map[orbiter] ||= [orbitee]

    build_full_orbits(orbitee,
                      direct_orbit_map,
                      orbit_map)

    orbit_map[orbiter] = orbit_map[orbiter] + (orbit_map[orbitee] || [])
  end
end

solver = Solver.new

orbits = ['COM)B',
          'B)C',
          'C)D',
          'D)E',
          'E)F',
          'B)G',
          'G)H',
          'D)I',
          'E)J',
          'J)K',
          'K)L',]

orbits = File.open('data/day06.txt')
           .readlines
           .map(&:strip)
           .reject { |item| item.strip.empty? }

puts solver.solve_a(orbits) # 314702
puts solver.solve_b(orbits)

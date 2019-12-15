#

class Solver
  def solve_a(direct_orbits)
    direct_orbit_map = build_direct_orbit_map(direct_orbits)
    full_orbit_map = build_full_orbit_map(direct_orbit_map)
    full_orbit_map.sum { |_, orbits| orbits.size }
  end

  private

  def build_direct_orbit_map(direct_orbits)
    orbit_map = {}

    direct_orbits.each do |orbit|
      orbitee, orbiter = orbit.split(')').map(&:strip)
      orbit_map[orbiter] = orbitee
    end

    orbit_map
  end

  def build_full_orbit_map(direct_orbit_map)
    full_orbit_map = {}
    direct_orbit_map.keys.each do |direct_orbiter|
      build_full_orbits(direct_orbiter,
                        direct_orbit_map,
                        full_orbit_map)
    end

    full_orbit_map
  end

  def build_full_orbits(orbiter, direct_orbit_map, full_orbit_map)
    orbitee = direct_orbit_map[orbiter]
    return if orbitee.nil?

    full_orbit_map[orbiter] ||= [orbitee]

    return if direct_orbit_map[orbitee].nil?

    build_full_orbits(direct_orbit_map[orbitee],
                      direct_orbit_map,
                      full_orbit_map)

    full_orbit_map[orbiter] = (full_orbit_map[orbiter] + (full_orbit_map[orbitee] || [])).uniq
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
           .reject { |item| item.strip.empty? }

print solver.solve_a(orbits)

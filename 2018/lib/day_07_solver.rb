class Day07Solver < SolverBase
  def call
    generate(root_actions).join
  end

  def call2(workers:, delay:)
    generate_with_workers(root_actions, delay: delay, workers: workers)
  end

  def action_tree
    @action_tree ||= conditions.each_with_object({}) do |(action, next_action), t|
      t[action] ||= []
      t[action] << next_action
      t[action].sort!
    end
  end

  def root_actions
    @root_actions ||= actions.select { |a| root? a }.sort
  end

  private

  def generate_with_workers(available, workers:, delay:,
                            generated: [], wips: {}, tick: 0)
    finished_workers = []
    finished_jobs = []

    wips.each do |worker, wip|
      if (tick - wip[:tick]) == (wip[:job].ord - 'A'.ord + 1 + delay)
        finished_jobs << wip[:job]
        finished_workers << worker
      end
    end

    generated += finished_jobs

    finished_workers.each { |worker| wips.delete worker }

    new_available = finished_jobs.flat_map do |job|
      (action_tree[job] || []).select do |new_action|
        ready?(new_action, generated)
      end
    end

    available = (available + new_available).uniq.sort

    workers.times.each do |worker|
      next if wips[worker]

      break if available.empty?

      wips[worker] = {
        job: available.shift,
        tick: tick
      }
    end

    return tick if available.empty? && wips.keys.empty?

    generate_with_workers(available,
                          generated: generated,
                          workers: workers,
                          delay: delay,
                          wips: wips, tick: tick + 1)
  end

  def generate(available, generated = [])
    return generated if available.empty?

    generated << available.shift

    new_available = (action_tree[generated.last] || []).select do |new_action|
      ready?(new_action, generated)
    end

    generate((available + new_available).uniq.sort, generated)
  end

  def ready_guides
    @ready_guides ||= conditions.each_with_object({}) do |(action, next_action), t|
      t[next_action] ||= []
      t[next_action] << action
    end
  end

  def ready?(action, generated)
    (ready_guides[action] - generated).empty?
  end

  LINE_REGEX = /Step ([A-Z]) must be finished before step ([A-Z]) can begin/

  def parse_for_conditions(lines)
    lines.map { |l| LINE_REGEX.match(l).captures }
  end

  def conditions
    @conditions ||= parse_for_conditions(input)
  end

  def actions
    @actions ||= conditions.flatten.uniq
  end

  def root?(action)
    conditions.none? { |(_, a)| a == action }
  end
end

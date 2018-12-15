class Day04Solver < SolverBase
  #
  class PatrolLog
    ACTION_MAP = {
      'begins shift' => :begin,
      'falls asleep' => :sleep,
      'wakes up' => :wakeup
    }.freeze

    attr_reader :guard_id, :datetime, :action

    def initialize(guard_id, datetime, action)
      @guard_id = guard_id
      @datetime = datetime
      @action = ACTION_MAP.fetch(action)
    end

    def begin?
      @action == :begin
    end

    def sleep?
      @action == :sleep
    end
  end

  def call
    guard_id, = lazist_guard
    minute, = most_likely_sleep_minute(guard_id)

    guard_id * minute
  end

  def call2
    guard_id, minute, _ = guard_most_frequently_sleep_on_same_minute.max_by { | (_, _, times) | times.to_i }

    guard_id * minute
  end

  def guard_most_frequently_sleep_on_same_minute
    sleep_counts.keys.map do |guard_id|
      minute, times = most_likely_sleep_minute(guard_id)
      [guard_id, minute, times]
    end
  end

  def most_likely_sleep_minute(guard_id)
    guard_minute_counts(guard_id).max_by { | (_, c) | c }
  end

  def guard_minute_counts(guard_id)
    guard_sleep_minutes = sleep_patterns.each_with_object([]) do |(_, p), sleep_minutes|
      sleep_minutes << p[guard_id] if p[guard_id]
    end

    guard_sleep_minutes.each_with_object({}) do |day_minutes, minute_counts|
      day_minutes.each do |min|
        minute_counts[min] ||= 0
        minute_counts[min] += 1
      end
    end
  end

  def guard_list
    @guard_list ||= patrol_logs.map(&:guard_id).uniq.sort
  end

  def lazist_guard
    sleep_counts.max_by { | (_, c) | c }
  end

  def sleep_counts
    @sleep_counts ||= sleep_patterns.each_with_object({}) do |(_, sleep_logs), sleep_counts|
      sleep_logs.each do |guard, sleep_minutes|
        sleep_counts[guard] ||= 0
        sleep_counts[guard] += sleep_minutes.size
      end
    end
  end

  def patrol_logs
    @patrol_logs ||= parse_to_patrol_logs(input)
  end

  def sleep_patterns
    @sleep_patterns ||= sort_sleep_patterns(patrol_logs)
  end

  private

  LINE_REGEX = /\[(\d{4}-\d{2}-\d{2} \d{2}:\d{2})\] (Guard )?#?(\d+)? ?(\w+ \w+)/

  def parse_to_patrol_logs(lines)
    current_guard_id = nil

    lines.sort.map do |line|
      results = LINE_REGEX.match(line)
      datetime, _, guard_id, action = results.captures

      current_guard_id = guard_id.to_i if guard_id

      PatrolLog.new(
        current_guard_id, DateTime.parse(datetime).to_time, action
      )
    end
  end

  def sort_sleep_patterns(patrol_logs)
    patrol_shifts = sort_patrol_by_shift patrol_logs

    patrol_shifts.each_with_object({}) do |shift_logs, patterns|
      shift_logs.inject(nil) do |sleep_log, log|
        if log.sleep?
          log
        else
          mark_sleeptime(patterns, sleep_log, log)
        end
      end
    end
  end

  def sort_patrol_by_shift(patrol_logs)
    patrol_logs.each_with_object([]) do |log, logs|
      logs << [] if log.begin?
      logs.last << log
    end
  end

  def mark_sleeptime(patterns, sleep_log, wakeup_log)
    return if sleep_log.nil?

    guard_id = wakeup_log.guard_id
    start_time = sleep_log.datetime

    while start_time < wakeup_log.datetime
      day = start_time.strftime('%Y-%m-%d')

      patterns[day] ||= { guard_id => [] }
      patterns[day][guard_id] << start_time.min

      # next minute 60 seconds
      start_time += 60
    end
  end
end

__END__

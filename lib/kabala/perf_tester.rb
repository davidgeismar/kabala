module Kabala
  class PerfTester
    def initialize(config:)
      @config = config
      run_pre_scripts if @config.scripts.run_before
    end

    def execute
      begin
        @overall_duration = duration_monitor_ms do
          puts("starting script")
          threads = []
          @config.performance.thread_count.times do |thread_num|
            instance_variable_set("@invocation_duration_thread_#{thread_num}", [])
            t =  create_thread(thread_num)
            threads.push(t)
          end
          threads.map(&:join)
        end
      rescue => e
        raise e
      ensure
        create_report
        run_post_scripts if @config.scripts.run_after
      end
    end

    private

    def create_report
      invocation_durations_per_thread = (0...@config.performance.thread_count).map{|thread_num| eval("@invocation_duration_thread_#{thread_num}") }
      Report.new(
        csv_file_path: @config.reporting.csv_file_path,
        overall_duration: @overall_duration,
        thread_count: @config.performance.thread_count,
        invocation_durations_per_thread: invocation_durations_per_thread
      ).create
    end

    def create_thread(thread_num)
      Thread.new do
        @config.performance.invocations_per_thread.times do |invocation_num|
          perform_operation(thread_num, invocation_num)
        end
      end
    end

    def run_pre_scripts
      @config.scripts.run_before.each do |script|
        eval(File.open(File.expand_path(script.location)).read)
      end
    end

    def run_post_scripts
      @config.scripts.run_after.each do |script|
        eval(File.open(File.expand_path(script.location)).read)
      end
    end

    def duration_monitor_ms
      start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      yield
      finish =  Process.clock_gettime(Process::CLOCK_MONOTONIC)
      (finish - start)*1000
    end

    def perform_operation(thread_num, invocation_num)
      invocation_duration = duration_monitor_ms { @config.semantics.action_performer.perform(thread_num, invocation_num) }
      eval("@invocation_duration_thread_#{thread_num}").push(invocation_duration)
    end
  end
end

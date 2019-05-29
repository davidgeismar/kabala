module Kabala
  class PerformanceConfiguration
    attr_accessor :thread_count, :invocations_per_thread, :total_invocations
    # performance_configuration: thread_count: 1, invocations_per_thread: 100,
    def initialize(thread_count, invocations_per_thread)
      @thread_count = thread_count.to_i
      @invocations_per_thread = invocations_per_thread.to_i
      @total_invocations = thread_count.to_i * invocations_per_thread.to_i
    end
  end
end

module Kabala
  class Report
    def initialize(csv_file_path: , overall_duration:, thread_count:, invocation_durations_per_thread: [])
      @overall_duration = overall_duration
      @csv_file_path = csv_file_path
      @thread_count = thread_count
      @invocation_durations_per_thread = invocation_durations_per_thread
    end

    def create
      CSV.open(@csv_file_path, 'wb') do |csv|
        csv << ['thread', 'worst_case', 'best_case', 'avg_case', 'overall_duration']
        @all_threads_worst_case = @invocation_durations_per_thread.first.max
        @all_threads_best_case = @invocation_durations_per_thread.first.min
        @all_threads_avg_case = 0
        @invocation_durations_per_thread.each_with_index do |insert_durations, thread_num|
          build_report_row(csv, insert_durations, thread_num)
        end
        @all_threads_avg_case = @all_threads_avg_case/@thread_count
        csv << ['NA', @all_threads_worst_case.round(2), @all_threads_best_case.round(2), @all_threads_avg_case.round(2), @overall_duration.round(2)]
      end
    end

    def build_report_row(csv, insert_durations, thread_num)
      best_case = insert_durations.min&.round(2)
      worst_case =  insert_durations.max&.round(2)
      avg_case =  insert_durations.inject{ |sum, el| sum + el }.to_f / insert_durations.size
      overall = insert_durations.reduce(:+)&.round(2)
      @all_threads_worst_case = worst_case if worst_case > @all_threads_worst_case
      @all_threads_best_case = best_case if best_case < @all_threads_best_case
      @all_threads_avg_case += avg_case
      csv << [thread_num, worst_case, best_case, avg_case&.round(2),  overall]
    end
  end
end

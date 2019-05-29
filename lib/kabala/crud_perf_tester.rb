# module Kabala
#   class CrudPerfTester < Kabala::PerfTester
#     def initialize(config:, validate: true)
#       super(config: config)
#       @crud_performer = CrudPerformer.new(
#         klass: @config.semantics.klass,
#         crud_operation: @config.semantics.action,
#         validate: validate
#       )
#     end
#
#     private
#
#     def perform_operation(thread_num, invocation_num)
#       begin
#         temp_overrides = @config.override_engine.overrides.clone
#         @config.override_engine.overrides.keys.each do |key|
#           temp_overrides[key] = "#{temp_overrides[key]}-t#{thread_num}-i#{invocation_num}" if @config.override_engine.overrides_config[key] == :uniq
#         end
#         data = raw_data(overrides: temp_overrides)
#         insert_duration = duration_monitor_ms { @crud_performer.perform(data) }
#         eval("@invocation_duration_thread_#{thread_num}").push(insert_duration)
#       rescue => e
#         raise e
#       end
#     end
#   end
# end

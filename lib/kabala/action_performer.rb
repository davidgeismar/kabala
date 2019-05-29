module Kabala
  class ActionPerformer
    def initialize(klass:, methods: [])
      @klass =  klass
      @methods = methods
    end
    # data has special treatment compare to klass_initialization_args.... this is a bit weird
    def perform(thread_num, invocation_num)
      # @klass.new(data, *@klass_initialization_args).send(@action, *@action_args)
      method_chain = @klass
      @methods.each do |method|
        method_chain = method_chain.send(method[:name], *compile_args(method[:args], thread_num, invocation_num))
      end
    end

    private

    def compile_args(args, thread_num, invocation_num)
      method_args = []
      if args.present?
        args.each do |arg|
          method_args.push(compile_arg(arg, thread_num, invocation_num))
        end
      end
      method_args
    end
    # returns the data according to the original_data and the specific_config
    # change to two named arg
    def compile_arg(arg, thread_num, invocation_num)
      if arg[:overrides] && arg[:overrides_config]
        overrides = DataOverrideEngine.new(arg[:overrides], arg[:overrides_config]).override(thread_num, invocation_num)
        data = raw_data(data: arg[:data], overrides: overrides)
      else
        data = arg[:data]
      end
    end

    def raw_data(data:, overrides: {})
      data.merge(overrides.stringify_keys)
    end
  end
end

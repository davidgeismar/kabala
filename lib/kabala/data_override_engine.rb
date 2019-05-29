module Kabala
  class DataOverrideEngine
    attr_accessor :overrides, :overrides_config
    # overrides is the basic data to use
    # overrides_config is the logic to use to override
    def initialize(overrides, overrides_config)
      @overrides = overrides
      @overrides_config = overrides_config
    end

    # thread_num and invocation_num are used to inject unicity in data
    # should be dealt by other class
    def override(thread_num, invocation_num)
      temp_overrides = @overrides.clone
      @overrides.keys.each do |key|
        if @overrides_config.try(key).try(:uniq)
          if @overrides_config[key].try(:strategy) == :incremental
            temp_overrides[key] = temp_overrides[key].to_i + 1
            @overrides[key] = temp_overrides[key]
          else
            temp_overrides[key] = "#{temp_overrides[key]}-t#{thread_num}-i#{invocation_num}"
          end
        end
      end
      temp_overrides.stringify_keys
    end
  end
end

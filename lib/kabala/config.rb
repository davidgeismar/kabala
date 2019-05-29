module Kabala
  class Config
    attr_accessor :semantics, :performance, :reporting, :scripts
    def initialize(semantics_config: , performance_config: , reporting_config:, scripts_config:)
      @semantics= semantics_config
      @performance = performance_config
      @reporting = reporting_config
      @scripts = scripts_config
    end
  end
end

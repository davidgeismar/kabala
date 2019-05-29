module Kabala
  class ScriptsConfiguration
    attr_accessor :scripts, :run_before, :run_after
    # TODO introduce order logic
    def initialize(scripts)
     @scripts = []
     initialize_scripts(scripts)
     @run_before = @scripts.select{ |script| script.run == :before }
     @run_after = @scripts.select{ |script| script.run == :after }
    end

    private

    def initialize_scripts(scripts)
      scripts.each do |script|
        @scripts << Script.new(script)
      end
    end
  end
end

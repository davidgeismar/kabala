module Kabala
  class Script
    attr_accessor :run, :order, :location

    def initialize(run: , order:, location: )
      @run = run
      @order = order
      @location = location
    end
  end
end

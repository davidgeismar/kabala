module Kabala
  class SemanticsConfiguration
    attr_accessor :table_name, :action, :klass, :action_performer
    def initialize(table_name: 'ticket', action: 'create', klass: nil, methods: [])
      @table_name = table_name
      @klass = klass ? klass.constantize : table_name.classify.constantize
      @action_performer = ActionPerformer.new(klass: @klass, methods: methods)
    end
  end
end

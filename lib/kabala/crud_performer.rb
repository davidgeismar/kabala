
  class CrudPerformer
    def initialize(klass:, action_config: , validate:, id: nil)
      @klass =  klass
      @action= action_config[:name]
      @selector = -> klass { klass.send(action_config[:method], *action_config[:method_args])}
      @validate = validate
      @id = id
    end

    def perform(data)
      if @validate
        @klass.send(@action_config, data.except('_id', 'tote_id'))
      else
        case @action_config
        when 'create'
          instance = @klass.new(data.except('_id', 'tote_id'))
          instance.save(validate: false)
        when 'update'
          # should update based on a criteria
          # for example a raw sql query
          collection = @selector.call(@klass)
          collection.update(data.except('_id', 'tote_id'))
          # instance = @klass.find(@id)
          # instance.assign_attributes(data.except('_id', 'tote_id'))
          # instance.save(validate: false)
        when 'delete'
          instance = @klass.find(@id)
          instance.delete
        end
      end
    end
  end

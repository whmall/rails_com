module StateMachine

  # obj = Model.new
  # obj.process_to state: 'xxx'
  def process_to(options = {})
    if options.size > 1
      raise 'Only support one column'
    end

    options.each do |k, v|
      states = k.to_s.pluralize
      states = self.class.send(states).keys

      i = states.find_index self.send(k)
      n = states[i+1]

      if n == v.to_s
        update!(k => states[v])
      else
        errors.add k, 'Next state is wrong'
        raise ActiveRecord::Rollback, 'Next state is wrong'
      end
    end
  end

end
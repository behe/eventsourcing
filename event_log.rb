module EventLog
  class List
    def value
      @list ||= []
    end

    def add(n)
      value << n
    end

    def rem(i)
      value.delete_at(i)
    end
  end

  def list
    @list ||= List.new
  end

  def replay_commands(events)
    events.each { |event|
      command = event.split
      eval("list.#{command.shift.downcase} #{command.shift}")
    }
    list.value
  end

  def replay_file(file)
    replay_commands File.open(file).readlines
  end
end

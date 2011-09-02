module Program
  def replay_commands(events)
    @result = eval events.shift
    events.each { |event|
      command = event.downcase.split
      eval("#{command.shift} #{command.shift}")
    }
    @result
  end

  def replay_file(file)
    replay_commands File.open(file).readlines
  end

  def add(n)
    @result << n
  end

  def rem(n)
    @result.delete_at(n)
  end
end

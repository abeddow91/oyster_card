class Journey

attr_reader :start, :finish

def initialize
  @start = nil
  @finish = nil
end

def start_journey(entry_station)
  @start = entry_station
end

def finish_journey(exit_station)
  @finish = exit_station

end

end

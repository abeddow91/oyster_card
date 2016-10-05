class Journey

#PENALTY = 10
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

# def incomplete?
#   @start == nil || @finish == nil
# end
#
# def calculate_fare
#   return PENALTY if @journey.incomplete?
#   --random other fare stuff to be calculated in a different method---
#   end

end

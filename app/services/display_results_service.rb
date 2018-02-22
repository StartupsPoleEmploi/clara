
class DisplayResultsService
  
  def initialize(cached)
    @cached = cached
  end

  def go
    result = {}
    result[:flat_all_eligible] = @cached[:flat_all_eligible]
    result[:flat_all_uncertain] = @cached[:flat_all_uncertain]
    result[:flat_all_ineligible] = @cached[:flat_all_ineligible]
    result[:asker] = DisplayAskerService.new(Asker.new(@cached[:asker])).go
    result
  end
end

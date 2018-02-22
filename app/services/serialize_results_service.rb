
class SerializeResultsService
  
  def initialize(asker)
    @asker = asker
  end

  def go
    all_eligible = AidService.all_eligible(@asker)
    all_uncertain = AidService.all_uncertain(@asker)
    all_ineligible = AidService.all_ineligible(@asker)

    res = {
     flat_all_eligible: ResultService.new.convert_to_displayable_hash(all_eligible),
     flat_all_uncertain: ResultService.new.convert_to_displayable_hash(all_uncertain),
     flat_all_ineligible: ResultService.new.convert_to_displayable_hash(all_ineligible),
     asker: @asker.attributes
    }
    res
  end
end

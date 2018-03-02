
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

  def jsonify
    result = go
    result.delete :asker
    result[:all_eligible] = result.delete :flat_all_eligible
    result[:all_uncertain] = result.delete :flat_all_uncertain
    result[:all_ineligible] = result.delete :flat_all_ineligible

    format_bunch_of_eligies(result[:all_eligible])
    format_bunch_of_eligies(result[:all_uncertain])
    format_bunch_of_eligies(result[:all_ineligible])
    result.to_json
  end

private
  def format_bunch_of_eligies(hash_of_eligies)
    hash_of_eligies.each do |e|  
      e.delete "contract_type_icon"
      e.delete "contract_type_id"
      e.delete "how_much"
      e.delete "how_and_when"
      e.delete "limitations"
      e.delete "additionnal_conditions"
      e.delete "what"
      e.delete "updated_at"
      e.delete "created_at"
      e.delete "archived_at"
      e.delete "last_update"
      e.delete "contract_type_order"
      e.delete "rule_id"
      e.delete "ordre_affichage"
    end
  end

end

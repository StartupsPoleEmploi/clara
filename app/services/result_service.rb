
class ResultService  
  
  def convert_to_displayable_hash(eligibilities)
    return {} unless eligibilities.respond_to?("map")
    eligibilities.map do |e| 
      result_hsh = e.attributes
      if e.contract_type.present?
        result_hsh['contract_type_order'] = e.contract_type.ordre_affichage
        result_hsh['contract_type_icon'] = e.contract_type.icon
        result_hsh['contract_type_description'] = e.contract_type.description
      else
        result_hsh['contract_type_order'] = 99999
      end
      result_hsh
    end
  end

end

class TypeController < ApplicationController

  def show
    activated = ActivatedModelsService.instance
    contract = activated.contracts.detect{ |contract| contract["slug"] ==  params[:id] }
    aids_of_contract = activated.aids.find_all{ |aid| aid["contract_type_id"] == contract["id"] }
    # contract_type = ContractType.find_by!(slug: params[:id])
    # all_aids_of_contract_type = Aid.activated.where(contract_type: contract_type)
    # hashified_aids = ResultService.new.convert_to_displayable_hash(all_aids_of_contract_type)
    hydrate_view(
      # contract_type:  contract_type.attributes.symbolize_keys,
      contract_type:  contract,
      aids: aids_of_contract
    )
  end

end

class TypeController < ApplicationController

  def show
    contract_type = ContractType.find_by!(slug: params[:id])
    all_aids_of_contract_type = Aid.activated.where(contract_type: contract_type)
    hashified_aids = ResultService.new.convert_to_displayable_hash(all_aids_of_contract_type)
    hydrate_view(
      contract_type:  contract_type.attributes.symbolize_keys,
      aids: hashified_aids
    )
  end

end

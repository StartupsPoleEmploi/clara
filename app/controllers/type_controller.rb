class TypeController < ApplicationController

  def show
    activated = ActivatedModelsService.instance
    contract = activated.contracts.detect{ |contract| contract["slug"] ==  params[:id] }
    aids_of_contract = activated.aids.find_all{ |aid| aid["contract_type_id"] == contract["id"] }
    # p '- - - - - - - - - - - - - - contract- - - - - - - - - - - - - - - -' 
    # pp contract
    # p ''
    hydrate_view(
      contract:  contract,
      aids: aids_of_contract
    )
  end

end

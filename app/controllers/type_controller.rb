class TypeController < ApplicationController

  def show
    activated = ActivatedModelsService.instance
    contract = activated.contracts.detect{ |contract| contract["slug"] ==  params[:id] }
    # p '- - - - - - - - - - - - - - contract- - - - - - - - - - - - - - - -' 
    # pp contract
    # p ''
    aids_of_contract = activated.aids.find_all{ |aid| aid["contract_type_id"] == contract["id"] }
    # p '- - - - - - - - - - - - - - aids_of_contract- - - - - - - - - - - - - - - -' 
    # pp aids_of_contract
    # p ''
    # p '- - - - - - - - - - - - - - activated.aids- - - - - - - - - - - - - - - -' 
    # pp activated.aids
    # p ''
    hydrate_view(
      contract:  contract,
      aids: aids_of_contract
    )
  end

end

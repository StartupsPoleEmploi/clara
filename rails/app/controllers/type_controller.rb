class TypeController < ApplicationController

  def show
    redirection_url = redirection_table[request.path]
    if redirection_url.present?
      redirect_to redirection_url
    else
      activated = ActivatedModelsService.instance
      contract = activated.contracts.detect{ |contract| contract["slug"] ==  params[:id] }
      aids_of_contract = activated.aids.find_all{ |aid| aid["contract_type_id"] == contract["id"] }
      hydrate_view(
        contract:  contract,
        aids: aids_of_contract
      )
    end
  end

  def redirection_table
  {
    "/aides/type/aide-a-la-mobilite" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
  }
  end

end

require "test_helper"

class BuildCallbackHashTest < ActiveSupport::TestCase

  test ".perform calls ExpireCache" do
    #given
    allow_any_instance_of(PeConnectExtraction).to receive(:call).and_return(extraction)
    session_h = {}
    params_h = {code: 'any'}
    #when
    res = BuildCallbackHash.new.call(session_h, params_h, 'anyhost.com')
    #then
    assert_equal 42, res
  end

  def extraction
    {
      :info => {
                 "given_name" => "ROBERT",
                "family_name" => "MARCHAND",
                     "gender" => "male",
          "idIdentiteExterne" => "9bcb92d9-6a7b-464d-9b46-8c28af2b5af1",
                      "email" => "emploistoredev@gmail.com",
                        "sub" => "9bcb92d9-6a7b-464d-9b46-8c28af2b5af1",
                 "updated_at" => 1597733401
      },
      :statut => {
             "codeStatutIndividu" => "0",
          "libelleStatutIndividu" => "Non demandeur d’emploi"
      },
      :birth => {
             "codeCivilite" => nil,
          "libelleCivilite" => nil,
          "nomPatronymique" => nil,
               "nomMarital" => nil,
                   "prenom" => nil,
          "dateDeNaissance" => "1976-03-12T00:00:00+01:00"
      },
    }
  end

end

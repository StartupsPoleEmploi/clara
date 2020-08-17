MagicLamp.define do

  fixture(name: "aides") do
    render partial: 'test/aides'
  end

  fixture(name: "c-simulator-result") do
    render partial: 'admin/shared/c-simulator-result'
  end

  fixture(name: "geo_api_code_postal") do
    JSON.parse('
      [
        {
          "nom": "La Chapelle-sur-Erdre",
          "code": "44035",
          "codeDepartement": "44",
          "codeRegion": "52",
          "codesPostaux": [
            "44240"
          ],
          "population": 19348
        },
        {
          "nom": "Sucé-sur-Erdre",
          "code": "44201",
          "codeDepartement": "44",
          "codeRegion": "52",
          "codesPostaux": [
            "44240"
          ],
          "population": 6958
        }
      ]
    ')
  end

  fixture(name: "geo_api_code_postal_multiple") do
    JSON.parse('
      [{"nom":"Toulouse","code":"31555","codeDepartement":"31","codeRegion":"76","codesPostaux":["31500","31100","31400","31300","31000","31200","31998"],"population":475438}]
    ')
  end

end

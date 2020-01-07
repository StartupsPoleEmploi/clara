MagicLamp.define do

  fixture(name: "aides") do
    render partial: 'test/aides'
  end

  fixture(name: "c-simulator-result") do
    render partial: 'admin/shared/c-simulator-result'
  end

  fixture(name: "realistic_paginated_aid_collection") do
    render partial: 'test/realistic_aid_collection'
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

end

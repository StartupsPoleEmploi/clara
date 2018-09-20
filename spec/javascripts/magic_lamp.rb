MagicLamp.define do

  fixture(name: "c-simulator-result") do
    render partial: 'admin/shared/c-simulator-result'
  end

  fixture(name: "french_arrondissement_input") do
    JSON.parse("{}")
  end

  fixture(name: "multiple_towns_per_postcode_json") do
    JSON.parse('
    {
      "type": "FeatureCollection",
      "limit": 20,
      "version": "draft",
      "licence": "ODbL 1.0",
      "attribution": "BAN",
      "features": [
        {
          "type": "Feature",
          "properties": {
            "importance": 0.6466,
            "type": "municipality",
            "adm_weight": 4,
            "postcode": "43000",
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "id": "43157",
            "population": 18.8,
            "x": 769600,
            "y": 6438600,
            "name": "Le Puy-en-Velay",
            "citycode": "43157",
            "label": "Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.8769636363636364
          },
          "geometry": {
            "coordinates": [
              3.883955,
              45.043141
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.0867,
            "type": "municipality",
            "adm_weight": 1,
            "postcode": "43000",
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "id": "43089",
            "population": 3.6,
            "x": 767600,
            "y": 6438900,
            "name": "Espaly-Saint-Marcel",
            "citycode": "43089",
            "label": "Espaly-Saint-Marcel",
            "city": "Espaly-Saint-Marcel",
            "score": 0.8260636363636362
          },
          "geometry": {
            "coordinates": [
              3.858597,
              45.046041
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.0767,
            "type": "municipality",
            "adm_weight": 1,
            "postcode": "43000",
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "id": "43152",
            "population": 2.8,
            "x": 767600,
            "y": 6441500,
            "name": "Polignac",
            "citycode": "43152",
            "label": "Polignac",
            "city": "Polignac",
            "score": 0.8251545454545454
          },
          "geometry": {
            "coordinates": [
              3.858957,
              45.06945
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.075,
            "type": "municipality",
            "adm_weight": 1,
            "postcode": "43000",
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "id": "43045",
            "population": 0.4,
            "x": 765800,
            "y": 6437900,
            "name": "Ceyssac",
            "citycode": "43045",
            "label": "Ceyssac",
            "city": "Ceyssac",
            "score": 0.825
          },
          "geometry": {
            "coordinates": [
              3.835603,
              45.037211
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.075,
            "type": "municipality",
            "adm_weight": 1,
            "postcode": "43000",
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "id": "43002",
            "population": 1.6,
            "x": 769600,
            "y": 6439400,
            "name": "Aiguilhe",
            "citycode": "43002",
            "label": "Aiguilhe",
            "city": "Aiguilhe",
            "score": 0.825
          },
          "geometry": {
            "coordinates": [
              3.884069,
              45.050344
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3792,
            "type": "street",
            "postcode": "43000",
            "name": "Avenue Maréchal Foch",
            "id": "43157_XXXX_68a415",
            "x": 769840.5,
            "y": 6437684.7,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Avenue Maréchal Foch 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6708363636363635
          },
          "geometry": {
            "coordinates": [
              3.886879,
              45.034876
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.359,
            "type": "street",
            "postcode": "43000",
            "name": "Avenue Baptiste Marcet",
            "id": "43157_XXXX_e4846a",
            "x": 769815,
            "y": 6436476.6,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Avenue Baptiste Marcet 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6689999999999999
          },
          "geometry": {
            "coordinates": [
              3.886383,
              45.024002
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3535,
            "type": "street",
            "postcode": "43000",
            "name": "Boulevard Gambetta",
            "id": "43157_XXXX_47e921",
            "x": 769097.8,
            "y": 6438790,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Boulevard Gambetta 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6684999999999999
          },
          "geometry": {
            "coordinates": [
              3.877604,
              45.044902
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3495,
            "type": "street",
            "postcode": "43000",
            "name": "Boulevard Carnot",
            "id": "43157_XXXX_d211a5",
            "x": 769239.8,
            "y": 6438896.1,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Boulevard Carnot 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6681363636363635
          },
          "geometry": {
            "coordinates": [
              3.879497,
              45.045753
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.347,
            "type": "street",
            "postcode": "43000",
            "name": "Boulevard Saint-Louis",
            "id": "43157_XXXX_ac3fce",
            "x": 769362.8,
            "y": 6438553,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Boulevard Saint-Louis 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6679090909090908
          },
          "geometry": {
            "coordinates": [
              3.880936,
              45.042742
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3446,
            "type": "street",
            "postcode": "43000",
            "name": "Avenue du Val Vert",
            "id": "43157_XXXX_b9ec45",
            "x": 769659.5,
            "y": 6437321.7,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Avenue du Val Vert 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.667690909090909
          },
          "geometry": {
            "coordinates": [
              3.884529,
              45.031626
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3377,
            "type": "street",
            "postcode": "43000",
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "id": "43157_XXXX_414a86",
            "x": 770521.1,
            "y": 6439104.2,
            "name": "Avenue des Belges",
            "citycode": "43157",
            "label": "Avenue des Belges 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6670636363636362,
            "alias": "route de brives"
          },
          "geometry": {
            "coordinates": [
              3.895725,
              45.047587
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3354,
            "type": "street",
            "postcode": "43000",
            "name": "Boulevard Maréchal Fayolle",
            "id": "43157_XXXX_d84781",
            "x": 769847.5,
            "y": 6438505.7,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Boulevard Maréchal Fayolle 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6668545454545454
          },
          "geometry": {
            "coordinates": [
              3.887085,
              45.042267
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3354,
            "type": "street",
            "postcode": "43000",
            "name": "Boulevard Bertrand de Doue",
            "id": "43157_XXXX_273513",
            "x": 770576.5,
            "y": 6438707.7,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Boulevard Bertrand de Doue 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6668545454545454
          },
          "geometry": {
            "coordinates": [
              3.896001,
              45.043812
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3346,
            "type": "street",
            "postcode": "43000",
            "name": "Place du Breuil",
            "id": "43157_XXXX_496c82",
            "x": 769559.9,
            "y": 6438477.6,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Place du Breuil 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6667818181818181
          },
          "geometry": {
            "coordinates": [
              3.883428,
              45.042043
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3297,
            "type": "street",
            "postcode": "43000",
            "name": "Boulevard de la République",
            "id": "43157_XXXX_f85cce",
            "x": 770103.3,
            "y": 6438751,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Boulevard de la République 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6663363636363635
          },
          "geometry": {
            "coordinates": [
              3.890368,
              45.04445
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3282,
            "type": "street",
            "postcode": "43000",
            "name": "Avenue d\'Ours Mons",
            "id": "43157_XXXX_39f371",
            "x": 770484.7,
            "y": 6438266.4,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Avenue d\'Ours Mons 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6661999999999999
          },
          "geometry": {
            "coordinates": [
              3.895142,
              45.040048
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3268,
            "type": "street",
            "postcode": "43000",
            "name": "Avenue Antonin Raffier",
            "id": "43157_XXXX_ad3a62",
            "x": 772173.2,
            "y": 6437756.9,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Avenue Antonin Raffier 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6660727272727273
          },
          "geometry": {
            "coordinates": [
              3.916509,
              45.035286
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.325,
            "type": "street",
            "postcode": "43000",
            "name": "Boulevard Maréchal Joffre",
            "id": "43157_XXXX_8eeef5",
            "x": 770337.3,
            "y": 6439134.9,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Boulevard Maréchal Joffre 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6659090909090908
          },
          "geometry": {
            "coordinates": [
              3.893395,
              45.047882
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3219,
            "type": "street",
            "postcode": "43000",
            "name": "Rue Pannessac",
            "id": "43157_1550_5151ab",
            "x": 769394.5,
            "y": 6438688.3,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Rue Pannessac 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6656272727272727
          },
          "geometry": {
            "coordinates": [
              3.881358,
              45.043957
            ],
            "type": "Point"
          }
        }
      ],
      "query": "43000"
    }

      ')
  end


end

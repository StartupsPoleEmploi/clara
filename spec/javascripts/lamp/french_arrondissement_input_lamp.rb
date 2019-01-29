MagicLamp.define do

  fixture(name: "french_arrondissement_input") do
    JSON.parse('
      {
        "version": "draft",
        "limit": 20,
        "attribution": "BAN",
        "type": "FeatureCollection",
        "query": "75020",
        "features": [
          {
            "geometry": {
              "coordinates": [
                2.399262,
                48.863656
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue des Pyrénées 75020 Paris",
              "type": "street",
              "x": 655946,
              "postcode": "75020",
              "importance": 0.4897,
              "score": 0.680881818181818,
              "city": "Paris",
              "id": "75120_7904_ef0889",
              "y": 6862750.5,
              "citycode": "75120",
              "name": "Rue des Pyrénées"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.410111,
                48.855346
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Boulevard Davout 75020 Paris",
              "type": "street",
              "x": 656717,
              "postcode": "75020",
              "importance": 0.4896,
              "score": 0.6808727272727272,
              "city": "Paris",
              "id": "75120_XXXX_db7b6d",
              "y": 6861862.5,
              "citycode": "75120",
              "name": "Boulevard Davout"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.400725,
                48.867691
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Avenue Gambetta 75020 Paris",
              "type": "street",
              "x": 656055,
              "postcode": "75020",
              "importance": 0.4772,
              "score": 0.6797454545454544,
              "city": "Paris",
              "id": "75120_XXXX_9e7154",
              "y": 6863268.5,
              "citycode": "75120",
              "name": "Avenue Gambetta"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.39613,
                48.854453
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Boulevard de Charonne 75020 Paris",
              "type": "street",
              "x": 655714.8,
              "postcode": "75020",
              "importance": 0.4678,
              "score": 0.678890909090909,
              "city": "Paris",
              "id": "75120_XXXX_5af377",
              "y": 6861752.4,
              "citycode": "75120",
              "name": "Boulevard de Charonne"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.408745,
                48.86958
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Boulevard Mortier 75020 Paris",
              "type": "street",
              "x": 656628.6,
              "postcode": "75020",
              "importance": 0.465,
              "score": 0.6786363636363635,
              "city": "Paris",
              "id": "75120_XXXX_9a862b",
              "y": 6863446,
              "citycode": "75120",
              "name": "Boulevard Mortier"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.400905,
                48.868963
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue Pelleport 75020 Paris",
              "type": "street",
              "x": 656053,
              "postcode": "75020",
              "importance": 0.4585,
              "score": 0.6780454545454544,
              "city": "Paris",
              "id": "75120_7228_7c96f6",
              "y": 6863381.7,
              "citycode": "75120",
              "name": "Rue Pelleport"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.401499,
                48.85893
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue de Bagnolet 75020 Paris",
              "type": "street",
              "x": 656088.1,
              "postcode": "75020",
              "importance": 0.458,
              "score": 0.6779999999999999,
              "city": "Paris",
              "id": "75120_0626_42aef0",
              "y": 6862265.8,
              "citycode": "75120",
              "name": "Rue de Bagnolet"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.390546,
                48.868814
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue de Menilmontant 75020 Paris",
              "type": "street",
              "x": 655293,
              "postcode": "75020",
              "importance": 0.4534,
              "score": 0.6775818181818182,
              "city": "Paris",
              "id": "75120_6270_b7664c",
              "y": 6863371,
              "citycode": "75120",
              "name": "Rue de Menilmontant"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.390942,
                48.875382
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue de Belleville 75020 Paris",
              "type": "street",
              "x": 655327.7,
              "postcode": "75020",
              "importance": 0.4531,
              "score": 0.6775545454545453,
              "city": "Paris",
              "id": "75120_0833_ec0c28",
              "y": 6864101.1,
              "citycode": "75120",
              "name": "Rue de Belleville"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.404322,
                48.852338
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue d\'Avron 75020 Paris",
              "type": "street",
              "x": 656289.7,
              "postcode": "75020",
              "importance": 0.452,
              "score": 0.6774545454545454,
              "city": "Paris",
              "id": "75120_XXXX_a0e278",
              "y": 6861531.2,
              "citycode": "75120",
              "name": "Rue d\'Avron"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.38627,
                48.864119
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Boulevard de Menilmontant 75020 Paris",
              "type": "street",
              "x": 654975.3,
              "postcode": "75020",
              "importance": 0.4463,
              "score": 0.6769363636363634,
              "city": "Paris",
              "id": "75120_XXXX_cfe14f",
              "y": 6862851.3,
              "citycode": "75120",
              "name": "Boulevard de Menilmontant"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.403565,
                48.871645
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue Saint-Fargeau 75020 Paris",
              "type": "street",
              "x": 656257.9,
              "postcode": "75020",
              "importance": 0.4403,
              "score": 0.676390909090909,
              "city": "Paris",
              "id": "75120_XXXX_4662b9",
              "y": 6863687.7,
              "citycode": "75120",
              "name": "Rue Saint-Fargeau"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.397279,
                48.867612
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue Villiers de l\'Isle Adam 75020 Paris",
              "type": "street",
              "x": 655785.9,
              "postcode": "75020",
              "importance": 0.4384,
              "score": 0.6762181818181817,
              "city": "Paris",
              "id": "75120_XXXX_2c1515",
              "y": 6863233.5,
              "citycode": "75120",
              "name": "Rue Villiers de l\'Isle Adam"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.397575,
                48.866827
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue Orfila 75020 Paris",
              "type": "street",
              "x": 655806.9,
              "postcode": "75020",
              "importance": 0.4372,
              "score": 0.6761090909090908,
              "city": "Paris",
              "id": "75120_6924_66d4e9",
              "y": 6863146.1,
              "citycode": "75120",
              "name": "Rue Orfila"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.404286,
                48.851162
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue des Grands Champs 75020 Paris",
              "type": "street",
              "x": 656265.1,
              "postcode": "75020",
              "importance": 0.4351,
              "score": 0.6759181818181818,
              "city": "Paris",
              "id": "75120_4287_ba49cd",
              "y": 6861410.9,
              "citycode": "75120",
              "name": "Rue des Grands Champs"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.40143,
                48.855384
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue de la Réunion 75020 Paris",
              "type": "street",
              "x": 656070.8,
              "postcode": "75020",
              "importance": 0.4351,
              "score": 0.6759181818181818,
              "city": "Paris",
              "id": "75120_8180_5b2f94",
              "y": 6861861.9,
              "citycode": "75120",
              "name": "Rue de la Réunion"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.403194,
                48.856351
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue des Orteaux 75020 Paris",
              "type": "street",
              "x": 656210.3,
              "postcode": "75020",
              "importance": 0.4338,
              "score": 0.6757999999999998,
              "city": "Paris",
              "id": "75120_6958_ee42b1",
              "y": 6861978.1,
              "citycode": "75120",
              "name": "Rue des Orteaux"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.40395,
                48.872918
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue Haxo 75020 Paris",
              "type": "street",
              "x": 656279.7,
              "postcode": "75020",
              "importance": 0.4325,
              "score": 0.675681818181818,
              "city": "Paris",
              "id": "75120_4510_bebd6c",
              "y": 6863819.8,
              "citycode": "75120",
              "name": "Rue Haxo"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.406755,
                48.852637
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue des Maraîchers 75020 Paris",
              "type": "street",
              "x": 656468.5,
              "postcode": "75020",
              "importance": 0.4316,
              "score": 0.6755999999999999,
              "city": "Paris",
              "id": "75120_5985_63a756",
              "y": 6861563.1,
              "citycode": "75120",
              "name": "Rue des Maraîchers"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.379993,
                48.86982
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Boulevard de Belleville 75020 Paris",
              "type": "street",
              "x": 654519.8,
              "postcode": "75020",
              "importance": 0.4306,
              "score": 0.6755090909090908,
              "city": "Paris",
              "id": "75120_XXXX_f7eabc",
              "y": 6863488.8,
              "citycode": "75120",
              "name": "Boulevard de Belleville"
            }
          }
        ],
        "licence": "ODbL 1.0"
      }
    ')
  end  

end

//= require custom/aides/aides_constants
//= require custom/aides/aides_iterate_contract_types
describe('aides_iterate_contract_types.js', function() {

  beforeAll(function(){
    _.set(window, "main_store", {getState: _.wrap(MagicLamp.loadJSON("nominal_aides_state"))})
  });
  afterAll(function(){
    _.unset(window, "main_store")
  });
  it('Should iterate through contract_type', function() {
    //given
    var arr = []
    var my_function = function(ely, contract){arr.push({ely:ely, contract:contract})}
    //when
    clara.aides_iterate_contract_types.please(my_function)
    //then
    expect(arr[0]).toEqual(
      {
        "ely": "eligibles",
        "contract": {
          "name": "contrat-specifique",
          "is_collapsed": false,
          "aids": [
            {
              "name": "volontariat-associatif",
              "is_collapsed": false,
              "filters": [
                {
                  "name": "s-informer-sur-contrats-specifiques",
                  "is_collapsed": false
                }
              ]
            }
          ]
        }
      }
    );
  });

});

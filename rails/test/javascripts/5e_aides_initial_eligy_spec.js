//= require custom/aides/aides_initial_eligy.js
describe('aides_initial_eligy.js', function() {


  describe('Nominal', function() {
    beforeAll(function() { 
      MagicLamp.load("aides");
    });
    afterAll(function() { 
      $(".magic-lamp").remove();
    });
    it('Nominal : returns array', function() {
        res = clara.aides_initial_eligy.please("eligibles");
        expect(res).toEqual(
        [{
          "name": "aide-a-la-definition-du-projet-professionnel",
          "is_collapsed": true,
          "aids": [
            {
              "name": "garantie-jeunes",
              "is_collapsed": false,
              "filters": [
                {
                  "name": "accompagne-recherche-emploi",
                  "is_collapsed": false
                }
              ]
            }
          ]
        },
        {
          "name": "emploi-international",
          "is_collapsed": true,
          "aids": [
            {
              "name": "vsi-volontariat-de-solidarite-internationale",
              "is_collapsed": false,
              "filters": [
                {
                  "name": "travailler-a-l-international",
                  "is_collapsed": false
                }
              ]
            }
          ]
        }]
      );
    });
  });

});

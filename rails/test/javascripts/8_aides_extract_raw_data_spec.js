//= require_tree ../../app/assets/javascripts/custom/aides
describe('aides_extract_raw_data.js', function() {

  describe('.aides_extract_raw_data', function() {
    it('extract data from store thanks to state_key', function() {
      var realistic_state = MagicLamp.loadJSON("nominal_aides_state");
      var res = clara.aides_extract_raw_data.please(realistic_state);
      // concatenated and sorted slug of all aids shown on page
      expect(res).toEqual(
        [
          "aide-a-la-mobilite-professionnelle-des-artistes-et-technicien-ne-s-du-spectacle",
           "aide-aux-depenses-de-sante-des-artistes-et-technicien-ne-s-du-spectacle",
           "autres-aides-nationales-pour-la-mobilite",
           "autres-frais-derogatoires",
           "erasmus",
           "garantie-jeunes",
           "service-militaire-volontaire-smv",
           "volontariat-associatif",
           "vsi-volontariat-de-solidarite-internationale"])
    });
  });

});
  

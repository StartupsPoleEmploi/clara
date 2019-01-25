//= require custom/aides/please_set_aides_state.js
describe('please_set_aides_state.js', function() {

  it('Should have please_get_aides_default_state mapped to clara', function() {
    expect(clara.please_set_aides_state).toBeDefined();
  });

  describe('_extract_from_state', function() {
    it('extract data from store thanks to state_key', function() {
      var realistic_state = MagicLamp.loadJSON("nominal_aides_state");
      var res = clara.please_set_aides_state._extract_from_state(realistic_state);
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
  

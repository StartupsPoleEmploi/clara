//= require custom/aides/aides_$aids_per_card.js
describe('aides_$aids_per_card.js', function() {


  describe('Nominal', function() {
    beforeAll(function() { 
      MagicLamp.load("aides");
    });
    afterAll(function() { 
      $(".magic-lamp").remove();
    });
    it('Nominal : returns a c_resultaid if args are correct', function() {
        $res = clara.aides_$aids_per_card.please("eligibles", "emploi-international");
        expect($res.prop("outerHTML")).toHaveAttr("data-aslug", "vsi-volontariat-de-solidarite-internationale");
    });
  });

});

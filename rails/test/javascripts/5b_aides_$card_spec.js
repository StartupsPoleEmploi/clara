//= require custom/aides/aides_$card.js
describe('aides_$card.js', function() {


  describe('Nominal', function() {
    beforeAll(function() { 
      MagicLamp.load("aides");
    });
    afterAll(function() { 
      $(".magic-lamp").remove();
    });
    it('eligibles : returns many elements', function() {
        $res = clara.aides_$card.please("eligibles");
        expect($res.length).toBeGreaterThan(0);
    });
    it('eligibles : each element is a c-resultcard', function() {
        $first_res = clara.aides_$card.please("eligibles")[0];
        expect($first_res).toHaveClass("c-resultcard");
    });
    it('eligibles : each element is a green c-resultcard', function() {
        $first_res = clara.aides_$card.please("eligibles")[0];
        expect($first_res).toHaveClass("c-resultcard c-resultcard--green");
    });
    it('ineligibles : each element is a red c-resultcard', function() {
        $first_res = clara.aides_$card.please("ineligibles")[0];
        expect($first_res).toHaveClass("c-resultcard c-resultcard--red");
    });
    it('uncertains : each element is an orange c-resultcard', function() {
        $first_res = clara.aides_$card.please("uncertains")[0];
        expect($first_res).toHaveClass("c-resultcard c-resultcard--orange");
    });
    it('anything goes wrong : return sth empty', function() {
        $first_res = clara.aides_$card.please("unexisting");
        expect($first_res.prop("outerHTML")).toEqual(undefined);
    });
  });

});

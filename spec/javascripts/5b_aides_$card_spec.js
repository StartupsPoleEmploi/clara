//= require custom/aides/aides_$card.js
describe('aides_$card.js', function() {

  afterEach(function() {
    $(".test-only").remove();
  })

  describe('Nominal', function() {
    beforeEach(function() {
      $('body').append('\
        <div class="test-only">\
          <div id="eligible">\
            <div class="c-resultcard">eligible resultcard content</div>\
          </div>\
          <div id="ineligible">\
            <div class="c-resultcard">ineligible resultcard content</div>\
          </div>\
        </div>\
      ');
    });
    it('eligible : returns jquery elt .c-resultcard if found', function() {
        $res = clara.aides_$card.please("eligible");
        expect($res.prop('outerHTML')).toEqual('<div class="c-resultcard">eligible resultcard content</div>');
    });
    it('ineligible : returns jquery elt .c-resultcard if found', function() {
        $res = clara.aides_$card.please("ineligible");
        expect($res.prop('outerHTML')).toEqual('<div class="c-resultcard">ineligible resultcard content</div>');
    });
    it('returns empty jquery elt if not found', function() {
        $res = clara.aides_$card.please("unexisting");
        expect($res.prop('outerHTML')).toEqual(undefined);
    });
  });

});

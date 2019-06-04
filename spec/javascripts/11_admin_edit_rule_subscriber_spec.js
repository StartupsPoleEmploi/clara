//= require_tree ../../app/assets/javascripts/administrate/custom/admin_edit_rule
describe("admin_edit_rule_subscriber.js", function() {

  describe(".please", function() {


    describe("title", function() {
      beforeEach(function() { $('body').append('<div class="js-title"></div>');});
      afterEach(function() {$(".js-title").remove();});
      it("Hydrate .js-title according to state", function() {
        // given
        var state = {title: "<h1>title_value</h1>"}
        // when
        sut().please(state);
        // then
        expect($(".js-title")).toContainHtml("<h1>title_value</h1>");
      });      
    });

    describe("additionnal-conditions", function() {
      beforeEach(function() {$('body').append('<div class="js-additionnal-conditions"></div>');})
      afterEach(function() {$(".js-additionnal-conditions").remove();})
      it("Hydrate .js-additionnal-conditions according to state", function() {
        // given
        var state = {additionnal_conditions: "<h1>additionnal-conditions_value</h1>"}
        // when
        sut().please(state);
        // then
        expect($(".js-additionnal-conditions")).toContainHtml("<h1>additionnal-conditions_value</h1>");
      });      
    });
    
    describe("how-and-when", function() {
      beforeEach(function() { $('body').append('<div class="js-how-and-when"></div>');});
      afterEach(function() {$(".js-how-and-when").remove();})
      it("Hydrate .js-how-and-when according to state", function() {
        // given
        var state = {how_and_when: "<h1>how-and-when_value</h1>"}
        // // when
        sut().please(state);
        // // then
        expect($(".js-how-and-when")).toContainHtml("<h1>how-and-when_value</h1>");
      });      
    });

    function sut() {
      return clara.admin_edit_rule_subscriber;
    }

});
});
  

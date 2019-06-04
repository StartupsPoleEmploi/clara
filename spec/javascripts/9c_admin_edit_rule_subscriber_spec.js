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

    describe("how-much", function() {
      beforeEach(function() { $('body').append('<div class="js-how-much"></div>');});
      afterEach(function() {$(".js-how-much").remove();})
      it("Hydrate .js-how-much according to state", function() {
        // given
        var state = {how_much: "<h1>how-much_value</h1>"}
        // // when
        sut().please(state);
        // // then
        expect($(".js-how-much")).toContainHtml("<h1>how-much_value</h1>");
      });      
    });

    describe("limitations", function() {
      beforeEach(function() { $('body').append('<div class="js-limitations"></div>');});
      afterEach(function() {$(".js-limitations").remove();})
      it("Hydrate .js-limitations according to state", function() {
        // given
        var state = {limitations: "<h1>limitations_value</h1>"}
        // // when
        sut().please(state);
        // // then
        expect($(".js-limitations")).toContainHtml("<h1>limitations_value</h1>");
      });      
    });

    describe("what", function() {
      beforeEach(function() { $('body').append('<div class="js-what"></div>');});
      afterEach(function() {$(".js-what").remove();})
      it("Hydrate .js-what according to state", function() {
        // given
        var state = {what: "<h1>what_value</h1>"}
        // // when
        sut().please(state);
        // // then
        expect($(".js-what")).toContainHtml("<h1>what_value</h1>");
      });      
    });

    describe("contract", function() {
      beforeEach(function() { $('body').append('<div class="js-contract"></div>');});
      afterEach(function() {$(".js-contract").remove();})
      it("Hydrate .js-contract according to state", function() {
        // given
        var state = {contract: "<h1>contract_value</h1>"}
        // // when
        sut().please(state);
        // // then
        expect($(".js-contract")).toContainHtml("<h1>contract_value</h1>");
      });      
    });

    function sut() {
      return clara.admin_edit_rule_subscriber;
    }

});
});
  

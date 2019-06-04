//= require_tree ../../app/assets/javascripts/administrate/custom/admin_edit_rule
describe("admin_edit_rule_dispatcher.js", function() {

  describe(".please", function() {


    it("Dispatch WHAT_CHANGED if what changed", function() {
      // given
      var store = create_store(); spyOn(store, "dispatch");
      // when
      sut().please(store, {editor_what:create_ckeditor("what")});
      // then
      expect(store.dispatch).toHaveBeenCalledWith({ type: "WHAT_CHANGED", value: "data_of_what" });
    });

    it("Dispatch LIMITATIONS_CHANGED if limitations changed", function() {
      // given
      var store = create_store(); spyOn(store, "dispatch");
      // when
      sut().please(store, {editor_limitations:create_ckeditor("limitations")});
      // then
      expect(store.dispatch).toHaveBeenCalledWith({ type: "LIMITATIONS_CHANGED", value: "data_of_limitations" });
    });

    it("Dispatch HOW_MUCH_CHANGED if how_much changed", function() {
      // given
      var store = create_store(); spyOn(store, "dispatch");
      // when
      sut().please(store, {editor_how_much:create_ckeditor("how_much")});
      // then
      expect(store.dispatch).toHaveBeenCalledWith({ type: "HOW_MUCH_CHANGED", value: "data_of_how_much" });
    });

    it("Dispatch HOW_AND_WHEN_CHANGED if how_and_when changed", function() {
      // given
      var store = create_store(); spyOn(store, "dispatch");
      // when
      sut().please(store, {editor_how_and_when:create_ckeditor("how_and_when")});
      // then
      expect(store.dispatch).toHaveBeenCalledWith({ type: "HOW_AND_WHEN_CHANGED", value: "data_of_how_and_when" });
    });

    it("Dispatch ADDITIONNAL_CONDITIONS_CHANGED if additionnal_conditions changed", function() {
      // given
      var store = create_store(); spyOn(store, "dispatch");
      // when
      sut().please(store, {editor_additionnal_conditions: create_ckeditor("additionnal_conditions")});
      // then
      expect(store.dispatch).toHaveBeenCalledWith({ type: "ADDITIONNAL_CONDITIONS_CHANGED", value: "data_of_additionnal_conditions" });
    });

    describe("contract change", function() {
      beforeEach(function() { 
        $('body').append('\
          <select class="test-only" name="aid[contract_type_id]" id="aid_contract_type_id">\
            <option value=""></option>\
            <option selected="selected" value="1">Aide à la mobilité</option>\
            <option value="10">Aide régionale</option>\
          </select>\
        ');
      });
      afterEach(function() {
        $(".test-only").remove();
      })
      it("Dispatch CONTRACT_CHANGED if contract changed", function() {
        // given
        var $aid_contract_type_id = $("#aid_contract_type_id")
        var store = create_store(); spyOn(store, "dispatch");
        // when
        sut().please(store, {$aid_contract_type_id: $aid_contract_type_id});
        $aid_contract_type_id.trigger('change');
        // then
        expect(store.dispatch).toHaveBeenCalledWith(
          { type: "CONTRACT_CHANGED", value: "Aide à la mobilité" }
        );
      });      
    });

    describe("title change", function() {
      beforeEach(function() { 
        $('body').append('\
          <input type="text" value="Bon de transport" name="aid[name]" id="aid_name">\
        ');
      });
      afterEach(function() {
        $("#aid_name").remove();
      })
      it("Dispatch TITLE_CHANGED if titled changed", function() {
        // given
        var $aid_name = $("#aid_name")
        var store = create_store(); spyOn(store, "dispatch");
        // when
        sut().please(store, {$aid_name: $aid_name});
        $aid_name.trigger('keyup');
        // then
        expect(store.dispatch).toHaveBeenCalledWith(
          { type: "TITLE_CHANGED", value: "Bon de transport" }
        );
      });      
    });

    function sut() {
      return clara.admin_edit_rule_dispatcher;
    }

    function create_ckeditor(name) {
      return {
        on: function(evt, func){
          if(evt === "change") {
            func();
          }
        },
        getData: function(){
          return "data_of_" + name;
        }
      }
    }

    function create_store() {
      return {
        dispatch: function(arg1, arg2){}
      }
    }

});
});
  

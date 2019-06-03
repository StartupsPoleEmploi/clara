//= require_tree ../../app/assets/javascripts/administrate/custom/admin_edit_rule
describe("admin_edit_rule_dispatcher.js", function() {

  describe(".please", function() {

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


    it("Dispatch WHAT_CHANGED if what changed", function() {
      // given
      var fake_ckeditor = create_ckeditor("what"); spyOn(fake_ckeditor, "on").and.callThrough();
      var store = create_store(); spyOn(store, "dispatch");
      // when
      clara.admin_edit_rule_dispatcher.please(store, {editor_what:fake_ckeditor});
      // then
      expect(store.dispatch).toHaveBeenCalledWith({ type: "WHAT_CHANGED", value: "data_of_what" });
    });

    it("Dispatch ADDITIONNAL_CONDITIONS_CHANGED if additionnal_conditions changed", function() {
      // given
      var fake_ckeditor = create_ckeditor("additionnal_conditions"); spyOn(fake_ckeditor, "on").and.callThrough();
      var store = create_store(); spyOn(store, "dispatch");
      // when
      clara.admin_edit_rule_dispatcher.please(store, {editor_additionnal_conditions:fake_ckeditor});
      // then
      expect(store.dispatch).toHaveBeenCalledWith({ type: "ADDITIONNAL_CONDITIONS_CHANGED", value: "data_of_additionnal_conditions" });
    });

});
});
  

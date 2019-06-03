//= require_tree ../../app/assets/javascripts/administrate/custom/admin_edit_rule
describe('admin_edit_rule_dispatcher.js', function() {

  describe('.please', function() {

    function create_obs_for(name) {

    }

    function create_store() {
      return {
        dispatch: function(arg1, arg2){}
      }
    }

    it('Dispatch ADDITIONAL_CONDITION_CHANGED if additionnal_conditions changed', function() {
      // given
      var obs = {
        editor_what: {
          on: function(evt, func){func()},
          getData: function(){return 42}
        }
      };
      var store = create_store();

      spyOn(store, 'dispatch');
      // when
      clara.admin_edit_rule_dispatcher.please(store, obs);
      // then
      expect(store.dispatch).toHaveBeenCalledWith({ type: 'WHAT_CHANGED', value: 42 });
    });
});
});
  

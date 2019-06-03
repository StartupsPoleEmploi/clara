//= require_tree ../../app/assets/javascripts/administrate/custom/admin_edit_rule
describe('admin_edit_rule_dispatcher.js', function() {

  describe('.please', function() {

    function create_obs(name) {
      var obs = { };
      obs["editor_" + name] = {
          on: function(evt, func){func()},
          getData: function(){return 42}
        };
      return obs;
    }

    function create_store() {
      return {
        dispatch: function(arg1, arg2){}
      }
    }

    it('Dispatch ADDITIONNAL_CONDITIONS_CHANGED if additionnal_conditions changed', function() {
      // given
      var obs = create_obs("additionnal_conditions")
      var store = create_store();
      spyOn(store, 'dispatch');
      spyOn(obs.editor_additionnal_conditions, 'on').and.callThrough();
      // when
      clara.admin_edit_rule_dispatcher.please(store, obs);
      // then
      expect(store.dispatch).toHaveBeenCalledWith({ type: 'ADDITIONNAL_CONDITIONS_CHANGED', value: 42 });
      expect(obs.editor_additionnal_conditions.on).toHaveBeenCalledWith('change', jasmine.any(Function));
    });

    it('Dispatch WHAT_CHANGED if additionnal_conditions changed', function() {
      // given
      var obs = create_obs("what")
      var store = create_store();
      spyOn(store, 'dispatch');
      spyOn(obs.editor_what, 'on').and.callThrough();
      // when
      clara.admin_edit_rule_dispatcher.please(store, obs);
      // then
      expect(store.dispatch).toHaveBeenCalledWith({ type: 'WHAT_CHANGED', value: 42 });
      expect(obs.editor_what.on).toHaveBeenCalledWith('change', jasmine.any(Function));
    });
});
});
  

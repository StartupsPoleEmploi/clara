//= require_tree ../../app/assets/javascripts/administrate/custom/admin_edit_aid
describe('admin_edit_aid_reducer.js', function() {

  describe('.please', function() {
    it('Reduce state if additional conditions changed, without changing given state', function() {
      // given
      var state = {};
      var action = {type: "ADDITIONNAL_CONDITIONS_CHANGED", value: 42}
      // when
      var returned_state = clara.admin_edit_aid_reducer.please(state, action);
      // then
      expect(returned_state).toEqual({additionnal_conditions: 42});
      expect(state).toEqual({});
    });
    it('Reduce state if how_and_when changed, without changing given state', function() {
      // given
      var state = {};
      var action = {type: "HOW_AND_WHEN_CHANGED", value: 42}
      // when
      var returned_state = clara.admin_edit_aid_reducer.please(state, action);
      // then
      expect(returned_state).toEqual({how_and_when: 42});
      expect(state).toEqual({});
    });
    it('Reduce state if how_much changed, without changing given state', function() {
      // given
      var state = {};
      var action = {type: "HOW_MUCH_CHANGED", value: 42}
      // when
      var returned_state = clara.admin_edit_aid_reducer.please(state, action);
      // then
      expect(returned_state).toEqual({how_much: 42});
      expect(state).toEqual({});
    });
    it('Reduce state if limitations changed, without changing given state', function() {
      // given
      var state = {};
      var action = {type: "LIMITATIONS_CHANGED", value: 42}
      // when
      var returned_state = clara.admin_edit_aid_reducer.please(state, action);
      // then
      expect(returned_state).toEqual({limitations: 42});
      expect(state).toEqual({});
    });
    it('Reduce state if what changed, without changing given state', function() {
      // given
      var state = {};
      var action = {type: "WHAT_CHANGED", value: 42}
      // when
      var returned_state = clara.admin_edit_aid_reducer.please(state, action);
      // then
      expect(returned_state).toEqual({what: 42});
      expect(state).toEqual({});
    });
    it('Reduce state if title changed, without changing given state', function() {
      // given
      var state = {};
      var action = {type: "TITLE_CHANGED", value: 42}
      // when
      var returned_state = clara.admin_edit_aid_reducer.please(state, action);
      // then
      expect(returned_state).toEqual({title: 42});
      expect(state).toEqual({});
    });
    it('Reduce state if contract changed, without changing given state', function() {
      // given
      var state = {};
      var action = {type: "CONTRACT_CHANGED", value: 42}
      // when
      var returned_state = clara.admin_edit_aid_reducer.please(state, action);
      // then
      expect(returned_state).toEqual({contract: 42});
      expect(state).toEqual({});
    });
  });

});
  

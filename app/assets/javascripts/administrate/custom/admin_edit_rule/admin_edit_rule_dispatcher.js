clara.js_define("admin_edit_rule_dispatcher", {

  please_if: _.stubFalse,

  please: function(store, observables) {
    observables.editor_additionnal_conditions.on('change', function(){
      store.dispatch({
        type: 'ADDITIONNAL_CONDITIONS_CHANGED', 
        value: observables.editor_additionnal_conditions.getData() 
      })
    });
    observables.editor_how_and_when.on('change', function(){
      store.dispatch({
        type: 'HOW_AND_WHEN_CHANGED', 
        value: observables.editor_how_and_when.getData() 
      })
    });
    observables.editor_how_much.on('change', function(){
      store.dispatch({
        type: 'HOW_MUCH_CHANGED', 
        value: observables.editor_how_much.getData() 
      })
    });
    observables.editor_limitations.on('change', function(){
      store.dispatch({
        type: 'LIMITATIONS_CHANGED', 
        value: observables.editor_limitations.getData() 
      })
    });
    observables.editor_what.on('change', function(){
      store.dispatch({
        type: 'WHAT_CHANGED', 
        value: observables.editor_what.getData() 
      })
    });
    observables.$aid_name.on('keyup', function(e){
      var newVal = this.value;
      store.dispatch({
        type: 'TITLE_CHANGED', 
        value: newVal 
      })
    });
    observables.$aid_contract_type_id.on('change', function(e){
      var newVal = $(this).find("option:selected").text();
      store.dispatch({
        type: 'CONTRACT_CHANGED', 
        value: newVal
      })
    });
  }


});

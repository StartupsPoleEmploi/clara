clara.js_define("edit_admin_aid", {

  please_if: function() {
    return $(".js-aid-edition").exists();
  },

  please: function() {

    var editor_additionnal_conditions = CKEDITOR.instances['aid_additionnal_conditions']
    var editor_how_and_when = CKEDITOR.instances['aid_how_and_when']
    var editor_how_much = CKEDITOR.instances['aid_how_much']
    var editor_limitations = CKEDITOR.instances['aid_limitations']
    var editor_what = CKEDITOR.instances['aid_what']

    // QuickNDirty jQuery
    $("#aid_archived_at").attr("placeholder", "JJ/MM/AAAA");
    $(".c-aid-record").click(function(event){
      $("#modify-aid").click();
    });

    // Redux
    var global_state = {
      title: $("#aid_name").val(),
      additionnal_conditions: editor_additionnal_conditions.getData(),
      how_and_when: editor_how_and_when.getData(),
      how_much: editor_how_much.getData(),
      limitations: editor_limitations.getData(),
      what: editor_what.getData(),
      contract: $("#aid_contract_type_id :selected").text(),
    };
    
    // REDUCER
    var reducer = function(state, action) { 

      // Deep copy of previous state to avoid side-effects
      var newState = _.cloneDeep(state);

      if (action.type === 'INIT') {
        // do nothing
      } else if (action.type === 'ADDITIONNAL_CONDITIONS_CHANGED') {
        newState.additionnal_conditions = action.value
      } else if (action.type === 'HOW_AND_WHEN_CHANGED') {
        newState.how_and_when = action.value
      } else if (action.type === 'HOW_MUCH_CHANGED') {
        newState.how_much = action.value
      } else if (action.type === 'LIMITATIONS_CHANGED') {
        newState.limitations = action.value
      } else if (action.type === 'WHAT_CHANGED') {
        newState.what = action.value
      } else if (action.type === 'TITLE_CHANGED') {
        newState.title = action.value
      } else if (action.type === 'CONTRACT_CHANGED') {
        newState.contract = action.value
      }
      return newState;
    };

    // STORE
    window.main_store = Redux.createStore(reducer, global_state);

    // DISPATCHERS
    editor_additionnal_conditions.on('change', function(){
      main_store.dispatch({type: 'ADDITIONNAL_CONDITIONS_CHANGED', value: editor_additionnal_conditions.getData() })
    });
    editor_how_and_when.on('change', function(){
      main_store.dispatch({type: 'HOW_AND_WHEN_CHANGED', value: editor_how_and_when.getData() })
    });
    editor_how_much.on('change', function(){
      main_store.dispatch({type: 'HOW_MUCH_CHANGED', value: editor_how_much.getData() })
    });
    editor_limitations.on('change', function(){
      main_store.dispatch({type: 'LIMITATIONS_CHANGED', value: editor_limitations.getData() })
    });
    editor_what.on('change', function(){
      main_store.dispatch({type: 'WHAT_CHANGED', value: editor_what.getData() })
    });
    $("#aid_name").on('keyup', function(e){
      main_store.dispatch({type: 'TITLE_CHANGED', value: $("#aid_name").val() })
    });
    $("#aid_contract_type_id").on('change', function(e){
      main_store.dispatch({type: 'CONTRACT_CHANGED', value: $("#aid_contract_type_id :selected").text() })
    });



    // SUBSCRIBER
    main_store.subscribe(function(){
      var state = _.cloneDeep(main_store.getState());
      $(".js-title").html(state.title);
      $(".js-additionnal-conditions").html(state.additionnal_conditions);
      $(".js-how-and-when").html(state.how_and_when);
      $(".js-how-much").html(state.how_much);
      $(".js-limitations").html(state.limitations);
      $(".js-what").html(state.what);
      $(".js-contract").html(state.contract);
    });


    main_store.dispatch({type: 'INIT' })
  }

});

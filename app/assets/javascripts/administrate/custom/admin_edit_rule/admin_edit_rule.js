clara.js_define("edit_admin_aid", {

  please_if: function() {
    return $(".c-detail-title").exists();
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
    };
    
    // REDUCER
    var reducer = function(state, action) { 

      // Deep copy of previous state to avoid side-effects
      var newState = _.cloneDeep(state);

      if (action.type === 'SIMULATION_SUBMITTED') {
        newState.is_registerable = true;
      } else if (action.type === 'REPLAY') {
      } else if (action.type === 'INPUT_CHANGED') {
      }
      return newState;
    };

    // STORE
    window.main_store = Redux.createStore(reducer, global_state);

    // SUBSCRIBER
    main_store.subscribe(function(){
      var state = _.cloneDeep(main_store.getState());
    });

    // DISPATCHERS
    var $simulate = $("#btn_simulate");

    $simulate.on('click', function(){

    });

    main_store.dispatch({type: 'INIT' })
  }

});

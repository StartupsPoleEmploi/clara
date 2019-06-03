clara.js_define("admin_edit_rule", {

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
    var reducer = clara.admin_edit_rule_reducer.please;

    // STORE
    window.main_store = Redux.createStore(reducer, global_state);

    // DISPATCHERS
    clara.admin_edit_rule_dispatcher.please(main_store, {
      editor_additionnal_conditions: editor_additionnal_conditions,
      editor_how_and_when: editor_how_and_when,
      editor_how_much: editor_how_much,
      editor_limitations: editor_limitations,
      editor_what: editor_what,
      $aid_name: $("#aid_name"),
      $aid_contract_type_id: $("#aid_contract_type_id"),
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

clara.js_define("admin_edit_aid", {

  please_if: function() {
    return $(".js-aid-edition").exists();
  },

  
  please: /* istanbul ignore next */ function () {
    // QuickNDirty jQuery
    $("#aid_archived_at").attr("placeholder", "JJ/MM/AAAA");
    $(".c-aid-record").click(function(event){
      $("#modify-aid").click();
    });

    $(".js-collapse.is-fold").click(function (e) {
      e.stopPropagation()
      console.log("is-fold") 
    })
    $(".js-collapse.is-unfold").click(function (e) {
      e.stopPropagation()
      console.log("is-unfold") 
    })

    //Clean CKEDitor
    setTimeout(function() {
      clara.admin_edit_aid_clean_ckeditor.please();
    },1000);

    // Redux
    var observables = {      
      editor_additionnal_conditions: CKEDITOR.instances['aid_additionnal_conditions'],
      editor_how_and_when: CKEDITOR.instances['aid_how_and_when'],
      editor_how_much: CKEDITOR.instances['aid_how_much'],
      editor_limitations: CKEDITOR.instances['aid_limitations'],
      editor_what: CKEDITOR.instances['aid_what'],
      $aid_name: $("#aid_name"),
      $aid_contract_type_id: $("#aid_contract_type_id"),
    }
    
    var global_state = clara.admin_edit_aid_init.please(observables);

    // REDUCER
    var reducer = clara.admin_edit_aid_reducer.please;

    // STORE
    window.main_store = Redux.createStore(reducer, global_state);

    // DISPATCHERS
    clara.admin_edit_aid_dispatcher.please(main_store, observables);

    // SUBSCRIBER
    main_store.subscribe(function(){
      var state = _.cloneDeep(main_store.getState());
      clara.admin_edit_aid_subscriber.please(state);
    });

    main_store.dispatch({type: 'INIT' })
  }

});

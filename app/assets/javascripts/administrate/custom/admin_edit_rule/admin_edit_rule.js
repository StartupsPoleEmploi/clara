clara.js_define("admin_edit_rule", {

  please_if: function() {
    return $(".js-aid-edition").exists();
  },

  
  please: /* istanbul ignore next */ function () {
    // QuickNDirty jQuery
    $("#aid_archived_at").attr("placeholder", "JJ/MM/AAAA");
    $(".c-aid-record").click(function(event){
      $("#modify-aid").click();
    });

    //Clean CKEDitor
    setTimeout(function() {
      $(".cke_button__removeformat").remove();
      $(".cke_button__italic").remove();
      $(".cke_button__underline").remove();
      $(".cke_button__strike").remove();
      $(".cke_button__subscript").remove();
      $(".cke_button__superscript").remove();

      $(".cke_combo__styles").parent().remove(); // Styles, format, font
      
      // $(".cke_button__numberedlist_icon").parent().remove();
      // $(".cke_button__justifyleft").parent().parent().remove();
      $(".cke_button__creatediv").remove();
      $(".cke_button__blockquote").remove();
      $(".cke_button__numberedlist").remove();
      $(".cke_button__outdent").remove();
      $(".cke_button__indent").remove();
      $(".cke_button__justifycenter").remove();
      $(".cke_button__justifyright").remove();
      $(".cke_button__justifyblock").remove();
      $(".cke_button__unlink").remove();
      $(".cke_button__anchor").remove();

      $(".cke_button__image_icon").parent().parent().remove();
      $(".cke_button__source").parent().parent().remove();
      $(".cke_button__bgcolor").parent().parent().remove();
      $(".cke_button__paste").parent().parent().remove();


      $(".cke_button__bold").each(function(e){
        var $to_move = $(this).parent().parent();
        var $cke_toolbar = $to_move.parent().parent();
        var $link_button = $cke_toolbar.find(".cke_button__link").parent().parent();
        $to_move.appendTo($link_button);
      })

      // var $b = $(".cke_button__bold").parent().parent()
      // var $l = $(".cke_button__link").parent().parent()
      // $b.appendTo($l);
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
    
    var global_state = clara.admin_edit_rule_init.please(observables);

    // REDUCER
    var reducer = clara.admin_edit_rule_reducer.please;

    // STORE
    window.main_store = Redux.createStore(reducer, global_state);

    // DISPATCHERS
    clara.admin_edit_rule_dispatcher.please(main_store, observables);

    // SUBSCRIBER
    main_store.subscribe(function(){
      var state = _.cloneDeep(main_store.getState());
      clara.admin_edit_rule_subscriber.please(state);
    });

    main_store.dispatch({type: 'INIT' })
  }

});

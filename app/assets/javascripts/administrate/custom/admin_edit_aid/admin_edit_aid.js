clara.js_define("admin_edit_aid", {

  please_if: function () {
    return $(".js-aid-edition").exists();
  },


  please: /* istanbul ignore next */ function () {


    var selected_rule = $("#aid_rule_id").children("option:selected").html();

    if (_.isNotBlank(selected_rule)) {
      if (!_.includes(selected_rule, "_box")) {
        var warning_msg = "⚠ Attention cette aide a été créée de l'ancienne façon, si vous cliquez sur modifier et que vous enregistrez ensuite le champ d'application, les anciennes règles seront supprimées définitivement"
        $(".c-modify-appfield").html(warning_msg)
        $("#aid_rule_id").parent().parent().hide();
      } else {
        $("#aid_rule_id").parent().parent().hide();
      }
    } else {
      var help_msg = "Il n'existe pas encore de conditions pour cette aide."
      $(".c-modify-appfield").html(help_msg)
    }

    if ($("body").attr("data-path") === "new_admin_aid_path") {
      $("#aid_rule_id").parent().parent().hide();
    }

    // QuickNDirty jQuery
    $("#aid_archived_at").attr("placeholder", "JJ/MM/AAAA");
    $(".c-aid-record").click(function (event) {
      $("#modify-aid").click();
    });

    $(".js-collapse.is-unfold").click(function (e) {
      $(".js-accordion__header").each(function (e) {
        var $bar = $(this);
        if ($bar.attr("aria-expanded") === "false") {
          $bar.click()
        }
      })
      setTimeout(function () { $(".js-collapse.is-unfold").focus() }, 100)
    })

    //Clean CKEDitor
    setTimeout(function () {
      clara.admin_edit_aid_clean_ckeditor.please();
    }, 1000);

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
    main_store.subscribe(function () {
      var state = _.cloneDeep(main_store.getState());
      clara.admin_edit_aid_subscriber.please(state);
    });

    main_store.dispatch({ type: 'INIT' })
  }

});

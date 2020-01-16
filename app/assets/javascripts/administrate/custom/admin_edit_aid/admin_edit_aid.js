clara.js_define("admin_edit_aid", {

  please_if: function () {
    return $(".js-aid-edition").exists();
  },

  please: /* istanbul ignore next */ function () {
    var that = clara.admin_edit_aid;

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

    $(".js-accordion__header").click(function (e) {
      var targeted_accordion_tab_id = $(e.target).attr("id")
      $(".js-accordion__header").each(function (k) {
        var $bar_id = $(this).attr('id');
        if ($bar_id) {
          var accordion_id = $bar_id.substring(0, 13)
          var accordion_tab_id = accordion_id + "_tab"
          if (targeted_accordion_tab_id !== accordion_tab_id) {
            $("#" + accordion_tab_id).attr("aria-expanded", "false")
            $("#" + accordion_tab_id).attr("aria-selected", "false")
            $("#" + accordion_id).attr("aria-hidden", "true")
          }
        }
      })
    })

    _.executeAfter(that._destroy_ckeditors, 800)
    _.executeAfter(that._reload_ckeditors, 1000)
    setTimeout(function () {clara.admin_edit_aid_clean_ckeditor.please();}, 1200);

    setTimeout(function () {
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

    }, 1200);

  },

  _destroy_ckeditors: function() {
    CKEDITOR.instances.aid_what.destroy()
    $("textarea#aid_what").attr("placeholder", "Décrire en quelques lignes en quoi consiste l'aide globalement et pourquoi elle existe")
    CKEDITOR.instances.aid_how_much.destroy()
    $("textarea#aid_how_much").attr("placeholder", "Décrire l'aide de façon détaillée et en précisant ce à quoi elle donne droit.")
    CKEDITOR.instances.aid_limitations.destroy()
    $("textarea#aid_limitations").attr("placeholder", "Décrire ici les réserves, dérogations, liens utiles, commentaires...")
    CKEDITOR.instances.aid_how_and_when.destroy()
    $("textarea#aid_how_and_when").attr("placeholder", "Décrire de la façon la plus claire possible le processus pour bénéficier de l'aide. Si possible, mettre en lien une URL pour effectuer la demande (par exemple, vers le site de Pôle emploi ou le site du partenaire) ou le dossier à télécharger.")
    CKEDITOR.instances.aid_additionnal_conditions.destroy()
    $("textarea#aid_additionnal_conditions").attr("placeholder", "Indiquer dans ce champ les critères qui ne sont pas traités par le formulaire (par exemple : nombre et âge des enfants, plafond de ressources, coefficient familial...)")      
  },

  _reload_ckeditors: function() {
    var REMOVE_BUTTONS = 'Source,Save,NewPage,Preview,Print,Templates,Cut,Copy,Paste,PasteText,PasteFromWord,Undo,Redo,Find,Replace,SelectAll,Scayt,Form,Checkbox,Radio,TextField,Textarea,Select,Button,ImageButton,HiddenField,Italic,Strike,Subscript,Superscript,CopyFormatting,RemoveFormat,NumberedList,Outdent,Indent,Blockquote,CreateDiv,JustifyLeft,JustifyCenter,JustifyRight,JustifyBlock,BidiLtr,BidiRtl,Language,Unlink,Anchor,Image,Flash,Table,HorizontalRule,Smiley,PageBreak,Iframe,Styles,Format,Font,FontSize,TextColor,BGColor,Maximize,ShowBlocks,About'
    CKEDITOR.replace( 'aid_what', { extraPlugins : 'confighelper', removeButtons: REMOVE_BUTTONS});
    CKEDITOR.replace( 'aid_how_much', { extraPlugins : 'confighelper', removeButtons: REMOVE_BUTTONS});
    CKEDITOR.replace( 'aid_limitations', { extraPlugins : 'confighelper', removeButtons: REMOVE_BUTTONS});
    CKEDITOR.replace( 'aid_how_and_when', { extraPlugins : 'confighelper', removeButtons: REMOVE_BUTTONS});
    CKEDITOR.replace( 'aid_additionnal_conditions', { extraPlugins : 'confighelper', removeButtons: REMOVE_BUTTONS});
  },



});

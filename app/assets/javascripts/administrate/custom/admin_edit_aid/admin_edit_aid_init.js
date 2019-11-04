clara.js_define("admin_edit_aid_init", {

  please_if: _.stubFalse,

  please: function(o) {

    return {
        title:                  o.$aid_name.val(),
        additionnal_conditions: o && o.editor_additionnal_conditions ? o.editor_additionnal_conditions.getData() : null,
        how_and_when:           o && o.editor_how_and_when ? o.editor_how_and_when.getData() : null,
        how_much:               o && o.editor_how_much ? o.editor_how_much.getData() : null,
        limitations:            o && o.editor_limitations ? o.editor_limitations.getData() : null,
        what:                   o && o.editor_what ? o.editor_what.getData() : null,
        contract:               o.$aid_contract_type_id.find("option:selected").text()
      }
  }


});

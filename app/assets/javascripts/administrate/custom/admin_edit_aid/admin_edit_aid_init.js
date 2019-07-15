clara.js_define("admin_edit_aid_init", {

  please_if: _.stubFalse,

  please: function(o) {
    return {
        title:                  o.$aid_name.val(),
        additionnal_conditions: o.editor_additionnal_conditions.getData(),
        how_and_when:           o.editor_how_and_when.getData(),
        how_much:               o.editor_how_much.getData(),
        limitations:            o.editor_limitations.getData(),
        what:                   o.editor_what.getData(),
        contract:               o.$aid_contract_type_id.find("option:selected").text()
      }
  }


});

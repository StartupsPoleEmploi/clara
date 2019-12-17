clara.js_define("new_are_question", {

  please: function() {
    //https://stackoverflow.com/a/24271309/2595513
    $('input#montant').on('input', function(e) {
        var value = $(this).val().replace("." ,",");
        var invalid_char_function = function(e){return !_.includes("0123456789,",e)};
        var invalid_char = _.find(value, invalid_char_function);
        value = value.replace(invalid_char, "")
        value = _.keepOnlyLast(value, ",")
        $(this).val(value)
    });
  },

});
  

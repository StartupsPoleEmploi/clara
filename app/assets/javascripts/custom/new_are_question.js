clara.js_define("new_are_question", {

  please: function() {

    $.betterFloat($('input#montant'))
    
    $('input#montant').on('input', function(e) { $.betterFloat($(this)) })

  },

});
  

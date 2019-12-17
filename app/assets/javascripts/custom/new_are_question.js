clara.js_define("new_are_question", {

  please: function() {

    $('input#montant').val($.betterFloat($('input#montant').val()))
    
    $('input#montant').on('input', function(e) { $(this).val($.betterFloat($(this).val())) })

  },

});
  

$( document ).ready(function() {
  if ($('body').hasClass('inscription_questions')) {
    while($('input#plus_d_un_an').position().left >= $('input#non_inscrit').position().left) {
      $('input#non_inscrit').parent().css({"margin-left": '+=1px' });
    }
    while($('input#plus_d_un_an').position().left >= $('input#moins_d_un_an').position().left) {
      $('input#moins_d_un_an').parent().css({"margin-left": '+=1px' });
    }
    $('input#moins_d_un_an').parent().css({"margin-left": '-=1px' });
    $('input#non_inscrit').parent().css({"margin-left": '-=1px' });
  }
});



clara.js_define("admin_convention", {

  please: function() {
    $('section.history').hide();
    $('.js-convention-details').show();

    $('.js-history').click(function (e) {
      if ($('.js-history').text().indexOf('détail') > 0) {
        $('section.history').hide();
        $('.js-convention-details').show();
        $('.js-history').text("Voir l'historique")
        $('.main-content__page-title').text('Historique de la charte')
      } else {
        $('section.history').show();
        $('.js-convention-details').hide();
        $('.js-history').text('Revenir au détail')
        $('.main-content__page-title').text('Historique de la charte')
      }
    });
  }

});

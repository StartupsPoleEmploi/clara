clara.js_define("wrap_outbound_link", {

  please_if: function() {
    return $("a").filter(function() {
      return this.href==="https://candidat.pole-emploi.fr/prestations/servicescarte"
    }).length > 0;
  },

  please: function(url) {

    var THE_URL = "https://candidat.pole-emploi.fr/prestations/servicescarte";

    $("a")
      .filter(function() {
        return this.href === THE_URL;
      })
      .each(function() {
        var actual_target = $(this).attr('target');
        $(this).attr(
          "onclick", 
          "clara.track_outbound_link.please('" + THE_URL + "', '" + actual_target + "');return false;"
        );
      });

  }

});

clara.js_define("wrap_outbound_link", {

  _THE_URL: "https://candidat.pole-emploi.fr/prestations/servicescarte",

  please_if: function() {
    var that = clara.wrap_outbound_link;
    return $("a").filter(function() {
      return this.href === that._THE_URL
    }).length > 0;
  },

  please: function(url) {
    var that = clara.wrap_outbound_link;

    $("a")
      .filter(function() {
        return this.href === that._THE_URL;
      })
      .each(function() {
        var actual_target = $(this).attr('target');
        $(this).attr(
          "onclick", 
          "clara.track_outbound_link.please('" + that._THE_URL + "', '" + actual_target + "');return false;"
        );
      });

  }

});

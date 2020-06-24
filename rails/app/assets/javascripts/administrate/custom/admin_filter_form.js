clara.js_define("admin_filter_form", {

    please_if: function() {
      return $(".actual-filter-form").exists();
    },

    please: function() {

      $("input#filter_name").attr("autocomplete", "off");
      $("input#filter_ordre_affichage").attr("autocomplete", "off");
      $("input#filter_author").attr("autocomplete", "off");

      $(".field-unit--active-storage").prepend("<div class='c-aid-filters-hint'>Optionnel : vous pouvez faire apparaître ce filtre en page d'accueil en renseignant une photo d'illustration ainsi que le crédit photo qui y est rattaché</div>")
      $(".field-unit--active-storage .field-unit__field").css("display", "flex")

      var $elt = $("#filter_attachment").parent();
      $elt.html($elt.children());
      $elt.prepend("Remplacer :");

      // $("#filter_attachment").parent().css("margin-left", "5rem")
      $(".attachments-listing").css("margin-right", "5rem")
      $("#filter_attachment").parent().css("margin-top", "-1.5rem")
    },
});


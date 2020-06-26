clara.js_define("admin_filter_form", {

    please_if: function() {
      return $(".actual-filter-form").exists();
    },

    please: function() {

      $("input#filter_name").attr("autocomplete", "off");
      $("input#filter_ordre_affichage").attr("autocomplete", "off");
      $("input#filter_author").attr("autocomplete", "off");

      $(".field-unit--paperclip").prepend("<div class='c-aid-filters-hint'>Optionnel : vous pouvez faire apparaître ce filtre en page d'accueil en renseignant une photo d'illustration, et en créditant l'auteur</div>")

    },
});


clara.js_define("admin_filter_form", {

    please_if: function() {
      return $(".actual-filter-form").exists();
    },

    please: function() {

      $("input#filter_name").attr("autocomplete", "off");
      $("input#filter_ordre_affichage").attr("autocomplete", "off");
      $("input#filter_author").attr("autocomplete", "off");

      $(".field-unit--active-storage").prepend("<div class='c-aid-filters-hint'>Optionnel : vous pouvez faire apparaître ce filtre en page d'accueil en renseignant une photo d'illustration, et en créditant l'auteur</div>")
      $(".field-unit--active-storage .field-unit__field").css("display", "flex")


      $(".attachments-listing").css("margin-right", "5rem")
      $("#filter_attachment").parent().css("margin-top", "-1.5rem")
      
      if ($("#new_filter").length) {
        $(".field-unit--active-storage .field-unit__label").remove()
        $("#filter_attachment").parent().css("margin-top", "0")
      }

      if ($("#error_explanation").length) {
        var $dtach = $(".c-aid-filters-hint").detach()
        $(".field-unit--active-storage").prepend($dtach)
      }

      var choose_txt = "Choisir une photo d'illustration : "
      if ($(".attachments-listing").length === 0) {
        $(".field-unit--active-storage .field-unit__label").remove()
        $("#filter_attachment").parent().css("margin-top", "0")
      } else  {
        choose_txt = "Remplacer la photo d'illustration :"
      }

      var $elt = $("#filter_attachment").parent();
      $elt.html($elt.children());
      $elt.prepend(choose_txt);
    },
});


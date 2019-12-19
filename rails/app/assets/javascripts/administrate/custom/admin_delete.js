clara.js_define("admin_delete", {

    please_if: function() {
      return $("body").attr("data-path") === "admin_contract_types_path" && $("a[data-confirm]").length > 0;
    },

    please: function() {


      $.rails.allowAction = function(link) {
        if (!link.attr('data-confirm')) { 
          return true; 
        }
        if (link.attr('data-aidsize') === "0") {
          showConfirmDialog(link); // look below for implementations
        } else {
          showRefuseDialog(link); // look below for implementations
        }
        return false; // always stops the action since code runs asynchronously
      };

      var showRefuseDialog = function(link) {

        // Change text inside modal
        $(".c-deletion-title strong").text("Suppression impossible");
        $(".c-deletion-firstline").hide();
        $(".c-deletion-confirm").hide();
        $(".c-deletion-lastline").text("Il reste une ou plusieurs aides rattachées à cette rubrique.")

        //trigger modal
        $("button.c-deletion").click();

        // setup backfocus
        var id = (new Date()).getTime();
        $("#label_modal_1").attr("id", "label_modal_1_" + id);
        $(link).attr("id", "label_modal_1");
        $("#js-modal-close").attr("data-focus-back", "label_modal_1");

        // inject contract name
        var contract_name = $(link).parent().parent().find(".cell-data--string").text().trim();
        $(".c-deletion-name").text(contract_name);

        // if user confims, then go delete the item
        $("button.c-deletion-confirm").on("click", function(){confirmed(link)});
      };

      var showConfirmDialog = function(link) {

        // Change text inside modal
        $(".c-deletion-title strong").text("Suppression d'une rubrique")
        $(".c-deletion-firstline").show();
        $(".c-deletion-confirm").show();
        $(".c-deletion-lastline").text("Êtes vous sûr•e de votre choix ? Une fois confirmée, cette opération est définitive.")

        //trigger modal
        $("button.c-deletion").click();

        // setup backfocus
        var id = (new Date()).getTime();
        $("#label_modal_1").attr("id", "label_modal_1_" + id);
        $(link).attr("id", "label_modal_1");
        $("#js-modal-close").attr("data-focus-back", "label_modal_1");

        // inject contract name
        var contract_name = $(link).parent().parent().find(".cell-data--string").text().trim();
        $(".c-deletion-name").text(contract_name);

        // if user confims, then go delete the item
        $("button.c-deletion-confirm").on("click", function(){confirmed(link)});
      };


      var confirmed = function(link) {
        $('body').pleaseWait();
        link.removeAttr('data-confirm');
        return link.trigger('click.rails');
      };


  }

});


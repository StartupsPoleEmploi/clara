clara.js_define("admin_edit_rule_clean_ckeditor", {

  please_if: _.stubFalse,

  
  please: function () {
      $(".cke_button__removeformat").remove();
      $(".cke_button__italic").remove();
      $(".cke_button__underline").remove();
      $(".cke_button__strike").remove();
      $(".cke_button__subscript").remove();
      $(".cke_button__superscript").remove();

      $(".cke_combo__styles").parent().remove();
      
      $(".cke_button__creatediv").remove();
      $(".cke_button__blockquote").remove();
      $(".cke_button__numberedlist").remove();
      $(".cke_button__outdent").remove();
      $(".cke_button__indent").remove();
      $(".cke_button__justifycenter").remove();
      $(".cke_button__justifyleft").remove();
      $(".cke_button__justifyright").remove();
      $(".cke_button__justifyblock").remove();
      $(".cke_button__unlink").remove();
      $(".cke_button__anchor").remove();

      $(".cke_button__image_icon").parent().remove();
      $(".cke_button__flash").remove();
      $(".cke_button__table").remove();
      $(".cke_button__horizontalrule").remove();

      $(".cke_button__source").parent().parent().remove();
      $(".cke_button__bgcolor").parent().parent().remove();
      $(".cke_button__paste").parent().parent().remove();

      $(".cke_toolbar_separator").last().remove();


      $(".cke_button__bold").each(function(e){
        var $to_move = $(this).parent().parent();
        var $cke_toolbar = $to_move.parent().parent();
        var $link_button = $cke_toolbar.find(".cke_button__link").parent().parent();
        $to_move.appendTo($link_button);
      });


      $(document).on('focusin.modal', function (e) {
        $("a.cke_dialog_tab[title='Link Info']").text("Affichage");
        $("a.cke_dialog_tab[title='Target']").text("Fenêtre");
        $("a.cke_dialog_tab[title='Advanced']").text("Avancé");
        // if ($(".cke_dialog_tab").exists()) {
        //   $(".cke_dialog_title").text("Lien");
        // }
        $("a.cke_dialog_tab[title='Upload']").remove();
        $("a[title='Browse Server']").parent().parent().remove();
        
        var $protocol = $("label:contains('Protocol')")
        $protocol.text("Protocole")
        var $protocol_gdparent = $protocol.parent().parent()
        $protocol_gdparent.css("padding-left", "0")
        $protocol_gdparent.parent().closest("td").css("padding-left", "0")
        $("option[value='ftp://']").remove();
        $("option[value='news://']").remove();

        var $disp_txt = $("label:contains('Display Text')");
        $disp_txt.text("Texte affiché")
        var $td_txt_lnk = $disp_txt.parent().parent();
        $td_txt_lnk.find("input").css("width", "250px");
        var $div_lnk_typ = $("label:contains('Link Type')").parent();
        $div_lnk_typ.appendTo($td_txt_lnk);
        $td_txt_lnk.css("display", "flex");
        $div_lnk_typ.css("visibility", "hidden");

        $("label:contains('Target')").text("Ouverture de fenêtre");
        var $target_select = $("option[value='_blank']").parent();
        $target_select.css("width", "250px !important")

        $target_select.find("option").each(function(e){
          var $that = $(this);
          var val = $that.attr("value");
          console.log(val)
          if (val === "_blank") {
            $that.text("Nouvelle fenêtre (_blank)")
          } else if (val === "_self") {
            $that.text("Même fenêtre (_self)")
          } else {
            $that.remove();
          }
        });
      });

  }

});

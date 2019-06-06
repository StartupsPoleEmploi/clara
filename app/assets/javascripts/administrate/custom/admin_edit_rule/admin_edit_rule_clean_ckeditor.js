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
        $("a.cke_dialog_tab[title='Target']").text("Cible");
        $("a.cke_dialog_tab[title='Advanced']").text("Avancé");
        $(".cke_dialog_title").text("Lien");
        $("a.cke_dialog_tab[title='Upload']").remove();
        $("a[title='Browse Server']").parent().parent().remove();
        
        var $protocol = $("label:contains('Protocol')").parent()
        var $protocol_parent = $protocol.parent()
        $protocol_parent.css("padding-left", "0")
        $protocol_parent.parent().closest("td").css("padding-left", "0")

        var $td_txt_lnk = $("label:contains('Display Text')").parent().parent();
        var $div_lnk_typ = $("label:contains('Link Type')").parent();
        $div_lnk_typ.appendTo($td_txt_lnk);
        $td_txt_lnk.css("display", "flex");
        $div_lnk_typ.css("visibility", "hidden");
      });

  }

});

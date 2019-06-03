clara.js_define("edit_admin_aid", {

  please: function() {
    $("#aid_archived_at").attr("placeholder", "JJ/MM/AAAA");
    $(".c-aid-record").click(function(event){
      $("#modify-aid").click();
    });
  }

});

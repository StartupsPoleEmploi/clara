clara.load_js(function only_if(){return $("body").hasClasses("welcome", "index")}, function() {

  store.clearAll();
  console.log("Version : " + clara.version);


  $("#myModal").on("hidden.bs.modal",function(){
    $("#iframeYoutube").attr("src","#");
  })

  function changeVideo(vId){
    var iframe=document.getElementById("iframeYoutube");
    iframe.src="https://www.youtube.com/embed/"+vId;

    $("#myModal").modal("show");
  }


});

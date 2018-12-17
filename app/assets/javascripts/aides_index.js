clara.load_js(function only_if(){return $("body").hasClasses("aides", "index")}, function main_function() {

  console.log("aides index");

  change_placeholder();

  $( window ).resize(function() {
    change_placeholder();
  });

  function change_placeholder() {
   if ($( window ).width() < 530) {
     $("#usearch_input").attr("placeholder", "Rechercher");
   } else {
     $("#usearch_input").attr("placeholder", "Rechercher une aide ou un mot clé");
   }  
  }

});

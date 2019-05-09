clara.js_define("admin_modify_ct", {


    please_if: function() {
      return $("form#new_contract_type").length > 0;
    },

    please: function() {
      var that = this;

      // multiple buttons for submit
      $(".c-ct-record").click(function (event) {
        $("#create-ct").click();
      });

      $('#contract_type_name').on('input', function(event) {
        $("#contract_type_plural").val($('#contract_type_name').val() + "s")
      });
      
      setTimeout(function(e){
        if (!_.isBlank($('#contract_type_icon').val())){
          $(".field-unit-svg-preview__img").html($('#contract_type_icon').val());
        }
      }, 100)

      // hide the str input, and show the file input
      var $str_icon = $("#contract_type_icon").parent().parent();
      $str_icon.addClass("hidden");
      $str_icon.after(that.constants.tpl_icon_file);

      $('input#contract_type_icon_file').change(function(){
         var svg_text = that.handleFileSelect();
         that.receivedText();         
      });

    },

    handleFileSelect: function() {     
      var that = this;          
      var res = "";
      if (!window.File || !window.FileReader || !window.FileList || !window.Blob) {
        console.error("The File APIs are not fully supported in this browser.");
        return;
      }   

      var input = document.getElementById("contract_type_icon_file");
      if (!input) {
        console.error("Um, couldn't find the fileinput element.");
      }
      else if (!input.files) {
        console.error("This browser doesn't seem to support the `files` property of file inputs.");
      }
      else if (!input.files[0]) {
        console.error("Please select a file before clicking 'Load'");               
      }
      else {
        var file = input.files[0];
        fr = new FileReader();
        fr.readAsText(file);
        fr.onload = that.receivedText;
      }
      return res;
    },

    receivedText: function() {
      var actual_svg_text = fr.result;
      $('#contract_type_icon').val(actual_svg_text);
      $(".field-unit-svg-preview__img").html(actual_svg_text);
      // if you want to reset the input file, uncomment below
      // document.getElementById("contract_type_icon_file").value = "";
    },

    constants: {
      tpl_icon_file: 
        '<div class="field-unit-svg-container">' +
          '<div class="field-unit-svg-preview">' +
            '<div class="field-unit-svg-preview__title">' +
              '<strong>' +
                'Icône choisie' +
              '</strong>' +
            '</div>' +
            '<div class="field-unit-svg-preview__img">' +
              'Aucune image' +
            '</div>' +
          '</div>' +
          '<div class="field-unit field-unit--svg-file-field c-ct-change-icon">' +
            '<div class="field-unit__label">' +
                '<label for="contract_type_icon_file">Changer icône</label>' +
            '</div>' +
            '<div class="field-unit__field">' +
               '<input accept=".svg" type="file" id="contract_type_icon_file">' +
            '</div>' +
          '</div>' +
        '</div>' 
    },
});


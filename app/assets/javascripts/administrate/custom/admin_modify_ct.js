clara.js_define("admin_modify_ct", {


    please_if: function() {
      return $("form#new_contract_type").length > 0;
    },

    please: function() {
      var that = this;
      var $str_icon = $("#contract_type_icon").parent().parent();
      $str_icon.addClass("hidden");
      $str_icon.after(that.constants.tpl_icon_file);

      $('input#contract_type_icon_file').change(function(){
         var svg_text = that.handleFileSelect();
         that.receivedText(svg_text);
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
      $('#contract_type_icon').val(fr.result);
    },

    constants: {
      tpl_icon_file: '<div class="field-unit field-unit--svg-file-field field-unit--errored-false">' +
              '<div class="field-unit__label">' +
                  '<label for="contract_type_icon_file">Icône</label>' +
              '</div>' +
              '<div class="field-unit__field">' +
                 '<input accept=".svg" type="file" id="contract_type_icon_file">' +
              '</div>' +
          '</div>'
    },
});


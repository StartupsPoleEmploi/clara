clara.js_define("admin_rulecreation", {

    please_if: function() {
      return $(".c-rulecreation").exists();
    },

    please: function() {


        $('ul.sortable').sortable({
          connectWith: 'ul.sortable',
          placeholder: 'placeholder',
          update: function (e) {
            var container = e.target;
            var deplaced = e.toElement;
            
            var kind = container.getAttribute("data-type")
            deplaced.closest("li").childNodes[0].nodeValue = kind;
          },
          start: function (e) {
            var deplaced = e.toElement;
            deplaced.closest("li").childNodes[0].nodeValue = "";
          },
          stop: function (e) {
          },
        }).disableSelection();

    
    }

});


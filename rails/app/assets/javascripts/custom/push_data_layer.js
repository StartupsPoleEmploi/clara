clara.js_define("push_data_layer", {

  please_if: _.stubTrue,

  please: function () {

    function pushDataLayer(){
      if (window.dataLayer) {
        console.log('pushing dataLayer');
        window.dataLayer.push({ 'is-connected': $('body').data('connect') === true ? '1' : '0' })
      }
    }
    
    setTimeout(pushDataLayer, 1000);
  },

});


clara.load_js(function only_if(){return true}, function() {

  var lazyImages = document.querySelectorAll('img[data-src]');

  _.each(lazyImages, function(image){

    var actual_src = image.getAttribute('data-src');

    if (actual_src) {
      $.cacheImage(actual_src, {
        load    : function (e) {
          image.setAttribute('src', actual_src);
          image.removeAttribute('data-src');
          // console.log('Loaded',    this, e); 
        },
        error   : function (e) { 
          console.log('Error',     this, e); 
        },
        abort   : function (e) { 
          console.log('Aborted',   this, e); 
        },
        // complete callback is called on load, error and abort
        complete: function (e) { 
          // console.log('Completed', this, e); 
        }
      });
    }
  });
});


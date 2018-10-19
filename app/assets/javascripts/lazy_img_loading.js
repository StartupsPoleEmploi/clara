load_js_for_page([], function() {


// Determine the images to be lazy loaded
var lazyImages = document.querySelectorAll('img[data-src]');

// Check for Cache support
if (window.caches) {
  var lazyImages = Array.prototype.slice.call(document.querySelectorAll('img[data-src]'));

  Promise.all(lazyImages.map(img => {
    var src = img.getAttribute('data-src');

    // Check if response for this image is cached
    return window.caches.match(src).
      then(response => {
        if (response) {
          // The image is cached - load it
          img.setAttribute('src', src);
          img.removeAttribute('data-src');
        }
      })
      })).
      then(initialiseLazyLoading); // finished loads from cache, lazy load others
} else {
  // cache not supported - lazy load all
  initialiseLazyLoading();
}

function initialiseLazyLoading() {
  // Determine the images to be lazy loaded
  var lazyImages = document.querySelectorAll('img[data-src]');

  // ... set up lazy loading
  for (var i=0; i<lazyImages.length; i++) {
    if (lazyImages[i].getAttribute('data-src')) {
      lazyImages[i].setAttribute('src', lazyImages[i].getAttribute('data-src'));
      lazyImages[i].removeAttribute('data-src');
    }
  }
}





});

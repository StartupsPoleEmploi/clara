$( document ).ready(function() {
  if ($('body').hasClass('welcome', 'index')) {
    if (localStorage) {
      localStorage.clear();
    }
  }
});

  function _click_on(the_main, the_selector) {
    var elt = the_main.$el.querySelector(the_selector);
    var evt = new window.Event('click');
    elt.dispatchEvent(evt);
    the_main._watcher.run();
  }

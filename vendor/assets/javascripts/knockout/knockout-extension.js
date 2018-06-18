ko.bindingHandlers.winsize = {
    init: function (element, valueAccessor) {

      function setVal() {
        var value = valueAccessor();
        value({ width: $(window).width(), height: $(window).height() });        
      }      

      // first initialization
      setVal();

      // recall on resize
      $(window).resize(setVal);

    }
}

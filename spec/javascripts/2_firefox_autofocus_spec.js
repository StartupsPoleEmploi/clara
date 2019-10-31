describe('firefox_autofocus.js', function() {
    it("Should not focus on input without autofocus", function() {
      $(document.body).append("<form><input></input></form>")
      $("input").addClass("without_autofocus")
      expect($('input.without_autofocus').is(":focus")).toEqual(false)
    });
    it("Should focus on input with autofocus", function() {
      $(document.body).append("<form><input></input></form>")
      $("input").addClass("with_autofocus")
      $("input.with_autofocus").attr('autofocus', 'autofocus');
      expect($('input.with_autofocus').is(":focus")).toEqual(true)
    });
});

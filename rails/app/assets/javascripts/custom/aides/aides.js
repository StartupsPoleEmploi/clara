clara.js_define("aides", {

  please: function() {

    
    $(".js-resulteligy-share").click(function(e) {
      if (typeof ga === "function") {
        ga("send", "event", "results", "share", document.location.pathname);
      }
      var lenTwo = function(val){
        if (val.toString().length === 1) {
          return ('0'+val)
        } else {
          return val;
        }
      }
      var d = new Date();
      var now = lenTwo(d.getDay()) +"/"+lenTwo(d.getMonth())+"/"+d.getFullYear();
      var subject = 'Ma simulation d\'aides Clara du ' + now;
      var body = window.location.href;
      window.location.href = 'mailto:?subject=' + subject + '&body=' + body;
    });


    window.main_store = 
      Redux.createStore(
        clara.aides_main_reducer.please, 
        clara.aides_default_state.please()
      );


    main_store.subscribe(clara.aides_main_subscriber.please);

    // fire initial state
    main_store.dispatch({type: 'INIT'});

    clara.aides_main_dispatcher.please();


  }

});

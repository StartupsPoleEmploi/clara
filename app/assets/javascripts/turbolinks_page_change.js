$(document).on('ready page:load', function () {

  $('form').on("ajax:success", function(event, data) {
    console.log('ajax success !!');
    console.log(event);
    var want_to_go = _.get(event, 'detail.0.want_to_go');
    if (want_to_go) Turbolinks.visit(want_to_go);    
  });

});

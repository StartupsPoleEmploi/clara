$( document ).ready(function() {

  function treat_successfully_retrieved_filters(aids) {
    console.log("aids are " + JSON.stringify(aids[0]))
  }

  if (window.location.pathname === "/admin/aids") {
    // console.log('You are now on admin aids collection');

    var need_filters_position = -1;
    var clara_filters_position = -1;
    var custom_filters_position = -1;
    var id_position = -1;
    $('th[role="columnheader"]').each(function(current_index, elt) {
      function endsWith(str, suffix) {
        return str.indexOf(suffix, str.length - suffix.length) !== -1;
      }
      if (endsWith($(elt).find('a').attr('href'), "=custom_filters")) {
        custom_filters_position = current_index;
      }
      if (endsWith($(elt).find('a').attr('href'), "=need_filters")) {
        need_filters_position = current_index;
      }
      if (endsWith($(elt).find('a').attr('href'), "=filters")) {
        clara_filters_position = current_index;
      }
      if (endsWith($(elt).find('a').attr('href'), "=id")) {
        id_position = current_index;
      }
    });
    console.log('need_filters_position ' + need_filters_position)
    console.log('clara_filters_position ' + clara_filters_position)
    console.log('custom_filters_position ' + custom_filters_position)
    console.log('id_position ' + id_position)


    var displayed_ids = []
    $('.js-table-row').each(function(i,e) {
      var id_as_string = $(e).find("td:eq(" + id_position + ")").text().trim();

      displayed_ids.push(parseInt(id_as_string, 10));

    });
      console.log(displayed_ids);

    $.ajax({
        url: "/admin/find_filters",
        type:'GET',
        dataType:'json',
        data:{
          ids: displayed_ids
          // authenticity_token: window._token
        },
        success:function(data){
          // console.log(data);
          treat_successfully_retrieved_filters(data["aids"])
        },
        error:function(data){
          console.log("error");
          console.error(data);
        }
      });

  }
});

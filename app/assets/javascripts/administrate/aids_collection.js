$( document ).ready(function() {

  // from https://stackoverflow.com/a/3855394/2595513
  function query_string(a) {
    if (a == "") return {};
    var b = {};
    for (var i = 0; i < a.length; ++i)
    {
        var p=a[i].split('=', 2);
        if (p.length == 1)
            b[p[0]] = "";
        else
            b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
    }
    return b;
  }

  function endsWith(str, suffix) {
    return str.indexOf(suffix, str.length - suffix.length) !== -1;
  }

  function clean_column_of(stuff) {
    extract_column_for(stuff).each(function(i,e){$(e).empty();});
  }

  function treat_successfully_retrieved_filters(aids) {
    var items = ["filters", "need_filters", "custom_filters"]
    _.each(items, clean_column_of);
    _.each(aids, function(aid) {
      var $row = find_row_whose_id_is(aid["id"]);
      _.each(items, function(item) {
        var $cell = find_cell_for($row, item);
        _.each(aid[item], function(filter_obj){
          $cell.append("<div class='ftag'>" + filter_obj["slug"] + "</div>")
        });
      })
    });
  }

  function find_cell_for(jq_row, filter_column_name) {
    var col_nb = find_col_nb_for(filter_column_name);
    // console.log(col_nb);
    return $(jq_row).find("td:eq(" + col_nb + ")");
  }

  function find_row_whose_id_is(id_value) {
    var id_col_nb = find_col_nb_for("id");
    // console.log(id_col_nb)
    var id_value_as_str = id_value.toString();
    // console.log(id_value_as_str)
    return $('.js-table-row').filter(function(i, e) {
      var id_as_string = $(e).find("td:eq(" + id_col_nb + ")").text().trim();
      // console.log(id_as_string)
      // console.log(id_value_as_str)
      // console.log("")
      return id_value_as_str === id_as_string;
    });
  }

  function find_col_nb_for(stuff) {
    var id_col_nb = -1;
    $('th[role="columnheader"]').each(function(current_index, elt) {
      var href_value = $(elt).find('a').attr('href');
      var current_target = href_value.split("order=")[1].split("&")[0];  
      if (current_target === stuff) {
        id_col_nb = current_index;
      }
    });
    return id_col_nb;
  }

  function extract_column_for(stuff) {
    var col_nb = find_col_nb_for(stuff);
    return $('tr.js-table-row td:nth-child('+ (col_nb+1) +')');
  }

  if (window.location.pathname === "/admin/aids") {

    var displayed_ids = []
    $('.js-table-row').each(function(i,e) {
      var id_as_string = $(e).find("td:eq(" + find_col_nb_for("id") + ")").text().trim();
      displayed_ids.push(parseInt(id_as_string, 10));
    });
      console.log(find_col_nb_for("id"));
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

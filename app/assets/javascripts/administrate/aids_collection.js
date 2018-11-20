$( document ).ready(function() {

  function endsWith(str, suffix) {
    return str.indexOf(suffix, str.length - suffix.length) !== -1;
  }

  function treat_successfully_retrieved_filters(aids) {
    _.each(aids, function(aid) {
      var $row = find_row_whose_id_is(aid["id"]);
      var $cell = find_cell_for($row, "filters");
      $cell.empty();
      _.each(aid["filters"], function(filter_obj){
        $cell.append("<div class='ftag'>" + filter_obj["slug"] + "</div>")
      });
      var $cell = find_cell_for($row, "need_filters");
      $cell.empty();
      _.each(aid["need_filters"], function(filter_obj){
        $cell.append("<div class='ftag'>" + filter_obj["slug"] + "</div>")
      });
      var $cell = find_cell_for($row, "custom_filters");
      $cell.empty();
      _.each(aid["custom_filters"], function(filter_obj){
        $cell.append("<div class='ftag'>" + filter_obj["slug"] + "</div>")
      });
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
      if (endsWith($(elt).find('a').attr('href'), "="+stuff)) {
        id_col_nb = current_index;
      }
    });
    return id_col_nb;
  }

  if (window.location.pathname === "/admin/aids") {

    var displayed_ids = []
    $('.js-table-row').each(function(i,e) {
      var id_as_string = $(e).find("td:eq(" + find_col_nb_for("id") + ")").text().trim();

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

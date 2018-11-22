
_.set(window, 'clara.aids.find_col_nb_for', function(stuff) {
    var id_col_nb = -1;
    $('th[role="columnheader"]').each(function(current_index, elt) {
      var href_value = $(elt).find('a').attr('href');
      var current_target = href_value.split("order=")[1].split("&")[0];  
      if (current_target === stuff) {
        id_col_nb = current_index;
      }
    });
    return id_col_nb;
});

_.set(window, 'clara.aids.extract_column_for', function(stuff) {
    var col_nb = clara.aids.find_col_nb_for(stuff);
    return $('tr.js-table-row td:nth-child('+ (col_nb+1) +')');
});

_.set(window, 'clara.aids.clean_column_of', function(stuff) {
  clara.aids.extract_column_for(stuff).each(function(i,e){$(e).empty();});
});

_.set(window, 'clara.aids.find_row_whose_id_is', function(id_value) {
  var id_col_nb = clara.aids.find_col_nb_for("id");
  var id_value_as_str = id_value.toString();
  return $('.js-table-row').filter(function(i, e) {
    var id_as_string = $(e).find("td:eq(" + id_col_nb + ")").text().trim();
    return id_value_as_str === id_as_string;
  });
});

_.set(window, 'clara.aids.find_cell_for', function(jq_row, filter_column_name) {
  var col_nb = clara.aids.find_col_nb_for(filter_column_name);
  return $(jq_row).find("td:eq(" + col_nb + ")");
});

_.set(window, 'clara.aids.treat_successfully_retrieved_filters', function(aids) {
  var items = ["filters", "need_filters", "custom_filters"];
  _.each(items, clara.aids.clean_column_of);
  _.each(aids, function(aid) {
    var $row = clara.aids.find_row_whose_id_is(aid["id"]);
    _.each(items, function(item) {
      var $cell = clara.aids.find_cell_for($row, item);
      _.each(aid[item], function(filter_obj){
        $cell.append("<div class='ftag'>" + filter_obj["slug"] + "</div>");
      });
    })
  });
});

_.set(window, 'clara.aids.extract_all_ids', function() {
    var displayed_ids = []
    $('.js-table-row').each(function(i,e) {
      var id_as_string = $(e).find("td:eq(" + clara.aids.find_col_nb_for("id") + ")").text().trim();
      displayed_ids.push(parseInt(id_as_string, 10));
    });
    return displayed_ids;
});



clara.load_js(function only_if(){return window.location.pathname === "/admin/aids"}, function () {

  $.ajax({
    url: "/admin/find_filters",
    type:'GET',
    dataType:'json',
    data:{
      ids: clara.aids.extract_all_ids()
    },
    success:function(data){
      clara.aids.treat_successfully_retrieved_filters(data["aids"])
    },
    error:function(data){
      console.log("error");
      console.error(data);
    }
  });

});

// $( document ).ready(function() {

//   if (window.location.pathname === "/admin/aids") {

//     $.ajax({
//         url: "/admin/find_filters",
//         type:'GET',
//         dataType:'json',
//         data:{
//           ids: clara.aids.extract_all_ids()
//         },
//         success:function(data){
//           clara.aids.treat_successfully_retrieved_filters(data["aids"])
//         },
//         error:function(data){
//           console.log("error");
//           console.error(data);
//         }
//       });
//     }
// });

clara.js_define("aides_main_dispatcher", {

  please_if: _.stubFalse,

  please: function() {
    
    $('.c-filtertag__close').click(function(){
      var filter_name = $(this).closest('.c-filterstag__item').attr('data-name');
      main_store.dispatch({type: 'TOGGLE_FILTER', name: filter_name, value: false});
    });

    $( window ).resize(function() {
        main_store.dispatch({type: 'RESIZE_WINDOW', width: $( window ).width()});
    });

    $('.js-toggle-ineligies').on('click', function(){
      main_store.dispatch({type: 'TOGGLE_INELIGIES_ZONE'});
    });
    $('.js-filters-zone').on('click', function(){ 
      main_store.dispatch({type: 'TOGGLE_FILTERS_ZONE'});
    });
    $('.js-recap-zone').on('click', function(){ 
      main_store.dispatch({type: 'TOGGLE_RECAP_ZONE'});
    });


    _.each(clara.aides_collect_filters_name.please(), function(filter_name){ 
      $('.c-resultfiltering[data-name="' + filter_name + '"] input[type="checkbox"]').click(function(){
        var that = this; 
        main_store.dispatch({type: 'TOGGLE_FILTER', name: filter_name, value: $(that).prop("checked")}) 
      });
    });

    _.each(clara.aides_constants["ELIGIES"], function(eligy_name) {
      _.each(clara.aides_$card.please(eligy_name).datamap("cslug"), function(contract_name){
        $('#' + eligy_name + ' .c-resultcard[data-cslug="' + contract_name + '"]' + ' .js-open').click(function(){
          main_store.dispatch({type: 'OPEN_CONTRACT', eligy_name: eligy_name, contract_name: contract_name});
        });
        $('#' + eligy_name + ' .c-resultcard[data-cslug="' + contract_name + '"]' + ' .js-close').click(function(){
          main_store.dispatch({type: 'CLOSE_CONTRACT', eligy_name: eligy_name, contract_name: contract_name});
        });
      });
    });

    _.each(clara.aides_constants["ELIGIES"], function(eligy_name) {
      $('#' + eligy_name + ' .js-fold').click(function(){
        main_store.dispatch({type: 'FOLD_ELIGY', eligy_name: eligy_name});
      });
      $('#' + eligy_name + ' .js-unfold').click(function(){
        main_store.dispatch({type: 'UNFOLD_ELIGY', eligy_name: eligy_name});
      });
    });

  }


});

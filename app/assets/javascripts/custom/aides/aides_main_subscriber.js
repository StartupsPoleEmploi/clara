clara.js_define("aides_main_subscriber", {

  please_if: _.stubFalse,

  please: function() {

    var state = main_store.getState();

    // filters_zone : caret
    state.filters_zone.is_collapsed ? $('.js-filters-zone .c-mask-filter__caret').html(clara.aides_constants["GREY_CARET_OPEN"]) : $('.js-filters-zone .c-mask-filter__caret').html(clara.aides_constants["GREY_CARET_CLOSE"]);

    // recap_zone  : caret
    state.recap_zone.is_collapsed ? $('.js-recap-zone .c-mask-filter__caret').html(clara.aides_constants["GREY_CARET_OPEN"]) : $('.js-recap-zone .c-mask-filter__caret').html(clara.aides_constants["GREY_CARET_CLOSE"]);

    // filters_zone : repaint
    _.each(state.filters_zone.filters, function(f){
       $('.c-resultfiltering[data-name="' + f.name + '"] input[type="checkbox"]').prop('checked', f.is_checked);
    });

    // filters_zone : text
    state.filters_zone.is_collapsed ? $('.js-filters-zone .c-mask-filter__text').text('Ouvrir les filtres') : $('.js-filters-zone .c-mask-filter__text').text('Masquer les filtres');

    // Collapse ineligibles
    state.ineligibles_zone.is_collapsed ? $('.js-ineligibles-zone').addClass('u-hidden-visually') : $('.js-ineligibles-zone').removeClass('u-hidden-visually');

    // Collapse ineligibles : text
    state.ineligibles_zone.is_collapsed ? $('.js-toggle-ineligies').text('Voir') : $('.js-toggle-ineligies').text('Cacher');

    // Collapse filters_zone
    state.filters_zone.is_collapsed ? $('.c-resultfilterings').addClass('u-hidden-visually') : $('.c-resultfilterings').removeClass('u-hidden-visually');

    // Collapse filters_zone : CSS. 
    var is_discrete = (state.filters_zone.is_collapsed && state.width > clara.aides_constants["MOBILE_MAX_WIDTH"]); 
    is_discrete ? $('.js-filters-zone').addClass('is-discrete') : $('.js-filters-zone').removeClass('is-discrete');

    // Collapse recap_zone 
    state.recap_zone.is_collapsed ? $('.c-situation__content').addClass('u-hidden-visually') : $('.c-situation__content').removeClass('u-hidden-visually');

    // Collapse recap_zone : CSS. 
    state.recap_zone.is_collapsed ? $('.js-recap-zone').addClass('is-discrete') : $('.js-recap-zone').removeClass('is-discrete');

    // Show bigtags or not
    _.each(state.filters_zone.filters, function(filter){
      var $el = $('.c-filterstag__item[data-name="' + filter.name +'"]');
      filter.is_checked ? $el.removeClass('u-hidden') : $el.addClass('u-hidden');
    });

    clara.aides_iterate_contract_types.please(function(ely, contract){
      // Collapse contract or not
      var $el = $('#' + ely + ' .c-resultcard[data-cslug="' + contract.name + '"]');
      var $aids = $el.find('.c-resultaids');
      contract.is_collapsed ? $aids.addClass('u-hidden-visually') : $aids.removeClass('u-hidden-visually');

      // Display number of shown aids
      var $number = $el.find('.c-resultcontract-title__number');
      var new_number = _.count(contract.aids, function(aid){return !aid.is_collapsed;})
      $number.text(new_number);

      // Display single or plural for contract
      var csingle = $el.find('.c-resultcontract-title__text').attr('data-csingle')
      var cplural = $el.find('.c-resultcontract-title__text').attr('data-cplural')
      var new_text = csingle;
      if (new_number > 1 && _.isNotEmpty(cplural)) new_text = cplural;
      $el.find('.c-resultcontract-title__text').text(new_text)

      // Remove contracts without aid
      new_number === 0 ? $el.addClass('u-hidden-visually') : $el.removeClass('u-hidden-visually')

      // Show open or not
      var $open = $el.find('.js-open');
      contract.is_collapsed ? $open.removeClass('u-hidden-visually') : $open.addClass('u-hidden-visually');

      // Show close or not
      var $close = $el.find('.js-close');
      contract.is_collapsed ? $close.addClass('u-hidden-visually') : $close.removeClass('u-hidden-visually');
    });

    clara.aides_iterate_through_aids.please(function(ely, contract, aid){
      // Show aid or not
      var $aid = $('#' + ely + ' .c-resultcard[data-cslug="' + contract.name + '"] .c-resultaid[data-aslug="' + aid.name + '"]');
      aid.is_collapsed ? $aid.addClass('u-hidden-visually') : $aid.removeClass('u-hidden-visually');

      // Show smalltags or not
      var $smalltag = $('#' + ely + ' .c-resultcard[data-cslug="' + contract.name + '"] .c-resultaid[data-aslug="' + aid.name + '"] .c-resultfilters');
      var active_filters = _.filter(main_store.getState().filters_zone.filters, function(e){return e.is_checked === true})
      _.isEmpty(active_filters) ? $smalltag.addClass('u-hidden-visually') : $smalltag.removeClass('u-hidden-visually')


    });


    _.each(clara.aides_constants["ELIGIES"], function(ely){
      var $el = $('#' + ely);
      var contracts = state[ely + "_zone"][ely];

      // Hide the whole ely or not
      var number_of_aid_per_eligy = _.sumBy(contracts, function(contract){
        return _.count(contract.aids, function(aid){return !aid.is_collapsed;})
      })
      number_of_aid_per_eligy === 0 ? $el.addClass('u-hidden-visually') : $el.removeClass('u-hidden-visually');

      // fold all contracts
      var $fold = $el.find('.js-fold');
      var no_contracts_are_collapsed = _.none(contracts, function(e){return e.is_collapsed;});
      no_contracts_are_collapsed ? $fold.addClass('u-hidden-visually') : $fold.removeClass('u-hidden-visually');

      // unfold all contracts
      var $unfold = $el.find('.js-unfold');
      var some_contracts_are_uncollapsed = _.some(contracts, function(e){return !e.is_collapsed;});
      some_contracts_are_uncollapsed ? $unfold.removeClass('u-hidden-visually') : $unfold.addClass('u-hidden-visually');
    });

    // Nothing interesting was found for the user
    var nb_of_eligibles = _.sumBy(state.eligibles_zone.eligibles, function(contract){return _.count(contract.aids, function(aid){return !aid.is_collapsed;})})  
    var nb_of_uncertains = _.sumBy(state.uncertains_zone.uncertains, function(contract){return _.count(contract.aids, function(aid){return !aid.is_collapsed;})})  
    nb_of_eligibles + nb_of_uncertains === 0  ? $('#nothing').removeClass('u-hidden') : $('#nothing').addClass('u-hidden');

  }


});

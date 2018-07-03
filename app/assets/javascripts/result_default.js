$( document ).ready(function() {
  if ($('.c-result-default').length) {

    // track filters
    function track_filter(filter_name) {
      if (typeof ga === "function") {
        ga('send', 'event', 'results', 'filter', filter_name);
      }      
    }

    function initialize_state() {
      var existing = get_existing();
      if (existing) {
        initialize_aids_per_contract_state("o_eligibles", existing);
        initialize_aids_per_contract_state("o_uncertains", existing);
        initialize_aids_per_contract_state("o_ineligibles", existing);
        initialize_filters_state(existing.o_all_filters);
        initialize_ineligible_visibility(existing.o_ineligibles);
      }      
      initialize_filterarea_state();
    }

    function initialize_ineligible_visibility(existing_ineligies) {
      appViewModel.o_ineligibles().o_hide(existing_ineligies.o_hide);
    }

    function initialize_filterarea_state() {
      if ($(window).width() < 740) {
         window.appViewModel.o_filterarea().o_toggle_state(false);
      } else {
         window.appViewModel.o_filterarea().o_toggle_state(true);
       }
    }

    function initialize_filters_state(existing_filters) {
      _.each(existing_filters, function(existing_filter){
        var one_filter = _.find(appViewModel.o_all_filters(), function(e){return e.name === existing_filter.name;});
        one_filter.isActive(existing_filter.isActive)
      });
    }

    function initialize_aids_per_contract_state(eligy, existing) {
      _.each(existing[eligy].o_aids_per_contract, function(existing_apc){
        var one_apc = _.find(appViewModel[eligy]().o_aids_per_contract(), function(e){return e.name === existing_apc.name;});
        if (one_apc) one_apc.isOpened(existing_apc.isOpened);
      });
    }

    function get_existing() {
      return store.get($.urlParam('for_id'));
    }

    function set_existing(value) {
      return store.set($.urlParam('for_id'), value);
    }

    function get_json_filters() {
      return gon.loaded.flat_all_filter;
    }

    function defaultActivityForFilter(named) {
      var result = false;
      var existing = get_existing();
      if (existing) {
        var concerned_filter = _.find(_.get(existing, 'o_all_filters'), function(e){return e.name === named;});
        result = concerned_filter.isActive;
      }
      return result;
    }

    function FilterViewModel(id, name, description) {
      var that = this;
      that.id = id;
      that.name = name;
      that.description = description;
      that.isActive = ko.observable(false);
      that.sendGaEvent = ko.computed(function(){return that.isActive();}).subscribe(function (newValue) {
        if (newValue === true) {
          track_filter(that.name);
        }
      });
      that.tagClosed = function(){that.isActive(false)};
    }


    function FilterSmallTagViewModel(name, o_active_filters_name) {
      var that = this;
      that.name = name;
      that.filtersmalltagClass = ko.computed(function() {
        return _.includes(o_active_filters_name(), that.name) ? "" : "u-hidden-visually";
      });
    }



    function AidViewModel(name, o_active_filters, own_filters_name) {
      var that = this;
      that.name = name;

      that.filtersClass = ko.computed(function() {
        return _.some(o_active_filters()) ? "" : "u-hidden-visually";
      });


      that.own_filters_name = own_filters_name;

      that.o_active_filters_name = ko.computed(function() {
        return _.map(o_active_filters(), function(e){return e.name});
      });

      var smalltags_names = $('.c-resultaid[data-aslug="' + that.name + '"] .c-resultfilter').map(function(){return $(this).data()["name"]}).get();
      that.o_filtersmalltags = ko.observableArray(_.map(smalltags_names, function(n){return new FilterSmallTagViewModel(n, that.o_active_filters_name)}))

      that.isVisible = ko.computed(function() {
        var condition1 = _.some(that.o_active_filters_name(), function(e){
          return _.includes(that.own_filters_name, e);
        });
        var condition2 = _.none(o_active_filters())

        return condition1 || condition2;
      });

      that.visibleClass = ko.computed(function() {
        return that.isVisible() ? "" : "u-hidden-visually";
      });

    }



    function AidPerContractViewModel(eligy_name, name, isOpened, o_active_filters) {
      var that = this;
      that.name = name;
      that.isOpened = ko.observable(isOpened);
      
      // track ANY change in the number of filters opened
      ko.computed(function() {
        return o_active_filters().length;
      }).subscribe(function (newValue) {
        if (newValue > 0) {
          that.isOpened(true);
        } else {
          that.isOpened(false);
        }
      });


      that.openedClass = ko.computed(function() {
        return that.isOpened() ? "" : "u-hidden-visually";
      });
      that.closedClass = ko.computed(function() {
        return that.isOpened() ? "u-hidden-visually" : "";
      });
      that.clickedOpenClose = function() {that.isOpened(!that.isOpened())}

      var aids_name = $('#o_' + eligy_name + ' .c-resultcard[data-cslug="' + that.name + '"] .c-resultaid').map(function(){return $(this).data()["aslug"]}).get()

      var aids_array = _.map(aids_name, function(aid_name) {
        return new AidViewModel(aid_name, o_active_filters, $('#o_' + eligy_name + ' .c-resultaid[data-aslug="' + aid_name + '"] .c-resultfilter').map(function(){return $(this).data()["name"]}).get());
      });

      that.o_aids = ko.observableArray(aids_array);

      that.numberOfAidsPerContract = ko.computed(function() {
        return _.count(that.o_aids(), function(a){
          return a.isVisible();
        });
      });

      that.displayClass = ko.computed(function() {
        return (that.numberOfAidsPerContract() !== 0) ? "" : "u-hidden-visually";
      });
    }




    function AidsPerContractViewModel(eligy_name, o_active_filters) {

      var that = this;

      that.name = eligy_name;

      that.o_hide = ko.observable(true);

      that.o_hideClick = function() {
        that.o_hide(!that.o_hide());
      }

      that.o_hideCss = ko.computed(function() {
        return that.o_hide() ? "u-hidden-visually" : "";
      });

      that.o_hideText = ko.computed(function() {
        return that.o_hide() ? "Voir" : "Cacher";
      });

      that.sesameOpen = function() {
        _.each(that.o_aids_per_contract(), function(aid){
          aid.isOpened(true);
        })
      }

      that.sesameClose = function() {
        _.each(that.o_aids_per_contract(), function(aid){
          aid.isOpened(false);
        })
      }


      var slugs = $( "#o_" + eligy_name + " .c-resultcard[data-cslug]" ).map(function(){return $(this).data()["cslug"]}).get()

      var aid_per_contract_array = _.map(slugs, function(slug) {
        return new AidPerContractViewModel(eligy_name, slug, false, o_active_filters);
      });

      that.o_aids_per_contract = ko.observableArray(aid_per_contract_array);

      that.o_nb_of_selected_aids = ko.computed(function() {
        return _.chain(that.o_aids_per_contract())
        .map(function(e) {return e.numberOfAidsPerContract();})
        .sum()
        .value()
      });

      that.o_nb_of_unfold = ko.computed(function() {
        return _.count(that.o_aids_per_contract(), function(aid){
          return aid.isOpened();
        });
      });
      that.unfoldClass = ko.computed(function() {
        return _.some(that.o_aids_per_contract(), function(aid){
          return aid.isOpened();
        }) ? "" : "u-hidden-visually";
      });
      that.foldClass = ko.computed(function() {
        return !_.every(that.o_aids_per_contract(), function(aid){
          return aid.isOpened();
        }) ? "" : "u-hidden-visually";
      });
      that.cssZoneDisplay = ko.computed(function() {
        return that.o_nb_of_selected_aids() > 0 ? "" : "u-hidden-visually";
      });

    }


    function FilterstagViewModel(o_active_filters) {
      var that = this;
      that.o_active_filters = o_active_filters;

      that.o_cssMargin = ko.computed(function() {
        return _.isEmpty(o_active_filters()) ? "" : "u-margin-bottom-small";
      }); 

    }

    function FilterAreaViewModel(o_all_filters, o_situationarea) {
      var that = this;
      that.o_all_filters = o_all_filters;
      that.o_situationarea = o_situationarea;
      that.o_filterareashow = ko.observable(_.some(that.o_all_filters(), function(e){return e.name === "specially-hidden"}) ? "u-hidden-visually" : "");
      that.o_toggle = function() {
        that.o_toggle_state(!that.o_toggle_state());
      }
      that.o_toggle_state = ko.observable(false);
      that.o_toggle_text = ko.computed(function() {
        return that.o_toggle_state() ? "Masquer les filtres" : "Filtrer par besoin";
      }); 
      that.o_toggle_css = ko.computed(function() {
        return that.o_toggle_state() ? "" : "u-hidden-visually";
      }); 
      that.o_state_css = ko.computed(function() {
        return that.o_toggle_state() ? "is-deployed" : "is-not-deployed";
      }); 
      ko.computed(function() {
        return that.o_situationarea().o_toggle_state();
      }).subscribe(function (newValue) {
        if (newValue === true) {
          that.o_toggle_state(false);
        }
      });
    }
 
    function SituationAreaViewModel() {
      var that = this;
      that.o_toggle = function() {
        that.o_toggle_state(!that.o_toggle_state());
      }
      that.o_toggle_state = ko.observable(false);
      that.o_toggle_css = ko.computed(function() {
        return that.o_toggle_state() ? "" : "u-hidden-visually";
      }); 
      that.o_state_css = ko.computed(function() {
        return that.o_toggle_state() ? "is-deployed" : "is-not-deployed";
      }); 
    }
 
    function NothingViewModel(nb_of_eligible, nb_of_uncertain) {
      var that = this;
      that.o_cssDisplay = ko.computed(function() {
        return nb_of_eligible() === 0 && nb_of_uncertain() === 0 ? "" : "u-hidden-visually";
      });
    }

    function AppViewModel() {
      var that = this;

      var filter_array = _.map(get_json_filters(), function(e) {
        return new FilterViewModel(e.id, e.name, e.description)
      });
      that.o_all_filters = ko.observableArray(filter_array);
      that.o_active_filters = ko.computed(function() {
        return _.filter(that.o_all_filters(), function(f){
          return f.isActive();
        });
      });
      that.o_eligibles     = ko.observable(new AidsPerContractViewModel('eligibles', that.o_active_filters));
      that.o_ineligibles   = ko.observable(new AidsPerContractViewModel('ineligibles', that.o_active_filters));
      that.o_uncertains    = ko.observable(new AidsPerContractViewModel('uncertains', that.o_active_filters));
      that.o_filterstag    = ko.observable(new FilterstagViewModel(that.o_active_filters));
      that.o_situationarea = ko.observable(new SituationAreaViewModel());
      that.o_filterarea    = ko.observable(new FilterAreaViewModel(that.o_all_filters, that.o_situationarea));
      that.o_nothing       = ko.observable(new NothingViewModel(that.o_eligibles().o_nb_of_selected_aids, that.o_uncertains().o_nb_of_selected_aids));
      


      // Utility to track ANY change in the whole viewModel
      ko.computed(function() {
        return that.o_active_filters().length + 
        that.o_ineligibles().o_nb_of_unfold() +
        that.o_ineligibles().o_hide() +
        that.o_uncertains().o_nb_of_unfold() +
        that.o_eligibles().o_nb_of_unfold();
      }).subscribe(function (newValue) {
        set_existing(ko.toJS(that));
      }); 
    }




    window.appViewModel = new AppViewModel();




    ko.applyBindings(window.appViewModel);

    initialize_state();

  }
  


});



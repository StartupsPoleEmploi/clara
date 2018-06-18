$( document ).ready(function() {
  if ($('.c-result-default').length) {

    function initialize_state() {
      var existing = get_existing();
      if (existing) {
        initialize_aids_per_contract_state("o_eligibles", existing);
        initialize_aids_per_contract_state("o_uncertains", existing);
        initialize_aids_per_contract_state("o_ineligibles", existing);
        initialize_filters_state(existing.o_all_filters);
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
        one_apc.isOpened(existing_apc.isOpened);
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
      that.tagClosed = function(){that.isActive(false)};
    }



    function AidViewModel(name, o_all_filters, own_filters_name) {
      var that = this;
      that.name = name;

      that.o_all_filters = o_all_filters;
      that.filtersClass = ko.computed(function() {
        return _.some(that.o_all_filters(), function(filter){
          return filter.isActive();
        }) ? "" : "u-hidden-visually";
      });

      that.own_filters_name = own_filters_name;

      that.o_active_filters_name = ko.computed(function() {
        return _.chain(that.o_all_filters())
        .filter(function(e) {return e.isActive()})
        .map(function(e){return e.name})
        .value()
      });

      that.isVisible = ko.computed(function() {
        var condition1 = _.some(that.o_active_filters_name(), function(e){
          return _.includes(that.own_filters_name, e);
        });
        var condition2 = _.none(that.o_all_filters(), function(e) {
          return e.isActive();
        })
        return condition1 || condition2;
      });

      that.visibleClass = ko.computed(function() {
        return that.isVisible() ? "" : "u-hidden-visually";
      });

    }



    function AidPerContractViewModel(eligy_name, name, isOpened, o_all_filters) {
      var that = this;
      that.name = name;
      that.isOpened = ko.observable(isOpened);
      that.openedClass = ko.computed(function() {
        return that.isOpened() ? "" : "u-hidden-visually";
      });
      that.closedClass = ko.computed(function() {
        return that.isOpened() ? "u-hidden-visually" : "";
      });
      that.clickedOpenClose = function() {that.isOpened(!that.isOpened())}

      var aids_name = $('#o_' + eligy_name + ' .c-resultcard[data-cslug="' + that.name + '"] .c-resultaid').map(function(){return $(this).data()["aslug"]}).get()

      var aids_array = _.map(aids_name, function(aid_name) {
        return new AidViewModel(aid_name, o_all_filters, $('#o_' + eligy_name + ' .c-resultaid[data-aslug="' + aid_name + '"] .c-resultfilter').map(function(){return $(this).data()["name"]}).get());
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




    function AidsPerContractViewModel(eligy_name, o_all_filters) {

      var that = this;

      that.name = eligy_name;

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
        return new AidPerContractViewModel(eligy_name, slug, false, o_all_filters);
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


    function FilterstagViewModel(o_all_filters) {
      var that = this;
      that.o_all_filters = o_all_filters;

      that.o_active_filters = ko.computed(function() {
        return _.filter(that.o_all_filters(), function(f){
          return f.isActive();
        });
      });

      that.o_cssMargin = ko.computed(function() {
        return _.isEmpty(that.o_active_filters()) ? "" : "u-margin-bottom-small";
      }); 

    }

    function FilterAreaViewModel(o_all_filters) {
      var that = this;
      that.o_all_filters = o_all_filters;
      that.o_toggle = function() {
        console.log('toggle');
        that.o_toggle_state(!that.o_toggle_state());
      }
      that.o_toggle_state = ko.observable(false);
      that.o_toggle_text = ko.computed(function() {
        return that.o_toggle_state() ? "Ouvrir les filtres" : "Masquer les filtres";
      }); 
      that.o_toggle_css = ko.computed(function() {
        return that.o_toggle_state() ? "" : "u-hidden-visually";
      }); 
    }
 

    function AppViewModel() {
      var that = this;

      var filter_array = _.map(get_json_filters(), function(e) {
        return new FilterViewModel(e.id, e.name, e.description)
      });
      that.o_all_filters = ko.observableArray(filter_array);
      that.o_eligibles = ko.observable(new AidsPerContractViewModel('eligibles', that.o_all_filters));
      that.o_ineligibles = ko.observable(new AidsPerContractViewModel('ineligibles', that.o_all_filters));
      that.o_uncertains = ko.observable(new AidsPerContractViewModel('uncertains', that.o_all_filters));
      that.o_filterstag = ko.observable(new FilterstagViewModel(that.o_all_filters));
      that.o_filterarea = ko.observable(new FilterAreaViewModel(that.o_all_filters));
      
      // Utility to track ANY change in the whole viewModel
      ko.computed(function() {
        return that.o_filterstag().o_active_filters().length + 
        that.o_ineligibles().o_nb_of_unfold() +
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



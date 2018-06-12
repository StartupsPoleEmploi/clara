$(document).on('ready turbolinks:load', function() {
  if ($('.c-result-default')) {



    function FilterViewModel(id, name, description, isActive) {
      var self = this;
      self.id = id;
      self.name = name;
      self.description = description;
      self.isActive = ko.observable(isActive);
      self.tagClosed = function(){self.isActive(false)};
    }
  


    function AidViewModel(name, o_all_filters, own_filters_name) {
      var self = this;
      self.name = name;

      self.o_all_filters = o_all_filters;
      self.filtersClass = ko.computed(function() {
        return _.some(self.o_all_filters(), function(filter){
          return filter.isActive();
        }) ? "" : "u-hidden-visually";
      });

      self.own_filters_name = own_filters_name;

      self.o_active_filters_name = ko.computed(function() {
        return _.chain(self.o_all_filters())
                .filter(function(e) {return e.isActive()})
                .map(function(e){return e.name})
                .value()
      });

      self.isVisible = ko.computed(function() {
        var condition1 = _.some(self.o_active_filters_name(), function(e){
          return _.includes(self.own_filters_name, e);
        });
        var condition2 = _.none(self.o_all_filters(), function(e) {
          return e.isActive();
        })
        return condition1 || condition2;
      });

      self.visibleClass = ko.computed(function() {
        return self.isVisible() ? "" : "u-hidden-visually";
      });

    }
  


    function AidPerContractViewModel(eligy_name, name, isOpened, o_all_filters) {
      var self = this;
      self.name = name;
      self.isOpened = ko.observable(isOpened);
      self.openedClass = ko.computed(function() {
        return self.isOpened() ? "" : "u-hidden-visually";
      });
      self.closedClass = ko.computed(function() {
        return self.isOpened() ? "u-hidden-visually" : "";
      });
      self.clickedOpenClose = function() {self.isOpened(!self.isOpened())}

      var aids_name = $('#o_' + eligy_name + ' .c-resultcard[data-cslug="' + self.name + '"] .c-resultaid').map(function(){return $(this).data()["aslug"]}).get()

      var aids_array = _.map(aids_name, function(aid_name) {
        return new AidViewModel(aid_name, o_all_filters, $('#o_' + eligy_name + ' .c-resultaid[data-aslug="' + aid_name + '"] .c-resultfilter').map(function(){return $(this).data()["name"]}).get());
      });

      self.o_aids = ko.observableArray(aids_array);

      self.numberOfAidsPerContract = ko.computed(function() {
        return _.count(self.o_aids(), function(a){
          return a.isVisible();
        });
      });

      self.displayClass = ko.computed(function() {
        return (self.numberOfAidsPerContract() !== 0) ? "" : "u-hidden-visually";
      });
    }




    function AidsPerContractViewModel(eligy_name, o_all_filters) {
      
      var self = this;
      
      self.name = eligy_name;
      
      self.sesameOpen = function() {
        _.each(self.o_aids_per_contract(), function(aid){
          aid.isOpened(true);
        })
      }
      
      self.sesameClose = function() {
        _.each(self.o_aids_per_contract(), function(aid){
          aid.isOpened(false);
        })
      }

      var slugs = $( "#o_" + eligy_name + " .c-resultcard[data-cslug]" ).map(function(){return $(this).data()["cslug"]}).get()

      var aid_per_contract_array = _.map(slugs, function(slug) {
        return new AidPerContractViewModel(eligy_name, slug, false, o_all_filters);
      });
      
      self.o_aids_per_contract = ko.observableArray(aid_per_contract_array);

      self.unfoldClass = ko.computed(function() {
        return _.some(self.o_aids_per_contract(), function(aid){
          return aid.isOpened();
        }) ? "" : "u-hidden-visually";
      });
      self.foldClass = ko.computed(function() {
        return !_.every(self.o_aids_per_contract(), function(aid){
          return aid.isOpened();
        }) ? "" : "u-hidden-visually";
      });
      
    }


    function FilterstagViewModel(o_all_filters) {

      self.o_all_filters = o_all_filters;

      self.o_active_filters = ko.computed(function() {
        return _.filter(self.o_all_filters(), function(f){
          return f.isActive();
        });
      });
      
      self.o_cssMargin = ko.computed(function() {
        return _.isEmpty(self.o_active_filters()) ? "" : "u-margin-bottom-small";
      }); 

    }



    function AppViewModel() {
      var self = this;
    
      var filter_array = _.map(gon.loaded.flat_all_filter, function(e) {
        return new FilterViewModel(e.id, e.name, e.description, false)
      });
      self.o_all_filters = ko.observableArray(filter_array);
      self.o_eligibles = ko.observable(new AidsPerContractViewModel('eligibles', self.o_all_filters));
      self.o_ineligibles = ko.observable(new AidsPerContractViewModel('ineligibles', self.o_all_filters));
      self.o_uncertains = ko.observable(new AidsPerContractViewModel('uncertains', self.o_all_filters));
      self.o_filterstag = ko.observable(new FilterstagViewModel(self.o_all_filters));
    }
    



    var appViewModel = new AppViewModel();




    ko.applyBindings(appViewModel);


  }


});

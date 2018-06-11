$(document).on('ready turbolinks:load', function() {
  if ($('.c-result-default')) {

    function FilterViewModel(id, name, description, isActive) {
      var self = this;
      self.id = id;
      self.name = name;
      self.description = description;
      self.isActive = ko.observable(isActive);
    }
  

    function AidPerContractViewModel(name, isOpened) {
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
    }


    function AidsPerContractViewModel(name, isOpened) {
      var self = this;
      // self.isOpened = ko.observable(isOpened);
      self.name = name;
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

      var slugs = $( ".c-resultcard[data-cslug]" ).map(function(){return $(this).data()["cslug"]}).get()

      var aid_per_contract_array = _.map(slugs, function(slug) {
        return new AidPerContractViewModel(slug, false);
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


    function AppViewModel() {
      var self = this;
    
      var filter_array = _.map(gon.loaded.flat_all_filter, function(e) {
        return new FilterViewModel(e.id, e.name, e.description, false)
      });
      self.o_filters = ko.observableArray(filter_array);
      self.o_eligibles = ko.observable(new AidsPerContractViewModel('eligible', false))
    }
    

    var appViewModel = new AppViewModel();


    ko.applyBindings(appViewModel);


  }


});

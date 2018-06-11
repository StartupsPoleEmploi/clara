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
        return self.isOpened() ? "" : "u-hidden";
      });
      self.closedClass = ko.computed(function() {
        return self.isOpened() ? "u-hidden" : "";
      });
      self.clickedOpenClose = function() {self.isOpened(!self.isOpened())}
    }


    function AidsPerContractViewModel(name, isOpened) {
      var self = this;
      self.isOpened = ko.observable(isOpened);
      self.name = name;
      self.toggleOpen = function() {self.isOpened(!self.isOpened())}

      // see https://stackoverflow.com/a/16570627/2595513
      var slugs = $('.c-resultcontract_slug').map(function(){return $.trim($(this).text());}).get();

      var aid_per_contract_array = _.map(slugs, function(e) {
        return new AidPerContractViewModel(e, false);
      });
      
      self.o_aids_per_contract = ko.observableArray(aid_per_contract_array);
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

$(document).on('ready turbolinks:load', function() {
  if ($('.c-result-default')) {



    function FilterViewModel(id, name, description, isActive) {
      var self = this;
      self.id = id;
      self.name = name;
      self.description = description;
      self.isActive = ko.observable(isActive);
    }
  


    function AppViewModel() {
      var self = this;
      var filter_array = _.map(gon.loaded.flat_all_filter, function(e) {
        return new FilterViewModel(e.id, e.name, e.description, false)
      });
      self.o_filters = ko.observableArray(filter_array);
    }
    
    var appViewModel = new AppViewModel();

    ko.applyBindings(appViewModel);


  }


});

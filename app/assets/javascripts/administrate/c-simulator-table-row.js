var CSimulatorTableRow = Vue.component('c-simulator-table-row', {

  props: ['custom_rule_check', 'del_simulation_url'],
  
  template: '#c-simulator-table-row',
  
  methods: {

    replay: function (e) {
      var that = this;
      var asker_features = _.toPropArray(that.custom_rule_check.hsh);
      _.injectToPropArray(asker_features, that.$root.asker);
      that.$root.reset_registration();
    },

    remove: function (e) {
      var that = this;
      $.ajax({
        url: that.calculated_del_simulation_url,
        type:'DELETE',
        dataType:'json',
        data:{
          authenticity_token: window._token
        },
        success:function(data){
          that.$root.remove_crc(that.id);
        }
      });
    }

  },
  
  computed: {

    calculated_del_simulation_url: function () {
      return this.del_simulation_url.replace('__id__', this.id);
    },

    id: function() {
      return this.custom_rule_check.id;
    }
    
  }

});

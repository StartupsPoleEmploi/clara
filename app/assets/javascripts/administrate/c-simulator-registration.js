var CSimulatorRegistration = Vue.component('c-simulator-registration', {

  props: ['is_registerable', 'save_simulation_url', 'simulation_name'],
  
  template: '#c-simulator-registration',
  
  methods: {
    onclick: function (event) {
      var that = this;
      $.ajax({
        url: that.save_simulation_url,
        type:'POST',
        dataType:'json',
        data:{
          simulation: {
            result: that.$root.simulation_result.val,
            name: that.simulation_name.val
          },
          asker: _.fromPropArray(that.$root.asker),
          authenticity_token: window._token
        },
        success:function(data){
          window.location.reload();
        }
      });

    },
  }
});

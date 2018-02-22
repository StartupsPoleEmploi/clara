var CSimulatorSubmit = Vue.component('c-simulator-submit', {
  
  props: ['url'],

  template: '#c-simulator-submit',

  methods: {
    onclick: function (event) {
      var that = this;
      $.ajax({
        url: that.url,
        type:'GET',
        dataType:'json',
        data:{
          asker: _.fromPropArray(that.$root.asker),
          authenticity_token: window._token
        },
        success: function (res) {
          that.$root.simulation_result.val = res;
          that.$root.is_registerable = true;
        }
      });

    },
  }

});

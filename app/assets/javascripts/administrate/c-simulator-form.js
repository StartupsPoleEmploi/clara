var CSimulatorForm = Vue.component('c-simulator-form', {
  props: ['asker'],
  template: '#c-simulator-form',
  mounted: function() {
    var that = this;
    var any_input = $(this.$el).find('input');
    $(any_input).on("change keyup paste", function(){
      that.$root.reset_registration();
    });
  }
});

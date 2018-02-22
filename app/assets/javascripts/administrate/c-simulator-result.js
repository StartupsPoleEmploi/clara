var CSimulatorResult = Vue.component('c-simulator-result', {
  props: ['simulation_result'],
  template: '#c-simulator-result',
  data: function () {
    return {
      possible_outputs: ['eligible', 'ineligible', 'uncertain']
    }
  },
  methods: {
    change_output: function (e) {
      this.simulation_result.val = _.nextElementLooped(this.possible_outputs, this.simulation_result.val);
    }
  }
});

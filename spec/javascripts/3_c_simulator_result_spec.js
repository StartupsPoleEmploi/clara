//= require vuejs/vue
//= require administrate/c-simulator-result
describe("CSimulatorResult", function() {

  var sut;

  beforeEach(function() {

    MagicLamp.load('c-simulator-result');

    var Constructor = Vue.extend(CSimulatorResult);
    sut = new Constructor({
      propsData: {
        simulation_result: {val:'eligible'},
      }
    }).$mount();
  });

  it("Exists", function() {
    expect(CSimulatorResult).toBeDefined();
  });

  it("Has a root element with same name as component", function() {
    expect($(sut.$el).hasClass( 'c-simulator-result' )).toBe(true);
  });

  it("Display nothing by default", function(done) {
    sut.simulation_result.val = '';
    Vue.nextTick(function () {
      expect($(sut.$el).find( '.eligibility-ok' ).length).toBe(0);
      expect($(sut.$el).find( '.eligibility-nok' ).length).toBe(0);
      expect($(sut.$el).find( '.eligibility-uncertain' ).length).toBe(0);
      done();
    });
  });

  it("Can display a successful simulation_result", function(done) {

    sut.simulation_result.val = 'eligible';
    Vue.nextTick(function () {
      expect($(sut.$el).find( '.eligibility-ok' ).length).toBe(1);
      expect($(sut.$el).find( '.eligibility-nok' ).length).toBe(0);
      expect($(sut.$el).find( '.eligibility-uncertain' ).length).toBe(0);
      done();
    });

  });

  it("Can display a unsuccessful simulation_result", function(done) {

    sut.simulation_result.val = 'ineligible';
    Vue.nextTick(function () {
      expect($(sut.$el).find( '.eligibility-ok' ).length).toBe(0);
      expect($(sut.$el).find( '.eligibility-nok' ).length).toBe(1);
      expect($(sut.$el).find( '.eligibility-uncertain' ).length).toBe(0);
      done();
    });
  });

  it("Can display an uncertain simulation_result", function(done) {

    sut.simulation_result.val = 'uncertain';
    Vue.nextTick(function () {
      expect($(sut.$el).find( '.eligibility-ok' ).length).toBe(0);
      expect($(sut.$el).find( '.eligibility-nok' ).length).toBe(0);
      expect($(sut.$el).find( '.eligibility-uncertain' ).length).toBe(1);
      done();
    });
  });

  it("Can allow user to change simulation result by double-clicking", function(done) {

    expect($(sut.$el).find( '.eligibility-ok' ).length).toBe(1);
    expect($(sut.$el).find( '.eligibility-nok' ).length).toBe(0);
    expect($(sut.$el).find( '.eligibility-uncertain' ).length).toBe(0);

    var evt = new window.Event('dblclick');
    sut.$el.dispatchEvent(evt);
    sut._watcher.run();

    Vue.nextTick(function () {
      expect($(sut.$el).find( '.eligibility-ok' ).length).toBe(0);
      expect($(sut.$el).find( '.eligibility-uncertain' ).length).toBe(0);
      expect($(sut.$el).find( '.eligibility-nok' ).length).toBe(1);
      done();
    });
  });

});

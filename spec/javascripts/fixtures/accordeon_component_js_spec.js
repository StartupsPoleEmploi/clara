//= require lodash/lodash
//= require lodash/lodash_extension
//= require jquery
//= require accordeon_component
describe('accordeon_component_spec.js', function() {

  var discriminator = '.c-result-list--eligible';

  var stupidLocalStorage = function (){
    return {
      getItem: "foo",
      setItem: "bar"
    }
  };

  var realisticLocalStorage = function (){
    var store = {};
    var res = {
      allItems: store,
      getItem: function(index) {
        return store[index];
      },
      setItem: function(index, element) {
        store[index] = element;
      }
    };
    return res;
  };

  var realisticUrlExtractor = function() {
    return 'abcd';
  }

  it('Needs accordeon_component_spec to be mapped to global clara.accordeon_component', function() {
    expect(clara).toBeDefined();
    expect(clara.accordeon_component).toBeDefined();
  });


  describe('Ability to override initial setup', function() {
    var myLocalStorage = null;
    beforeEach(function() {
      $('body').append(nominal_content_with_2_lines());
    });

    afterEach(function() {
      $(discriminator).remove();
    });

    describe('(Without mask) accordeon_component can be forced to have mask with everything opened', function() {
      beforeEach(function () {
        myLocalStorage = realisticLocalStorage();
        myLocalStorage.setItem('state_of_expander__.c-result-list--eligible__for-id__abcd', '{"expansions":{"eligible__projet-pro":true,"eligible__emplacement-id":true},"show_mask":true,"opened_mask":true}');
        clara.accordeon_component(discriminator, false, myLocalStorage, realisticUrlExtractor);
      });
      it ('Should left title as-is', function() {
        expect($('.c-result-header__title').text().trim().toLowerCase()).toEqual('vous pouvez bénéficier de');
      });
      it ('Should have 2 lines', function() {
        expect($('.c-result-line').length).toEqual(2);
      });
      it ('Should show mask button', function() {
        expect($('.c-expander-button:visible').length).toEqual(1);
      });
      it ('Should show expanders', function() {
        expect($('.c-expander:visible').length).toEqual(2);
      });
      it ('Should show TWO lines', function() {
        expect($('.c-result-line:visible').length).toEqual(2);
      });
      it ('Should show TWO aids', function() {
        expect($('.c-result-aid:visible').length).toEqual(2);
      });
      it ('Shows active reduce_all, inactive expand_all', function() {
        expect($('.c-expander--unexpandable:visible').length).toEqual(1);
        expect($('.c-expander--reduceable:visible').length).toEqual(1);
        expect($('.c-expander--expandable:visible').length).toEqual(0);
        expect($('.c-expander--unreduceable:visible').length).toEqual(0);
      });
    });
    describe('(Without mask) accordeon_component can be forced to have mask with half of things opened', function() {
      beforeEach(function () {
        myLocalStorage = realisticLocalStorage();
        myLocalStorage.setItem('state_of_expander__.c-result-list--eligible__for-id__abcd', '{"expansions":{"eligible__projet-pro":true,"eligible__emplacement-id":false},"show_mask":true,"opened_mask":true}');
        clara.accordeon_component(discriminator, false, myLocalStorage, realisticUrlExtractor);
      });
      it ('Should left title as-is', function() {
        expect($('.c-result-header__title').text().trim().toLowerCase()).toEqual('vous pouvez bénéficier de');
      });
      it ('Should have 2 lines', function() {
        expect($('.c-result-line').length).toEqual(2);
      });
      it ('Should show mask button', function() {
        expect($('.c-expander-button:visible').length).toEqual(1);
      });
      it ('Should show expanders', function() {
        expect($('.c-expander:visible').length).toEqual(2);
      });
      it ('Should show TWO lines', function() {
        expect($('.c-result-line:visible').length).toEqual(2);
      });
      it ('Should show ONE aid', function() {
        expect($('.c-result-aid:visible').length).toEqual(1);
      });
      it ('Shows active reduce_all, active expand_all', function() {
        expect($('.c-expander--unexpandable:visible').length).toEqual(0);
        expect($('.c-expander--reduceable:visible').length).toEqual(1);
        expect($('.c-expander--expandable:visible').length).toEqual(1);
        expect($('.c-expander--unreduceable:visible').length).toEqual(0);
      });
    });
  });

  describe('Nominal content without lines', function() {
    beforeEach(function() {
      $('body').append(nominal_content_with_2_lines());
      $('.c-result-line').remove();
    });

    afterEach(function() {
      $(discriminator).remove();
    });
    
    it ('(Set up without any lines)', function() {
      expect($('.c-result-line').length).toEqual(0);
    });
    describe('accordeon_component can be defined with collapsed lines', function() {
      beforeEach(function () {
        clara.accordeon_component(discriminator, true, stupidLocalStorage(), realisticUrlExtractor);
      });
      it ('Should hide expanders', function() {
        expect($('.c-expander:visible').length).toEqual(0);
      });
      it ('Should have no lines anyway', function() {
        expect($('.c-result-line').length).toEqual(0);
      });
      it ('Should hide mask button', function() {
        expect($('.c-expander-button:visible').length).toEqual(0);
      });
      it ('Should left title as-is', function() {
        expect($('.c-result-header__title').text().trim().toLowerCase()).toEqual('vous pouvez bénéficier de');
      });
    });
    describe('accordeon_component can be defined without collapsed lines', function() {
      beforeEach(function () {
        clara.accordeon_component(discriminator, false, stupidLocalStorage(), realisticUrlExtractor);
      });
      it ('Should hide expanders', function() {
        expect($('.c-expander:visible').length).toEqual(0);
      });
      it ('Should have no lines anyway', function() {
        expect($('.c-result-line').length).toEqual(0);
      });
      it ('Should hide mask button', function() {
        expect($('.c-expander-button:visible').length).toEqual(0);
      });
      it ('Should left title as-is', function() {
        expect($('.c-result-header__title').text().trim().toLowerCase()).toEqual('vous pouvez bénéficier de');
      });
    });

  });

  describe('Nominal content with 2 lines', function() {
    beforeEach(function() {
      $('body').append(nominal_content_with_2_lines());
    });

    afterEach(function() {
      $(discriminator).remove();
    });

    describe('accordeon_component can be defined with collapsed lines', function() {
      beforeEach(function () {
        clara.accordeon_component(discriminator, true, stupidLocalStorage(), realisticUrlExtractor);
      });
      it ('Should left title as-is', function() {
        expect($('.c-result-header__title').text().trim().toLowerCase()).toEqual('vous pouvez bénéficier de');
      });
      it ('Should hide lines', function() {
        expect($('.c-result-line').length).toEqual(2);
        expect($('.c-result-line:visible').length).toEqual(0);
      });
      it ('Should hide expanders', function() {
        expect($('.c-expander:visible').length).toEqual(0);
      });
      it ('Should show exactly ONE mask button', function() {
        expect($('.c-expander-button:visible').length).toEqual(1);
      });
      it ('Should have a mask button with "voir" text', function() {
        expect($('.c-expander-button:visible').text().trim().toLowerCase()).toEqual('voir');
      });
      describe('When click on "voir"', function() {
        beforeEach(function () {
          $('.c-expander-button:visible').trigger('click');
        });
        it ('Should show exactly ONE mask button', function() {
          expect($('.c-expander-button:visible').length).toEqual(1);
        });
        it ('Should have a mask button with "cacher" text', function() {
          expect($('.c-expander-button:visible').text().trim().toLowerCase()).toEqual('cacher');
        });
        it ('Should show expanders', function() {
          expect($('.c-expander:visible').length).toEqual(2);
        });
        it ('Should show lines', function() {
          expect($('.c-result-line:visible').length).toEqual(2);
        });
      });

    });

    describe('accordeon_component can be defined without collapsed lines', function() {
      beforeEach(function () {
        clara.accordeon_component(discriminator, false, stupidLocalStorage(), realisticUrlExtractor);
      });
      it ('Should left title as-is', function() {
        expect($('.c-result-header__title').text().trim().toLowerCase()).toEqual('vous pouvez bénéficier de');
      });
      it ('Should show lines', function() {
        expect($('.c-result-line:visible').length).toEqual(2);
      });
      it ('Should show expanders', function() {
        expect($('.c-expander:visible').length).toEqual(2);
      });
      it ('Should show active expand_all,  inactive reduce_all', function() {
        expect($('.c-expander--expandable:visible').length).toEqual(1);
        expect($('.c-expander--unreduceable:visible').length).toEqual(1);
        expect($('.c-expander--reduceable:visible').length).toEqual(0);
        expect($('.c-expander--unexpandable:visible').length).toEqual(0);
      });
      it ('Should hide mask button', function() {
        expect($('.c-expander-button:visible').length).toEqual(0);
      });
      it ('Should have collapsed lines (lines are shown but not aid inside) only', function() {
        expect($('.c-result-line:visible').length).toEqual(2);
        expect($('.c-result-aid:visible').length).toEqual(0);
      });
      describe('When click on first collapsed line', function() {
        beforeEach(function () {
          $($('.c-result-line__content')[0]).trigger('click');
        });
        it ('Should show ONE aid', function() {
          expect($('.c-result-line:visible').length).toEqual(2);
          expect($('.c-result-aid:visible').length).toEqual(1);
        });
        it ('Should show active reduce_all, active expand_all', function() {
          expect($('.c-expander--reduceable:visible').length).toEqual(1);
          expect($('.c-expander--expandable:visible').length).toEqual(1);
          expect($('.c-expander--unexpandable:visible').length).toEqual(0);
          expect($('.c-expander--unreduceable:visible').length).toEqual(0);
        });
        describe('When click on expand_all', function() {
          beforeEach(function () {
            $('.c-expander--expandable:visible').trigger('click');
          });
          it ('Should show TWO aids', function() {
            expect($('.c-result-line:visible').length).toEqual(2);
            expect($('.c-result-aid:visible').length).toEqual(2);
          });      
          it ('Should show inactive expand_all, active reduce_all', function() {
            expect($('.c-expander--unexpandable:visible').length).toEqual(1);
            expect($('.c-expander--reduceable:visible').length).toEqual(1);
            expect($('.c-expander--expandable:visible').length).toEqual(0);
            expect($('.c-expander--unreduceable:visible').length).toEqual(0);
          });
        });
        describe('When click on reduce_all', function() {
          beforeEach(function () {
            $('.c-expander--reduceable:visible').trigger('click');
          });
          it ('Should show ZERO aids', function() {
            expect($('.c-result-line:visible').length).toEqual(2);
            expect($('.c-result-aid:visible').length).toEqual(0);
          });      
          it ('Should show active expand_all, inactive reduce_all', function() {
            expect($('.c-expander--expandable:visible').length).toEqual(1);
            expect($('.c-expander--unreduceable:visible').length).toEqual(1);
            expect($('.c-expander--reduceable:visible').length).toEqual(0);
            expect($('.c-expander--unexpandable:visible').length).toEqual(0);
          });
        });
      });
      describe('When click on first and second collapsed line', function() {
        beforeEach(function () {
          $($('.c-result-line__content')[0]).trigger('click');
          $($('.c-result-line__content')[1]).trigger('click');
        });
        it ('Should show TWO aids', function() {
          expect($('.c-result-line:visible').length).toEqual(2);
          expect($('.c-result-aid:visible').length).toEqual(2);
        });      
        it ('Should show inactive expand_all, active reduce_all', function() {
          expect($('.c-expander--unexpandable:visible').length).toEqual(1);
          expect($('.c-expander--reduceable:visible').length).toEqual(1);
          expect($('.c-expander--expandable:visible').length).toEqual(0);
          expect($('.c-expander--unreduceable:visible').length).toEqual(0);
        });
      });
      describe('When click on expand_all', function() {
        beforeEach(function () {
          $('.c-expander--expandable:visible').trigger('click');
        });
        it ('Should show TWO aids', function() {
          expect($('.c-result-line:visible').length).toEqual(2);
          expect($('.c-result-aid:visible').length).toEqual(2);
        });      
        it ('Should show inactive expand_all, active reduce_all', function() {
          expect($('.c-expander--unexpandable:visible').length).toEqual(1);
          expect($('.c-expander--reduceable:visible').length).toEqual(1);
          expect($('.c-expander--expandable:visible').length).toEqual(0);
          expect($('.c-expander--unreduceable:visible').length).toEqual(0);
        });
        describe('When click on reduce_all', function() {
          beforeEach(function () {
            $('.c-expander--reduceable:visible').trigger('click');
          });
          it ('Should show ZERO aids', function() {
            expect($('.c-result-line:visible').length).toEqual(2);
            expect($('.c-result-aid:visible').length).toEqual(0);
          });      
          it ('Should show active expand_all, inactive reduce_all', function() {
            expect($('.c-expander--expandable:visible').length).toEqual(1);
            expect($('.c-expander--unreduceable:visible').length).toEqual(1);
            expect($('.c-expander--reduceable:visible').length).toEqual(0);
            expect($('.c-expander--unexpandable:visible').length).toEqual(0);
          });
        });
        describe('When click on first line', function() {
          beforeEach(function () {
            $($('.c-result-line__content')[0]).trigger('click');
          });
          it ('Should show ONE aid', function() {
            expect($('.c-result-line:visible').length).toEqual(2);
            expect($('.c-result-aid:visible').length).toEqual(1);
          });
          it ('Should show active reduce_all, active expand_all', function() {
            expect($('.c-expander--reduceable:visible').length).toEqual(1);
            expect($('.c-expander--expandable:visible').length).toEqual(1);
            expect($('.c-expander--unexpandable:visible').length).toEqual(0);
            expect($('.c-expander--unreduceable:visible').length).toEqual(0);
          });
        });
      });
    });


  });


  function nominal_content_with_2_lines() {
    return '<div class="c-result-list c-result-list--eligible">' +
'  <div class="c-result-header">' +
'    <strong class="h4-like c-result-header__title">' +
'    Vous pouvez bénéficier de' +
'    </strong>' +
'    <div class="c-expander-button c-expander-button--opened mrs is-hidden">' +
'      <button>Cacher</button>' +
'    </div>' +
'    <div class="c-expander-button c-expander-button--closed mrs is-hidden">' +
'      <button>Voir</button>' +
'    </div>' +
'    <div class="c-expander c-expander--reduceable c-expander--reduce is-hidden">' +
'      <small>Tout replier</small>' +
'      <span class="c-expander__svg-container">' +
'        <svg width="30px" height="30px" class="c-expander__svg">' +
'          <title>replier</title>' +
'        </svg>' +
'      </span>' +
'    </div>' +
'    <div class="c-expander c-expander--unreduceable c-expander--reduce">' +
'      <small>Tout replier</small>' +
'      <span class="c-expander__svg-container">' +
'        <svg width="30px" height="30px" class="c-expander__svg">' +
'          <title>replier</title>' +
'        </svg>' +
'      </span>' +
'    </div>' +
'    <div class="c-expander c-expander--expandable c-expander--expand">' +
'      <small>Tout déplier</small>' +
'      <span class="c-expander__svg-container">' +
'        <svg width="30px" height="30px" class="c-expander__svg" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 25 25">' +
'          <title>deplier</title>' +
'        </svg>' +
'      </span>' +
'    </div>' +
'    <div class="c-expander c-expander--unexpandable c-expander--expand is-hidden">' +
'      <small>Tout déplier</small>' +
'      <span class="c-expander__svg-container">' +
'        <svg width="30px" height="30px" class="c-expander__svg" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 25 25">' +
'          <title>deplier</title>' +
'        </svg>' +
'      </span>' +
'    </div>' +
'  </div>' +
'  <div class="c-result-list__lines js-apply">' +
'    <div class="c-result-line c-result-line--green projet-pro">' +
'      <div class="c-result-line__content" data-id="eligible__projet-pro">' +
'        <div class="c-result-line__icon">' +
'          <svg width="60" height="60" class="default-svg" version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" xmlns:xlink="http://www.w3.org/1999/xlink" enable-background="new 0 0 512 512">' +
'          </svg>' +
'        </div>' +
'        <div class="h4-like c-result-line__description">' +
'          1 ceci concerne le projet pro' +
'        </div>' +
'        <div class="c-result-line__action c-result-line__action--expanded is-hidden">' +
'          <svg width="30px" height="30px">' +
'            <title>replier</title>' +
'          </svg>' +
'        </div>' +
'        <div class="c-result-line__action c-result-line__action--reduced">' +
'          <svg width="30px" height="30px">' +
'            <title>deplier-ferme</title>' +
'          </svg>' +
'        </div>' +
'      </div>' +
'      <div class="is-visible c-result-line__aids"></div>' +
'      <a class="aide-aux-plus-de-30-ans c-result-aid first js-possible-name is-hidden" href="/aides/detail/aide-aux-plus-de-30-ans?for_id=MzQsUlBTX1JGUEFfUkZGX3BlbnNpb25yZXRyYWl0ZSxuaWwsYXV0cmVzX2NhdCxvdWksbml2ZWF1XzUsbW9pbnNfZF91bl9hbixub24sbm9uLG5pbCxuaWwsbmlsLG5pbCxuaWwsbmlsLG5pbCxuaWwsbm9uLG5pbCxuaWw=">' +
'        <div class="c-result-aid__text">' +
'          <div class="h4-like c-result-aid__title">' +
'            aide aux plus de 30 ans' +
'          </div>' +
'          <div class="c-result-aid__subtitle">' +
'            un aide bienvenue' +
'          </div>' +
'        </div>' +
'        <div class="c-result-aid__cta">' +
'          En savoir plus&nbsp;&gt;' +
'        </div>' +
'      </a>' +
'    </div>' +
'    <div class="c-result-line c-result-line--green emplacement-id">' +
'      <div class="c-result-line__content" data-id="eligible__emplacement-id">' +
'        <div class="c-result-line__icon">' +
'          <svg width="60" height="60" class="default-svg" version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" xmlns:xlink="http://www.w3.org/1999/xlink" enable-background="new 0 0 512 512">' +
'          </svg>' +
'        </div>' +
'        <div class="h4-like c-result-line__description">' +
'          1 aides liées à l\'emplacement' +
'        </div>' +
'        <div class="c-result-line__action c-result-line__action--expanded is-hidden">' +
'          <svg width="30px" height="30px">' +
'            <title>replier</title>' +
'          </svg>' +
'        </div>' +
'        <div class="c-result-line__action c-result-line__action--reduced">' +
'          <svg width="30px" height="30px">' +
'            <title>deplier-ferme</title>' +
'          </svg>' +
'        </div>' +
'      </div>' +
'      <div class="is-visible c-result-line__aids"></div>' +
'      <a class="c-result-aid first js-possible-name majeur-ou-qpv is-hidden" href="/aides/detail/majeur-ou-qpv?for_id=MzQsUlBTX1JGUEFfUkZGX3BlbnNpb25yZXRyYWl0ZSxuaWwsYXV0cmVzX2NhdCxvdWksbml2ZWF1XzUsbW9pbnNfZF91bl9hbixub24sbm9uLG5pbCxuaWwsbmlsLG5pbCxuaWwsbmlsLG5pbCxuaWwsbm9uLG5pbCxuaWw=">' +
'        <div class="c-result-aid__text">' +
'          <div class="h4-like c-result-aid__title">' +
'            majeur ou qpv' +
'          </div>' +
'          <div class="c-result-aid__subtitle">' +
'            si vous êtes en QPV OU MAJEUR' +
'          </div>' +
'        </div>' +
'        <div class="c-result-aid__cta">' +
'          En savoir plus&nbsp;&gt;' +
'        </div>' +
'      </a>' +
'    </div>' +
'  </div>' +
'</div>';
  }

});

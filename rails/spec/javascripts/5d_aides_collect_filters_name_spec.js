//= require custom/aides/aides_collect_filters_name.js
describe('aides_collect_filters_name.js', function() {


  describe('Nominal', function() {
    beforeAll(function() { 
      MagicLamp.load("aides");
    });
    afterAll(function() { 
      $(".magic-lamp").remove();
    });
    it('Nominal : returns array', function() {
        res = clara.aides_collect_filters_name.please();
        expect(res).toEqual([
           'travailler-en-alternance',
            's-informer-sur-contrats-specifiques',
            'travailler-a-l-international',
            'garder-enfant',
            'creer-entreprise',
            'accompagne-recherche-emploi',
            'trouver-change-de-metier',
            'se-deplacer',
            'aides-employeurs',
            'se-former-valoriser-ses-competences']);
    });
  });

});

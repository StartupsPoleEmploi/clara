describe("Étape 4", function() {

  const MAIN_TITLE_SELECTOR = ".c-newaid-title"

  before(function() {
    cy.connect_as_contributeur1()
  })

  after(function() {
    cy.delete_an_aid("test-stage-4")
  })

  before(function() {
    cy.visit('/admin/aid_creation/new_aid_stage_1')

    cy.get('.field-unit input#aid_name').type('test-stage-4')
    cy.get('.field-unit select#aid_contract_type_id').select("1")
    
    cy.get('button.c-newaid-actionrecord').click()
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_2')})

    cy.get('button.c-newaid-actionrecord').click()
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_3')})
  })

  it("Si on vient de l'étape 3, on arrive sur l'étape 4 en création", function() {
    // when
    cy.get('button.c-newaid-actionrecord').click()
    // then
    cy.get(MAIN_TITLE_SELECTOR).should('have.text', 'Créer une aide')
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_4')})
  })

  it("L'étape 4 est optionnelle : si on valide directement, on arrive sur l'étape 5", function() {
    // when
    cy.get('#record_root_rule').click()
    // then
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_5')})
  })

  it("On peut accéder à l'écran directement en modification", function() {
    // when
    cy.visit('/admin/aid_creation/new_aid_stage_4?modify=true&slug=test-stage-4').then((contentWindow) => {
      // then
      cy.get(MAIN_TITLE_SELECTOR).should('have.text', 'Modifier une aide')
    })
  })

  describe("Enregistrement d'une règle", function() {
    beforeEach(function() {
      cy.visit('/admin/aid_creation/new_aid_stage_4?modify=true&slug=test-stage-4')
    })

    it("On peut enregistrer une règle simple ...", function() {
      // given
      cy.get('select#rule_variable_id').select('v_category')
      cy.get('select#rule_value_eligible_selectible').select('cat_12345')
      cy.get('.c-apprule-button.is-validation').click()
      // when
      cy.get('#record_root_rule').click()
      cy.visit('/admin/get_cache')
      cy.get('#button-empty-cache').click()
      cy.wait(2000)
      cy.visit('/admin/aids/test-stage-4')
      cy.get('#label_tab_4').click()
      // then
      cy.get(".c-display-appfield").shouldHaveTrimmedText('il faut remplir la condition suivante : Être en catégorie 1, 2, 3, 4 ou 5');
    })
    it("... avec un critère géographique hors DOM", function() {
      // given
      cy.get('#tout_sauf_domtom').click()

      // when
      cy.get('#record_root_rule').click()
      cy.visit('/admin/get_cache')
      cy.get('#button-empty-cache').click()
      cy.wait(2000)
      cy.visit('/admin/aids/test-stage-4')
      cy.get('#label_tab_4').click()

      // then
      cy.get(".c-display-appfield").shouldHaveTrimmedText("il faut réunir l'ensemble des 2 conditions suivantes Être en catégorie 1, 2, 3, 4 ou 5 l'ensemble des 6 conditions suivantes Ne pas résider dans le département Guadeloupe Ne pas résider dans le département Martinique Ne pas résider dans le département Guyane Ne pas résider dans le département La Réunion Ne pas résider dans le département Saint-Pierre-et-Miquelon Ne pas résider dans le département Mayotte");
    })
    it("... avec un critère géographique DOM uniquement", function() {
      // given
      cy.get('#domtom_seulement').click()

      // when
      cy.get('#record_root_rule').click()
      cy.visit('/admin/get_cache')
      cy.get('#button-empty-cache').click()
      cy.wait(2000)
      cy.visit('/admin/aids/test-stage-4')
      cy.get('#label_tab_4').click()

      // then
      cy.get(".c-display-appfield").shouldHaveTrimmedText("il faut réunir l'ensemble des 2 conditions suivantes Être en catégorie 1, 2, 3, 4 ou 5 au moins une des conditions suivantessoit Résider dans le département Guadeloupesoit Résider dans le département Martiniquesoit Résider dans le département Guyanesoit Résider dans le département La Réunionsoit Résider dans le département Saint-Pierre-et-Miquelonsoit Résider dans le département Mayotte");
    })
    it("On peut enregistrer une règle composite", function() {
      // given
      cy.visit('/admin/aid_creation/new_aid_stage_4?modify=true&slug=test-stage-4')

      cy.get('.js-or:last').click()
      cy.get('select#rule_variable_id').select('v_qpv')
      cy.get('select#rule_value_eligible_selectible').select('oui')
      cy.get('.c-apprule-button.is-validation').click()
      cy.get('input#tout').click() // toute la france

      cy.get('.js-and:first').click()
      cy.get('select#rule_variable_id').select('v_age')
      cy.get('select#rule_operator_kind').select('more_than')
      cy.get('input#rule_value_eligible').type('18')

      cy.get('.c-apprule-button.is-validation').click()

      // when
      cy.get('#record_root_rule').click()
      cy.visit('/admin/get_cache')
      cy.get('#button-empty-cache').click()
      cy.wait(2000)
      cy.visit('/admin/aids/test-stage-4')
      cy.get('#label_tab_4').click()
      // then
      cy.get(".c-display-appfield").shouldHaveTrimmedText("il faut réunir au moins une des conditions suivantessoit l'ensemble des 2 conditions suivantes Être en catégorie 1, 2, 3, 4 ou 5 Avoir un âge strictement supérieur à 18 anssoit Être en Quartier Prioritaire de la Ville");
    })


  })
})


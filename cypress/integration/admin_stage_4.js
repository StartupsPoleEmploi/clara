describe("Étape 4", function() {

  const MAIN_TITLE_SELECTOR = ".c-newaid-title"

  before(function() {
    cy.connect_as_contributeur1()
  })

  // after(function() {
  //   cy.delete_an_aid("test-stage-4")
  // })

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
    before(function() {
      cy.visit('/admin/aid_creation/new_aid_stage_4?modify=true&slug=test-stage-4')
    })

    it("On peut enregistrer une règle simple, elle apparaît en lecture après vidage du cache", function() {
      cy.get('select#rule_variable_id').select('v_category')
      cy.get('select#rule_value_eligible_selectible').select('cat_12345')
      cy.get('.c-apprule-button.is-validation').click()
      // when
      cy.get('#record_root_rule').click()
      cy.visit('/admin/get_cache')
      cy.wait(500)
      cy.get('#button-empty-cache').click()
      cy.wait(2000)
      cy.visit('/admin/aids/test-stage-4')
      cy.get('#label_tab_4').click()
      
      // cy.get(".c-display-appfield").should($el => expect($el.text().trim()).to.equal('il faut remplir la condition suivante : Être en catégorie 1, 2, 3, 4 ou 5'));
      cy.get(".c-display-appfield").shouldHaveTrimmedText('il faut remplir la condition suivante : Être en catégorie 1, 2, 3, 4 ou 5');

    })
  })


})


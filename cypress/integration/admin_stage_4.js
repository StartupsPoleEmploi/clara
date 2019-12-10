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
    // then
    cy.get(MAIN_TITLE_SELECTOR).should('have.text', 'Créer  une aide')
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_4')})
  })

  it("L'étape 4 est optionnelle : si on valide directement, on arrive sur l'étape 5", function() {
    // when
    cy.get('button.c-newaid-actionrecord').click()
    // then
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_5')})
  })

  it("On peut accéder à l'écran directement en modification", function() {
    // when
    cy.visit('/admin/aid_creation/new_aid_stage_4?modify=true&slug=test-stage-4').then((contentWindow) => {
      // then
      cy.get(MAIN_TITLE_SELECTOR).should('have.text', 'Modifier  une aide')
    })
  })


})


describe("Quand on arrive sur la question allocation", function () {

  before(function () {
    cy.visit('/')
    cy.get("body.c-body.welcome.index").should('exist')
    cy.visit('/allocation_questions/new')
  })

  it("Aucun radiobutton coché", function () {
    cy.get('input[type="radio"]').should('not.be.checked')
  })

  it("focus sur le premier radiobutton ", function () {
    cy.get('input[type="radio"]').first().should('have.focus')
  })

  it("Absence d'erreur lorqu'on arrive sur la page", function () {
    cy.get('.c-label.is-error').should('not.exist')
  })

  it("Erreur si on ne coche rien ", function () {
    // when
    cy.get('input[value="Continuer"]').click()
    // then
    cy.get('.c-label.is-error').should('exist')
  })

  it("Cas nominal : on coche une case et on valide, ", function () {
    // given
    cy.visit('/allocation_questions/new')
    cy.get('input[type="radio"]').first().check()
    // when
    cy.get('input[value="Continuer"]').click()
    // then
    cy.location('pathname').should('not.contain', 'allocation_questions')
  })

  it("On peut revenir à l'écran précédent", function () {
    // given
    cy.visit('/allocation_questions/new')
    // when
    cy.get('input[value="Revenir"]').click()
    // then
    cy.location('pathname').should('not.contain', 'allocation_questions')
  })

})

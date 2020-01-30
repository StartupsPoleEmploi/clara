describe("Quand on arrive sur la question autres", function () {

  before(function () {
    cy.visit('/')
    cy.get("body.c-body.welcome.index").should('exist')
    cy.visit('/other_questions/new')
  })

  it("Les éléments : retour, progressbar, et numéro de question sont présents", function () {
    cy.get('.c-progressbar').should("exist")
    cy.get('.c-question-number').should("exist")
    cy.get('.c-back-question').should("exist")
  })

  it("Aucun checkbox coché", function () {
    cy.get('input[type="checkbox"]').should('not.be.checked')
  })

  it("focus sur le premier checkbox", function () {
    cy.get('input[type="checkbox"]').first().should('have.focus')
  })

  it("Absence d'erreur lorqu'on arrive sur la page", function () {
    cy.get('.c-label.is-error').should('not.exist')
  })

  it("Erreur si on ne remplit rien ", function () {
    // when
    cy.get('input[value="Continuer"]').click()
    // then
    cy.get('.c-label.is-error').should('exist')
  })

  it("Cas nominal : on côche un choix et on valide, ", function () {
    // given
    cy.visit('/other_questions/new')
    cy.get('input[type="checkbox"]').first().check()
    // when
    cy.get('input[value="Continuer"]').click()
    // then
    cy.location('pathname').should('not.contain', 'other_questions')
    cy.location('pathname').should('contain', 'aides')
  })

})

describe("Quand on arrive sur la question autres", function () {

  before(function () {
    cy.visit('/other_questions/new')
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

  it("On peut revenir à l'écran précédent", function () {
    // given
    cy.visit('/other_questions/new')
    // when
    cy.get('input[value="Revenir"]').click()
    // then
    cy.location('pathname').should('not.contain', 'other_questions')
  })

})

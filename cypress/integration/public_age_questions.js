describe("Quand on arrive sur la question âge", function () {

  before(function () {
    cy.visit('/age_questions/new')
  })

  it("Champ nombre vide", function () {
    cy.get('input[type="number"]').should('be.empty')
  })

  it("focus sur le champ nombre", function () {
    cy.get('input[type="number"]').first().should('have.focus')
  })

  it("Absence d'erreur lorqu'on arrive sur la page", function () {
    cy.get('.c-label.is-error').should('not.exist')
    // Absence d'erreur
  })

  it("Erreur si on ne remplit rien ", function () {
    // when
    cy.get('input[value="Continuer"]').click()
    // then
    cy.get('.c-label.is-error').should('exist')
  })

  it("Cas nominal : on renseigne un age et on valide, ", function () {
    // given
    cy.visit('/age_questions/new')
    cy.get('input[type="number"]').first().type("44")
    // when
    cy.get('input[value="Continuer"]').click()
    // then
    cy.location('pathname').should('not.contain', 'age_questions')
  })

  it("On peut revenir à l'écran précédent", function () {
    // given
    cy.visit('/age_questions/new')
    // when
    cy.get('input[value="Revenir"]').click()
    // then
    cy.location('pathname').should('not.contain', 'age_questions')
  })

})
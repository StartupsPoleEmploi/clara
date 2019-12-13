describe("Quand on arrive sur la question adresse", function () {

  before(function () {
    cy.visit('/')
    cy.get("body.c-body.welcome.index").should('exist')
    cy.visit('/address_questions/new')
  })

  it("Champ nombre vide", function () {
    cy.get('input[type="number"]').should('be.empty')
  })

  it("focus sur le champ nombre", function () {
    cy.get('input[type="number"]').first().should('have.focus')
  })

  it("Absence d'erreur lorqu'on arrive sur la page", function () {
    cy.get('.c-label.is-error').should('not.exist')
  })

  it("Pas d'erreur si on ne remplit rien ", function () {
    // when
    cy.get('input[value="Continuer"]').click()
    // then
    cy.get('.c-label.is-error').should('not.exist')
  })

  it("Cas nominal : on renseigne un code postal, on sélectionne une ville et on valide, ", function () {
    // given
    cy.visit('/address_questions/new')
    cy.get('input[type="number"]').first().type("44200")
    cy.get('li.autocomplete-item').should("exist")
    cy.get('li.autocomplete-item').first().click()
    // when
    cy.get('input[value="Continuer"]').click()
    // then
    cy.location('pathname').should('not.contain', 'address_questions')
  })

  it("On peut revenir à l'écran précédent", function () {
    // given
    cy.visit('/address_questions/new')
    // when
    cy.get('input[value="Revenir"]').click()
    // then
    cy.location('pathname').should('not.contain', 'address_questions')
  })

})

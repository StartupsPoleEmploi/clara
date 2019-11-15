describe("Quand on arrive sur la question de montant de l'allocation", function () {

  before(function () {
    cy.visit('/')
    cy.visit('/are_questions/new')
  })

  it("Champ nombre vide", function () {
    cy.get('input[type="number"]').should('have.value', '')
  })

  it("focus sur le champ nombre", function () {
    cy.get('input[type="number"]').first().should('have.focus')
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

  it("Cas nominal : on renseigne un montant et on valide, ", function () {
    // given
    cy.visit('/are_questions/new')
    cy.get('input[type="number"]').first().clear()
    cy.get('input[type="number"]').first().type("823")
    // when
    cy.get('input[value="Continuer"]').click()
    // then
    cy.location('pathname').should('not.contain', 'are_questions')
  })

  it("On peut revenir à l'écran précédent", function () {
    // given
    cy.visit('/are_questions/new')
    // when
    cy.get('input[value="Revenir"]').click()
    // then
    cy.location('pathname').should('not.contain', 'are_questions')
  })

  it("Si on revient à la question du montant, la valeur est pré-remplie", function () {
    // given
    // when
    cy.visit('/are_questions/new')
    // then
    cy.get('input[type="number"]').first().should('have.value', '823')
  })

})

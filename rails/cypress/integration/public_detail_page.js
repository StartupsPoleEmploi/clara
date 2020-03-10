describe("Quand on arrive sur le détail d'une aide", function () {

  before(function () {
    cy.visit('/aides/detail/erasmus')
    cy.get("body.c-body.detail.show").should('exist')
  })

  it("Un feedback est disponible", function () {
    cy.get(".c-feedback").should('exist')
    cy.get("").shouldHaveTextStartingWith('Cette page est-elle utile ?')
  })

  it("Si on coche oui, un remerciement est affiché", function () {

  })

  it("Si on coche non, un formulaire est affiché", function () {

  })

  it("Si on coche non, qu'on rempli le formulaire, et qu'on le soumet : un remerciement est affiché", function () {

  })



})

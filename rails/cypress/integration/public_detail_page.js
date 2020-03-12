describe("Quand on arrive sur le détail d'une aide", function () {

  before(function () {
    cy.visit('/aides/detail/erasmus')
    cy.get("body.c-body.detail.show").should('exist')
  })

  it("Un feedback est disponible", function () {
    cy.get(".c-feedback").should('exist')
    cy.get(".c-feedback").shouldHaveTextStartingWith('Cette page est-elle utile ?')
  })

  it("Si on coche oui, un remerciement est affiché", function () {
    cy.get(".c-feedback .js-thankyou").should('not.be.visible')
    cy.get(".c-feedback .js-expandmore-yes").click()
    cy.get(".c-feedback .js-thankyou").should('be.visible')
  })

  it("Si on coche non, un formulaire est affiché", function () {
    cy.reload()
    cy.get(".c-feedback form#post_feedback_form").should('not.be.visible')
    cy.get(".c-feedback .js-expandmore-no").click()
    cy.get(".c-feedback form#post_feedback_form").should('be.visible')
  })

  it("Si on rempli le formulaire, et qu'on le soumet : un remerciement est affiché", function () {
    cy.get(".c-feedback .js-thankyou").should('not.be.visible')
    cy.get(".c-feedback input#submit_feedback").click()
    cy.get(".c-feedback .js-thankyou").should('be.visible')
  })



})

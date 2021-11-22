context('Simple visiteur : Parcours de la question du montant', () => {


  before(() => {
    cy.request('/cypress_rails_reset_state')
  })


  describe("Pour un visiteur qui commence par la question du montant", () => {

    beforeEach(() => {
      cy.visit('/are_questions/new')
    })
    it("Cas nominal", () => {
      //When
      cy.get('#montant').should("exist")
      cy.get('#montant').type("842")
      cy.get('.js-next').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/are_questions/new')})
    })

  })


})

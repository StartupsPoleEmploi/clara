context('Simple visiteur : Parcours de la question age', () => {


  before(() => {
    cy.request('/cypress_rails_reset_state')
  })


  describe("Pour un visiteur qui commence par la question age", () => {

    beforeEach(() => {
      cy.visit('/age_questions/new')
    })
    it("Cas nominal", () => {
      //When
      cy.get('#age').should("exist")
      cy.get('#age').type("26")
      cy.get('.js-next').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/age_questions/new')})
    })

  })


})

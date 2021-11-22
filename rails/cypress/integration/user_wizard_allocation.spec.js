context('Simple visiteur : Parcours de la question allocation', () => {


  before(() => {
    cy.request('/cypress_rails_reset_state')
  })


  describe("Pour un visiteur qui commence par la question allocation", () => {

    beforeEach(() => {
      cy.visit('/allocation_questions/new')
    })
    it("Cas nominal", () => {
      //When
      cy.get('#ARE_ASP').should("exist")
      cy.get('#ARE_ASP').click()
      cy.get('.js-next').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/allocation_questions/new')})
    })

  })


})

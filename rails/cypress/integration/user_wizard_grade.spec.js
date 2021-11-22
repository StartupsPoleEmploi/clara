context('Simple visiteur : Parcours de la question diplome', () => {


  before(() => {
    cy.request('/cypress_rails_reset_state')
  })


  describe("Pour un visiteur qui commence par la question diplome", () => {

    beforeEach(() => {
      cy.visit('/grade_questions/new')
    })
    it("Cas nominal", () => {
      //When
      cy.get('#niveau_4').should("exist")
      cy.get('#niveau_4').click()
      cy.get('.js-next').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/grade_questions/new')})
    })

  })


})

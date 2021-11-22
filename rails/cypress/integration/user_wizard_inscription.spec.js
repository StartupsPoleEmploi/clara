context('Simple visiteur : Parcours de la question inscription', () => {


  before(() => {
    cy.request('/cypress_rails_reset_state')
  })


  describe("Pour un visiteur qui commence par la question inscription", () => {

    beforeEach(() => {
      cy.visit('/inscription_questions/new')
    })
    it("Cas d'erreur", () => {
      //Given
      cy.get('.c-label.is-error').should("not.exist")
      cy.get('#moins_d_un_an').should("exist")
      //When
      cy.get('.js-next').click()
      //Then
      cy.get('.c-label.is-error').should("exist")
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/inscription_questions/new')})
    })
    it("Cas de retour", () => {
      //When
      cy.get('.c-back-question').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/inscription_questions/new')})
    })
    it("Cas nominal", () => {
      //When
      cy.get('#moins_d_un_an').should("exist")
      cy.get('#moins_d_un_an').click()
      cy.get('.js-next').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/inscription_questions/new')})
    })

  })


})

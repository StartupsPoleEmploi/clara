context('Simple visiteur : Parcours de la question categorie', () => {


  before(() => {
    cy.request('/cypress_rails_reset_state')
  })


  describe("Pour un visiteur qui commence par la question categorie", () => {

    beforeEach(() => {
      cy.visit('/category_questions/new')
    })
    it("Cas d'erreur", () => {
      //Given
      cy.get('.c-label.is-error').should("not.exist")
      cy.get('#cat_12345').should("exist")
      //When
      cy.get('.js-next').click()
      //Then
      cy.get('.c-label.is-error').should("exist")
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/category_questions/new')})
    })
    it("Cas de retour", () => {
      //When
      cy.get('.c-back-question').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/category_questions/new')})
    })
    it("Cas nominal", () => {
      //When
      cy.get('#cat_12345').should("exist")
      cy.get('#cat_12345').click()
      cy.get('.js-next').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/category_questions/new')})
    })

  })


})

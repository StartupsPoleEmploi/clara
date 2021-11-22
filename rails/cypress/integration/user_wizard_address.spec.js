context('Simple visiteur : Parcours de la question adresse', () => {


  before(() => {
    cy.request('/cypress_rails_reset_state')
  })


  describe("Pour un visiteur qui commence par la question categorie", () => {

    beforeEach(() => {
      cy.visit('/address_questions/new')
    })
    it("Cas nominal", () => {
      //When
      cy.get('#search').should("exist")
      cy.get('#search').type("49490")
      cy.get('li.autocomplete-item').should("exist")
      cy.get('li.autocomplete-item').first().click()
      cy.get('.js-next').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/address_questions/new')})
    })

  })


})

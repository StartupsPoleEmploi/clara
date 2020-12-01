context('Recherche depuis la home', () => {


  before(() => {
    cy.visit('/')
  })

  describe("Pour un visiteur qui découvre la home", () => {

    it("On peut faire une recherche 'plain-text', au moins un résultat est trouvé", () => {
      // Given
      cy.get('#plain_text_search').should("exist")
      cy.get('#plain_text_search').type("mobil")
      // When
      cy.get('.c-search-front-submit').click()
      // Then
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/get_search_front?usearch=mobil')})
      cy.get('.c-result-line-front-item').should("exist")

    })

  })


})

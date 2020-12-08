context('Pages autres que le questionnaire', () => {


  before(() => {
    cy.visit('/')
  })

  describe("Pour un visiteur qui découvre la home", () => {

    it("On peut faire une recherche 'plain-text', au moins un résultat est trouvé", () => {

      // Given
      cy.get('.c-search-front-submit.c-loop.js-modal').click()
      cy.get('#u-search-modal').should("exist")
      cy.get('#u-search-modal').type("descr")
      // When
      cy.get('.c-search-front-submit-modal').click()
      // Then
      cy.location().should((loc) => {
        expect(loc.pathname).to.eq('/get_search_front')
        expect(loc.search).to.eq('?usearch=descr')
      })
      cy.get('.c-result-line-front-item').should("exist")

    })

    it("On peut aller voir toutes les aides, et faire une recherche dessus", () => {

      // Given
      // When
      cy.get('a.c-link-to-all-aides').click()
      cy.location().should((loc) => {
        // Then
        expect(loc.pathname).to.eq('/aides')
      })

      // Given
      // When
      cy.get('input.c-search-usearch').type("mob")
      cy.get('input.c-search-form-submit').click()
      cy.location().should((loc) => {
        // Then
        expect(loc.pathname).to.eq('/aides')
        expect(loc.search).to.eq('?usearch=mob')
      })

    })

  })

})

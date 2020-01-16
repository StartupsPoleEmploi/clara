describe("En tant que simple visiteur", function () {

  it("Je peux chercher une aide", function () {
    cy.visit('/')
    cy.get("body.welcome.index").should("exist")
    cy.get("input.c-search-front-usearch").clear()
    cy.get("input.c-search-front-usearch").type("mobilité")
    cy.get("input.c-search-front-submit").click()
    cy.get("body.aides.get_search_front").should("exist")
    cy.get(".c-result-front-subtitle__number").invoke('text').should(
     (txt) => {expect(txt.indexOf('éléments trouvés')).to.be.greaterThan(0)}
    )
  })

  it("Je peux partager le lien d'une recherche", function () {
    cy.visit('/get_search_front?page=2&usearch=aide')
    cy.get("body.aides.get_search_front").should("exist")
    cy.get(".c-result-front-subtitle__number").invoke('text').should(
     (txt) => {expect(txt.indexOf('éléments trouvés')).to.be.greaterThan(0)}
    )

  })


})


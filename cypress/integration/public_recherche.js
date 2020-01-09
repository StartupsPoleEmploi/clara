describe("En tant que simple visiteur", function () {

  it("Je peux chercher une aide", function () {
    cy.visit('/')
    cy.get("body.welcome.index").should("exist")
    cy.get("input.c-search-front-usearch").clear()
    cy.get("input.c-search-front-usearch").type("mobilité")
    cy.get("input.c-search-front-submit").click()
    cy.get("body.aides.get_search_front").should("exist")
  })


})


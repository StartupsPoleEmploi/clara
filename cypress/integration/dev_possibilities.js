describe("En tant que dev", function () {

  it("Je peux délibérément provoquer une erreur 500 pour tester les remontée d'erreur", function () {
    cy.visit('/divide_by_zero', {failOnStatusCode: false}).then(() => { 
      cy.title().should('include', "Exception caught")
    })
  })

  it("Je peux afficher l'IP courante", function () {
    cy.visit('/reqip').then(() => { 
      cy.get("h1").shouldHaveTrimmedText("127.0.0.1")
    })
  })
  
  it("Je peux afficher les outils applicatifs", function () {
    cy.visit('/req').then(() => { 
      cy.get(".debug_dump").invoke('text').should(
        (txt) => {expect(txt.replace(/[\s\n\r]+/g, '').indexOf('{"SCRIPT_NAME')).to.eq(0)}
      )
    })
  })
  
})


describe("En tant que dev, connecté comme superadmin", function () {

  before(function() {
    cy.connect_as_superadmin()
  })

  it("Je peux délibérément provoquer une erreur 500 pour tester les remontée d'erreur", function () {
    cy.visit('/divide_by_zero', {failOnStatusCode: false}).then(() => { 
      cy.title().should('include', "Exception caught")
    })
  })

  it("Je peux afficher quelques stats de la base", function () {
    cy.visit('/admin/status').then(() => { 
      cy.get("body pre").invoke('text').should(
        (txt) => {expect(txt.replace(/[\s\n\r]+/g, '').indexOf('{"db_stats":{')).to.eq(0)}
      )
    })
  })
  
  it("Je peux afficher les outils applicatifs", function () {
    cy.visit('/admin/req').then(() => { 
      cy.get(".debug_dump").invoke('text').should(
        (txt) => {expect(txt.replace(/[\s\n\r]+/g, '').indexOf('{"SCRIPT_NAME')).not.to.eq(-1)}
      )
    })
  })
  
})


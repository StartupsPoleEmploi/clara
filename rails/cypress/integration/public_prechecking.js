describe("En tant que visiteur DDCT", function () {

  it("Financement, aide à la formation : Si je clique JE COMMENCE, le(s) filtre(s) correspondant(s) à la formation est précoché à la question filtres", function () {
    cy.visit('/aides/type/financement-aide-a-la-formation')
    cy.get('.c-detail-cta.js-contract').click()
    cy.visit('/filter_questions/new')
    cy.get('input#se-former-valoriser-ses-competences').should('be.checked') 
    cy.get('input#percevoir-une-remuneration-pendant-la-formation').should('be.checked') 
    cy.get('input#se-deplacer').should('be.checked') 
  })

})


describe("En tant que visiteur DDCT", function () {

  beforeEach(function() {
    cy.visit('/')
  })

  it("Si je clique JE COMMENCE, le filtre correspondant à la formation est précoché à la question filtres", function () {
    cy.get('.c-detail-cta.js-contract').click()
    cy.location().should((loc) => { expect(loc.pathname).contains('/new')})
    cy.visit('/filter_questions/new')
    cy.get('input#se-former-valoriser-ses-competences').should('be.checked') 
  })

})


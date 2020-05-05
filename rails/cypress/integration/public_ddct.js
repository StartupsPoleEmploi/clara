describe("En tant que visiteur DDCT", function () {

  before(function() {
    cy.visit('/')
  })


  it("Il y a une pastille dédiée à la formation sur la page d'accueil", function () {
    cy.get('.c-newhomeexample__card-title strong').eq(2).shouldHaveTrimmedText("En formation")
  })

  it("Si je clique sur la pastille, je trouve les frais de repas, d'hébergement, de km, d'agepi parmi les aides", function () {
    cy.get('.c-newhomeexample__card-plus').eq(2).click()
    cy.location().should((loc) => { expect(loc.pathname).contains('/aides/type/financement-aide-a-la-formation')})
      cy.get('.c-result-aid.aide-a-la-mobilite-frais-de-repas').should("exist")
      cy.get('.c-result-aid.aide-a-la-mobilite-frais-d-hebergement').should("exist")
      cy.get('.c-result-aid.aide-a-la-mobilite-frais-de-deplacement').should("exist")
      cy.get('.c-result-aid.agepi').should("exist")
  })

  it("Si je clique JE COMMENCE, le filtre correspondant à la formation est précoché à la question filtres", function () {
    cy.get('.c-detail-cta.js-contract').click()
    cy.location().should((loc) => { expect(loc.pathname).contains('/new')})
    cy.visit('/filter_questions/new')
    cy.get('input#se-former-valoriser-ses-competences').should('be.checked') 
  })

})


describe("En tant que visiteur DDCT", function () {


    // cy.get('input#se-deplacer').should('be.checked') 
    // cy.get('input#creer-entreprise').should('be.checked') 
    // cy.get('input#se-former-valoriser-ses-competences').should('be.checked') 
    // cy.get('input#percevoir-une-remuneration-pendant-la-formation').should('be.checked') 
    // cy.get('input#garder-enfant').should('be.checked') 
    // cy.get('input#accompagne-recherche-emploi').should('be.checked') 
    // cy.get('input#trouver-change-de-metier').should('be.checked') 
    // cy.get('input#s-informer-sur-contrats-specifiques').should('be.checked') 
    // cy.get('input#travailler-a-l-international').should('be.checked') 
    // cy.get('input#pres_de_chez_vous').should('be.checked') 

  it("Si je clique JE COMMENCE, le filtre correspondant à la formation est précoché à la question filtres", function () {
    cy.visit('/aides/type/financement-aide-a-la-formation')
    cy.get('.c-detail-cta.js-contract').click()
    cy.visit('/filter_questions/new')
    cy.get('input#se-former-valoriser-ses-competences').should('be.checked') 
    cy.get('input#percevoir-une-remuneration-pendant-la-formation').should('be.checked') 
    cy.get('input#se-deplacer').should('be.checked') 
  })

})


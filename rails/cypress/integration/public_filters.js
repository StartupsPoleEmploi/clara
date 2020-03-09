describe("Pour un visiteur", function () {

  const AMOB_SPECTACLE = '[data-aslug="aide-a-la-mobilite-professionnelle-des-artistes-et-technicien-ne-s-du-spectacle"]'

  it("Quand on directement sur le résultat d'une simulation grâce à l'URL", function () {
    // given
    cy.visit('/aides?for_id=MjMsNSxuLCw0LG8sbiw0MjIxOCw0MjAwMCxub3RfYXBwbGljYWJsZSxu')
  })

  it("Aucune case de filtre n'est coché", function () {
    cy.get('#o_all_filters input[type="checkbox"]').should('not.be.checked') 
  })
  it("Si on coche une case et qu'on va à la question filtre, le filtre correspondant est checké", function () {
    cy.get('#o_all_filters div[data-name="se-deplacer"] input[type="checkbox"]').check()
    cy.visit('/filter_questions/new')
    cy.get('input#se-deplacer').should('exist')
    cy.get('input#se-deplacer').should('be.checked')
  })
  it("Si on coche une case sur la question filtre, elle apparaît aussi sur l'écran de résultat", function () {
    cy.get('input#garder-enfant').check()
    cy.get('input#se-deplacer').should('be.checked')
    cy.get('input#garder-enfant').should('be.checked')
    cy.get('.js-next').click()

    cy.get('#o_all_filters div[data-name="se-deplacer"] input[type="checkbox"]').should('exist')
    cy.get('#o_all_filters div[data-name="se-deplacer"] input[type="checkbox"]').should('be.checked')
    cy.get('#o_all_filters div[data-name="garder-enfant"] input[type="checkbox"]').should('exist')
    cy.get('#o_all_filters div[data-name="garder-enfant"] input[type="checkbox"]').should('be.checked')

  })

})


describe("Cacher les filtres inutiles à la création de l'aide pour un simple admin", function() {
  before('On peut se connecter comme simple admin', function() {
    cy.visit('/sign_in')
    cy.get('#session_email')
      .type('admin@clara.com').should('have.value', 'admin@clara.com')
    cy.get('#session_password')
      .type('foo').should('have.value', 'foo')
    cy.get('.c-login-connect input').click()
    cy.location('pathname').should('include', '/admin')
    cy.get('body').should('have.attr', 'data-path', 'admin_aids_path')
  })
  it("Comme simple admin on a accès à la création d'aide", function() {
    cy.visit('/admin/aids/new')
  })
  it("En cliquant sur l'étape 3, on ne voit que 2 champs : résumé et filtres de pages de résultats", function() {
    cy.get('#label_tab_3').click()
    cy.get('#tab_3 .field-unit').should('have.length', 2)
    cy.get('#tab_3 .field-unit .field-unit__label label').first().should('have.text', "Résumé")
    cy.get('#tab_3 .field-unit .field-unit__label label').last().should('have.text', "Filtres sur la page de résultat")

  })
})


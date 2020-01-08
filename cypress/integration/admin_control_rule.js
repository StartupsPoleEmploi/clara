describe("Contrôle de règle", function() {

  before(function() {
    cy.connect_as_superadmin()
    
  })

  it("Comme superadmin, on peut visiter le détail d'une règle", function() {
    cy.visit('/admin/rules/362')
    cy.get('body[data-path="admin_rule_path"]').should('exist')
  })

  it("Comme superadmin, on accéder à l'écran de contrôle", function() {
    cy.get('.js-control-rule-btn').click()
    cy.get('#rule_check_title').shouldHaveTrimmedText('Contrôle de la règle')
  })

})


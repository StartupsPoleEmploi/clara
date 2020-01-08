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

  it("Comme superadmin, on peut faire une simulation qui renvoie un résultat éligible", function() {
    cy.get('.c-simulator-result .eligibility-ok').should("not.exist")
    cy.get('input#v_duree_d_inscription').clear()
    cy.get('input#v_duree_d_inscription').type("plus_d_un_an")
    cy.get('input#btn_simulate').click()
    cy.get('.c-simulator-result .eligibility-ok').should("exist")
  })

  it("Comme superadmin, on peut enregistrer le résultat d'une simulation éligible", function() {
    cy.get('td.simulation-table-name').should("not.exist")
    cy.get('input#name_for_saving').clear()
    cy.get('input#name_for_saving').type("ok_plus_dun_an")
    cy.get('button#btn-save').click()
    cy.get('td.simulation-table-name').should("exist")
  })
  it("Comme superadmin, on peut supprimer le résultat d'une simulation éligible", function() {
    cy.get('td.simulation-table-name').should("exist")
    cy.get('.simulation-table-delete').first().click()
    cy.get('td.simulation-table-name').should("not.exist")
  })

})


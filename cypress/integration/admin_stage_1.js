describe("Étape 1", function() {

  before(function() {
    cy.connect_as_simple_admin()
  })

  // after(function() {
  //   cy.disconnect_from_admin()
  // })

  describe("Quand on arrive sur l'étape 1 par défaut", function() {
    before(function() {
      cy.visit('/admin/aid_creation/new_aid_stage_1')
    })
    it("Il y a 4 champs", function() {
      cy.get('.field-unit').should('have.length', 4)
    })
    it("Tous les champs sont vides", function() {
      cy.get('input#aid_name').should('have.value', '')
      cy.get('select#aid_contract_type_id').should('have.value', '')
      cy.get('input#aid_ordre_affichage').should('have.value', '')
      cy.get('textarea#aid_source').should('have.value', '')
    })
    it("si on valide directement, on a 3 champs en erreur", function() {
    })
  })
  


})


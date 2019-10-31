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
      cy.get('.field-unit input#aid_name')             .should('have.value', '')
      cy.get('.field-unit select#aid_contract_type_id').should('have.value', '')
      cy.get('.field-unit input#aid_ordre_affichage')  .should('have.value', '')
      cy.get('.field-unit textarea#aid_source')        .should('have.value', '')
    })
    it("si on valide directement, on a 3 champs en erreur", function() {
      cy.get('button.c-newaid-actionrecord').click()
      cy.get('.field-unit--errored-true input#aid_name')             .should('have.length', 1)
      cy.get('.field-unit--errored-true select#aid_contract_type_id').should('have.length', 1)
      cy.get('.field-unit--errored-true input#aid_ordre_affichage')  .should('have.length', 1)
      cy.get('.field-unit--errored-false textarea#aid_source')        .should('have.length', 1)
    })
    it("si on renseigne le contract_type, on a 2 champs en erreur", function() {
      // Given
      cy.get('select#aid_contract_type_id').select('1')
      // When
      cy.get('button.c-newaid-actionrecord').click()
      // Then
      cy.get('.field-unit--errored-true input#aid_name')             .should('have.length', 1)
      cy.get('.field-unit--errored-false select#aid_contract_type_id').should('have.length', 1)
      cy.get('.field-unit--errored-true input#aid_ordre_affichage')  .should('have.length', 1)
      cy.get('.field-unit--errored-false textarea#aid_source')        .should('have.length', 1)
    })
    it("si on renseigne l'ordre d'affichage en plus, on a 1 champs en erreur", function() {
      // Given
      cy.get('#aid_ordre_affichage').type('42')
      // When
      cy.get('button.c-newaid-actionrecord').click()
      // Then
      cy.get('.field-unit--errored-true input#aid_name')             .should('have.length', 1)
      cy.get('.field-unit--errored-false select#aid_contract_type_id').should('have.length', 1)
      cy.get('.field-unit--errored-false input#aid_ordre_affichage')  .should('have.length', 1)
      cy.get('.field-unit--errored-false textarea#aid_source')        .should('have.length', 1)
    })
  })
  


})


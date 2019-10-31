describe("Étape 1", function() {

  before(function() {
    cy.connect_as_simple_admin()
  })

// after(function() {
//   cy.disconnect_from_admin()
// })

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
  it("si on renseigne un nom existant, il reste en erreur", function() {
    // Given
    cy.get('#aid_name').type('erasmus +')
    // When
    cy.get('button.c-newaid-actionrecord').click()
    // Then
    cy.get('.field-unit--errored-true input#aid_name')             .should('have.length', 1)
    cy.get('.field-unit--errored-false select#aid_contract_type_id').should('have.length', 1)
    cy.get('.field-unit--errored-false input#aid_ordre_affichage')  .should('have.length', 1)
    cy.get('.field-unit--errored-false textarea#aid_source')        .should('have.length', 1)
    
    cy.get('.field-unit-error-msg--string').eq(0).contains("n'est pas disponible")
  })
  it("le nom se mets à jour en temps réel dans l'aperçu", function() {
    cy.get('.js-title').eq(0).contains('erasmus +')

    cy.get('#aid_name').clear()
    cy.get('.js-title').should('have.text', '')

    cy.get('#aid_name').type('erasmus42')
    cy.get('.js-title').should('have.text', 'erasmus42')
  })
  it("le contract_type se mets à jour en temps réel dans l'aperçu", function() {
    cy.get('.js-contract').contains('Aide à la mobilité')

    cy.get('#aid_contract_type_id').select("")
    cy.get('.js-contract').should('have.text', '')

    cy.get('#aid_contract_type_id').select("1")
    cy.get('.js-contract').contains('Aide à la mobilité')
  })
  it("on peut passer à l'étape 2 si tous les champs sont renseignés sauf source", function() {
    cy.get('.field-unit input#aid_name').type('test' + (new Date()).getTime())
    cy.get('.field-unit select#aid_contract_type_id').select("1")
    cy.get('.field-unit input#aid_ordre_affichage').type(42)
    cy.get('.field-unit textarea#aid_source').clear()

    cy.get('button.c-newaid-actionrecord').click()

    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_2')})

  })

  it("on peut passer à l'étape 2 si tous les champs sont renseignés", function() {

    cy.visit('/admin/aid_creation/new_aid_stage_1')

    cy.get('.field-unit input#aid_name').type('test' + (new Date()).getTime())
    cy.get('.field-unit select#aid_contract_type_id').select("1")
    cy.get('.field-unit input#aid_ordre_affichage').type(42)
    cy.get('.field-unit textarea#aid_source').type("du texte")

    cy.get('button.c-newaid-actionrecord').click()

    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_2')})
  })
  it("on peut cliquer pour revenir à l'étape 1, tous les champs sont pré-renseignés", function() {

    cy.get('.c-newaid-back2').eq(0).click()
    
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_1')})


    cy.get('input#aid_name').invoke('val').should('contain', 'test')
    cy.get('select#aid_contract_type_id').invoke('text').should('contain', 'Aide')
    cy.get('input#aid_ordre_affichage').invoke('val').should('contain', '42')
    cy.get('textarea#aid_source').invoke('val').should('contain', 'du texte')

  })


})


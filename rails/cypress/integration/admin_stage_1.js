describe("Étape 1", function() {

  before(function() {
    cy.connect_as_contributeur1()
    cy.visit('/admin/aid_creation/new_aid_stage_1')
  })

  after(function() {
    cy.delete_an_aid("toutavecsource")
  })

  it("Il y a 3 champs", function() {
    // then
    cy.get('.field-unit').should('have.length', 3)
  })
  it("Tous les champs sont vides", function() {
    // then
    cy.get('.field-unit input#aid_name')             .should('have.value', '')
    cy.get('.field-unit select#aid_contract_type_id').should('have.value', null)
    cy.get('.field-unit textarea#aid_source')        .should('have.value', '')
  })
  it("Si on valide directement, on a 2 champs en erreur", function() {
    cy.get('button.c-newaid-actionrecord').click()
    // then
    cy.get('.field-unit--errored-true input#aid_name')             .should('have.length', 1)
    cy.get('.field-unit--errored-true select#aid_contract_type_id').should('have.length', 1)
    cy.get('.field-unit--errored-false textarea#aid_source')        .should('have.length', 1)
  })
  it("Le nom se mets à jour en temps réel dans l'aperçu", function() {
    cy.get('#aid_name').type('erasmus42')
    // then
    cy.get('.js-title').should('have.text', 'erasmus42')
  })
  it("La rubrique se mets à jour en temps réel dans l'aperçu", function() {
    cy.get('#aid_contract_type_id').select("1")
    // then
    cy.get('.js-contract').contains('Aide à la mobilité')
  })
  it("On peut passer à l'étape 2 si tous les champs sont renseignés", function() {

    // given
    cy.visit('/admin/aid_creation/new_aid_stage_1')

    // when
    cy.get('.field-unit input#aid_name').type('toutavecsource')
    cy.get('.field-unit select#aid_contract_type_id').select("1")
    cy.get('.field-unit textarea#aid_source').type("du texte")
    cy.get('button.c-newaid-actionrecord').click()

    // then
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_2')})
  })
  it("On peut cliquer pour revenir à l'étape 1, tous les champs sont pré-renseignés", function() {
    // when
    cy.get('.c-newaid-back2').eq(0).click()
    
    // then
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_1')})
    cy.get('input#aid_name').invoke('val').should('contain', 'toutavecsource')
    cy.get('select#aid_contract_type_id').invoke('text').should('contain', 'Aide à la mobilité')
    cy.get('textarea#aid_source').invoke('val').should('contain', 'du texte')
  })


  it("Si on mets un nom existant, c'est refusé", function() {
    // Given
    cy.get('#aid_name').clear()
    cy.get('#aid_name').type('Erasmus +')
    // When
    cy.get('button.c-newaid-actionrecord').click()
    // Then
    cy.get('.field-unit--errored-true input#aid_name')             .should('have.length', 1)
    cy.get('.field-unit--errored-false select#aid_contract_type_id').should('have.length', 1)
    cy.get('.field-unit--errored-false textarea#aid_source')        .should('have.length', 1)
    
    cy.get('.field-unit-error-msg--string').eq(0).contains("n'est pas disponible")
  })


})


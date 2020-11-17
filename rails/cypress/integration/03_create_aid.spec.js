context("Création et publication d'une aide", () => {

  before(() => {
    cy.connect_as_superadmin()
  })
  beforeEach(() => {
    Cypress.Cookies.preserveOnce('clara', 'remember_token')
  })
  after(() => {
    cy.clearCookie('clara')
    cy.clearCookie('remember_token')
  })

  describe("Création d'une aide", () => {

    it("Il clique sur 'Créer une aide'", () => {
      cy.get('a.js-create-new-aid-button').click()
      cy.location().should((location) => {
        expect(location.pathname).to.eq('/admin/aid_creation/new_aid_stage_1')
      })
    })

    describe("Il rempli l'étape 1", () => {

      it("Il y a 4 champs", function() {
        // then
        cy.get('.field-unit').should('have.length', 4)
      })
      it("Tous les champs sont vides", function() {
        // then
        cy.get('.field-unit input#aid_name')             .should('have.value', '')
        cy.get('.field-unit select#aid_contract_type_id').should('have.value', null)
        cy.get('.field-unit textarea#aid_source')        .should('have.value', '')
        cy.get('.field-unit--errored-true input#aid_ordre_affichage')  .should('have.value', '')
      })
      it("Si on valide directement, on tous les champs en erreur", function() {
        cy.get('button.c-newaid-actionrecord').click()
        // then
        cy.get('.field-unit--errored-true input#aid_name')             .should('have.length', 1)
        cy.get('.field-unit--errored-true select#aid_contract_type_id').should('have.length', 1)
        cy.get('.field-unit--errored-true input#aid_ordre_affichage')  .should('have.length', 1)
        cy.get('.field-unit--errored-false textarea#aid_source')       .should('have.length', 1)
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
        // when
        cy.get('.field-unit input#aid_ordre_affichage').type("42")
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
        cy.get('input#aid_name').invoke('val').should('contain', 'erasmus42')
        cy.get('select#aid_contract_type_id').invoke('text').should('contain', 'Aide à la mobilité')
        cy.get('textarea#aid_source').invoke('val').should('contain', 'du texte')
      })


    })

  })

})

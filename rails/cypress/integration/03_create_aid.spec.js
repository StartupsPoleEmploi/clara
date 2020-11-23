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

    describe("Il rempli l'étape 1", () => {

      before(() => {
        cy.visit('/admin/aid_creation/new_aid_stage_1')
      })
      it("Il y a 4 champs", function() {
        // then
        cy.get('.field-unit').should('have.length', 4)
      })
      it("Tous les champs sont vides", function() {
        // then
        cy.get('.field-unit input#aid_name')             .should('have.value', '')
        cy.get('.field-unit select#aid_contract_type_id').should('have.value', null)
        cy.get('.field-unit textarea#aid_source')        .should('have.value', '')
        cy.get('.field-unit input#aid_ordre_affichage')  .should('have.value', '')
      })
      it("Si on valide directement, on tous les champs obligatoires en erreur", function() {
        // given
        cy.get('.field-unit--errored-true input#aid_name')             .should('have.length', 0)
        cy.get('.field-unit--errored-true select#aid_contract_type_id').should('have.length', 0)
        cy.get('.field-unit--errored-true input#aid_ordre_affichage')  .should('have.length', 0)
        cy.get('.field-unit--errored-false textarea#aid_source')       .should('have.length', 1)
        // when
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
      it("On peut passer à l'étape 2 si tous les champs obligatoires sont renseignés", function() {
        // when
        cy.get('.field-unit input#aid_ordre_affichage').type("42")
        cy.get('select#aid_contract_type_id').selectNth(1)
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
        cy.get('.field-unit input#aid_name')             .should('not.have.value', '')
        cy.get('.field-unit select#aid_contract_type_id').should('not.have.value', null)
        cy.get('.field-unit textarea#aid_source')        .should('not.have.value', '')
        cy.get('.field-unit input#aid_ordre_affichage')  .should('not.have.value', '')
      })
    })

    describe("Il rempli l'étape 2", () => {
      before(() => {
        cy.visit('/admin/aid_creation/new_aid_stage_2?locale=fr&slug=erasmus42')
      })

      it("si on vient de créer une aide, on arrive sur un écran avec 5 champs éditables, tous vides, le premier est déplié", function() {
        // Should have 5 empty editors
        cy.get('.field-unit--ckeditor').should('have.length', 5)
        cy.get('.field-unit--ckeditor .cke_contents').eq(0).should('have.text', "Press ALT 0 for help")
        cy.get('.field-unit--ckeditor .cke_contents').eq(1).should('have.text', "Press ALT 0 for help")
        cy.get('.field-unit--ckeditor .cke_contents').eq(2).should('have.text', "Press ALT 0 for help")
        cy.get('.field-unit--ckeditor .cke_contents').eq(3).should('have.text', "Press ALT 0 for help")
        cy.get('.field-unit--ckeditor .cke_contents').eq(4).should('have.text', "Press ALT 0 for help")

        // First must be expanded
        cy.get('#accordion_0-0_tab').should('have.attr', 'aria-expanded', 'true')
      })

      it("on peut renseigner des conditions à remplir, avec mise à jour en temps réel", function() {

        cy.get('#accordion_0-1_tab').click()
        cy.window().then(win => {win.CKEDITOR.instances["aid_additionnal_conditions"].setData("<p>Mes conditions à remplir</p>");});
        cy.get('.js-additionnal-conditions').contains('Mes conditions à remplir')
      })
    })


  })

})

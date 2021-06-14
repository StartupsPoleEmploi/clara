context("Administrateur : Création et publication d'une aide", () => {

  before(() => {
    cy.request('/cypress_rails_reset_state')
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

      it("on peut renseigner une description, avec mise à jour en temps réel", function() {
        cy.get('#accordion_0-0_tab').click()
        cy.window().then(win => {win.CKEDITOR.instances["aid_what"].setData("<p>Une description</p>");});
        cy.get('.js-what').contains('Une description')
      })
      it("on peut renseigner un contenu, avec mise à jour en temps réel", function() {
        cy.get('#accordion_0-2_tab').click()
        cy.window().then(win => {win.CKEDITOR.instances["aid_how_much"].setData("<p>Un contenu</p>");});
        cy.get('.js-how-much').contains('Un contenu')
      })
      it("on peut renseigner le comment, avec mise à jour en temps réel", function() {
        cy.get('#accordion_0-3_tab').click()
        cy.window().then(win => {win.CKEDITOR.instances["aid_how_and_when"].setData("<p>Le comment</p>");});
        cy.get('.js-how-and-when').contains('Le comment')
      })
      it("on peut valider l'étape 2", function() {
        cy.get('button.c-newaid-actionrecord').click()
        cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_3')})
      })
    })

    describe("Il rempli l'étape 3", () => {
      before(() => {
        cy.visit('/admin/aid_creation/new_aid_stage_3?locale=fr&slug=erasmus42')
      })

      it("On peut renseigner du texte : il se met à jour dans l'aperçu", function() {
        // given
        cy.get(".c-resultaid__smalltxt").should('have.text', "")
        // when
        cy.get('#aid_short_description').type("Un résumé possible de l'aide")
        // then
        cy.get(".c-resultaid__smalltxt").should('have.text', "Un résumé possible de l'aide")
      })

      it("On peut renseigner des filtres", function() {
        // given
        cy.get("#aid_filter_ids").invoke("val").should('equal', null)

        // when
        cy.get("#aid_filter_ids-selectized").click()
        cy.get("#aid_filter_ids-selectized").type("{enter}")
        cy.get("#aid_filter_ids-selectized").type("{esc}")

        // then
        cy.get("#aid_filter_ids").invoke("val").should('not.equal', null)
      })
    })
    describe("Il rempli l'étape 4", () => {
      before(() => {
        cy.visit('/admin/aid_creation/new_aid_stage_4?locale=fr&slug=erasmus42')
      })
      it("On peut enregistrer une règle composite", function() {

        cy.get('select#rule_variable_id').select('v_zrr')
        cy.get('select#rule_value_eligible_selectible').select('oui')
        cy.get('.c-apprule-button.is-validation').click()

        cy.get('.js-or:last').click()
        cy.get('select#rule_variable_id').select('v_age')
        cy.get('select#rule_operator_kind').select('more_than')
        cy.get('input#rule_value_eligible').type('18')
        cy.get('.c-apprule-button.is-validation').click()

        // toute la france
        cy.get('input#tout').click() 


        // when
        cy.get('#record_root_rule').click()
        cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_5')})

      })
    })
    describe("Il rempli l'étape 5", () => {
      before(() => {
        cy.visit('/admin/aid_creation/new_aid_stage_5?locale=fr&slug=erasmus42')
      })
      it("Toutes les étapes sont considérées comme correctement remplies", function() {
        cy.get('.stage1-is-ok-true').should('exist')
        cy.get('.stage2-is-ok-true').should('exist')
        cy.get('.stage3-is-ok-true').should('exist')
        cy.get('.stage4-is-ok-true').should('exist')
      })
      it("Le créateur demande la relecture", function() {
        cy.get('.js-askforreread').click() 
        cy.get('.flash-notice').contains("L'aide a été demandée pour relecture.")
        cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin')})
      })
    })

    describe("Il modifie l'étape 4", () => {
      before(() => {
        cy.visit('/admin/aid_creation/new_aid_stage_4?modify=true&slug=erasmus42')
      })
      it("On peut modifier une règle composite", function() {
        //given
        cy.get('.js-and:last').click()
        cy.get('select#rule_variable_id').select('v_category')
        cy.get('select#rule_operator_kind').select('equal')
        cy.get('select#rule_value_eligible_selectible').select('cat_12345')
        cy.get('.c-apprule-button.is-validation').click()

        cy.get('input#tout_sauf_domtom').click() 

        // when
        cy.get('#record_root_rule').click()

        //then
        cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_5')})
      })
    })


  })

  describe("Publication d'une aide", () => {
    before(() => {
      cy.connect_as_contributeur()
    })
    describe("Un contributeur va à l'étape 5 d'une aide nouvellement créé par quelqu'un d'autre que lui", () => {
      before(() => {
        cy.visit('/admin/aid_creation/new_aid_stage_5?locale=fr&slug=erasmus42')
      })
      it("Le contributeur peut publier l'aide", function() {
        cy.get('.js-publishonsite').click() 
        cy.get('.flash-notice').contains("L'aide va être publiée sur le site web")
        cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin')})
      })

    })
  })

})

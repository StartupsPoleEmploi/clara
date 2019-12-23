describe("Étape 5", function() {

  after(function() {
    cy.delete_an_aid("test-stage-5")
  })
  
  describe("Si un contributeur rempli le minimum d'information", function() {
    const MAIN_TITLE_SELECTOR = ".c-newaid-title"

    before(function() {
      cy.connect_as_contributeur1()
    })

    before(function() {
      cy.visit('/admin/aid_creation/new_aid_stage_1')

      cy.get('.field-unit input#aid_name').type('test-stage-5')
      cy.get('.field-unit select#aid_contract_type_id').select("1")
      
      cy.get('button.c-newaid-actionrecord').click()
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_2')})

      cy.get('button.c-newaid-actionrecord').click()
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_3')})

      cy.get('button.c-newaid-actionrecord').click()
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_4')})
    })

    it("Si on vient de l'étape 4, on arrive sur l'étape 5 en création", function() {
      // when
      cy.get('#record_root_rule').click()
      // then
      cy.get(MAIN_TITLE_SELECTOR).should('have.text', 'Créer une aide')
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_5')})
    })

    it("On peut accéder à l'écran directement en modification", function() {
      // when
      cy.visit('/admin/aid_creation/new_aid_stage_5?modify=true&slug=test-stage-5').then((contentWindow) => {
        // then
        cy.get(MAIN_TITLE_SELECTOR).should('have.text', 'Modifier une aide')
      })
    })
    it("Les étapes incomplètes sont signalées", function() {
      cy.get(".c-newaid-stage5expl.is-ok-false").should('have.length', 2)
    })
    it("Auquel cas l'aide est signalée comme étant à l'état de brouillon", function() {
      cy.get(".c-newaid-subtitle").shouldHaveTrimmedText("L'aide a été enregistrée en tant que brouillon.")
    })
    it("Auquel cas on signale à l'utilisateur qu'il ne peut pas demander la relecture tout de suite", function() {
      cy.get(".c-newaid-subtitle-expl").shouldHaveTrimmedText("Vous pourrez demander une relecture pour publication une fois que toutes les informations obligatoires auront été renseignées.")
    })
    it("Auquel cas le bouton de demande de relecture est présent mais inactif", function() {
      cy.get(".js-askforreread").should("have.attr", "disabled")
    })
    it("Auquel cas le bouton de conservation du brouillon est présent et actif", function() {
      cy.get(".js-keepdraft").should("not.have.attr", "disabled")
    })
    it("Auquel cas le bouton de conservation du brouillon est présent et actif", function() {
      cy.get(".c-newaid-removedraft").should("not.have.attr", "disabled")
    })
    it("Si le contributeur choisi de conserver le brouillon, il apparaît comme simple brouillon dans la liste des aides", function() {
      cy.get(".js-keepdraft").click()
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin')})
      cy.get('span[data-name="test-stage-5"][data-col="aid.status"]').shouldHaveTrimmedText("Brouillon")
    })
    describe("Prévisualisation", function() {
      it("Pour un admin, il est possible de prévisualiser une aide, même si c'est un brouillon", function() {
        cy.visit('/aides/detail/test-stage-5')
        cy.get('body.c-body.detail.show').should("exist")
        cy.title().should('not.include', 'Exception caught')
        cy.disconnect_from_admin()
      })
      it("Pour un simple visiteur, il n'est pas possible de prévisualiser une aide qui est à l'état de brouillon", function() {
        cy.visit('/aides/detail/test-stage-5', {failOnStatusCode: false})
        cy.title().should('include', 'Exception caught')
        cy.get('body.c-body.detail.show').should("not.exist")
      })
      it("Pour un simple visiteur, il est possible de prévisualiser une aide publiée", function() {
        cy.visit('/aides/detail/erasmus')
        cy.get('body.c-body.detail.show').should("exist")
        cy.title().should('not.include', 'Exception caught')
      })
    })
  })

  describe("Si il complète les étapes manquantes", function() {
    before(function() {
      cy.connect_as_contributeur1()
    })
    before(function() {
      
      cy.visit('/admin/aid_creation/new_aid_stage_2?modify=true&slug=test-stage-5')
      cy.get('.field-unit--ckeditor').should('exist')

            
      cy.get('#accordion_0-1_tab').click()
      cy.window().then(win => {win.CKEDITOR.instances["aid_additionnal_conditions"].setData("<p>Mes conditions à remplir</p>");});

      cy.get('#accordion_0-2_tab').click()
      cy.window().then(win => {win.CKEDITOR.instances["aid_how_much"].setData("<p>Contenu de l'aide (combien)?</p>");});

      cy.get('#accordion_0-3_tab').click()
      cy.window().then(win => {win.CKEDITOR.instances["aid_how_and_when"].setData("<p>Comment je fais la demande</p>");});

      cy.get('#accordion_0-0_tab').click()
      cy.window().then(win => {win.CKEDITOR.instances["aid_what"].setData("<p>Ma description</p>");});

      cy.get('button.c-newaid-actionrecord').click()

      cy.visit('/admin/aid_creation/new_aid_stage_4?modify=true&slug=test-stage-5')

      cy.get('select#rule_variable_id').should('exist')
      cy.get('select#rule_variable_id').select('v_category')
      cy.get('select#rule_value_eligible_selectible').select('cat_12345')
      cy.get('.c-apprule-button.is-validation').click()
      
      cy.get('#record_root_rule').click()      

      cy.visit('/admin/aid_creation/new_aid_stage_5?modify=true&slug=test-stage-5')
      cy.get('.c-newaid-stage5expl').should('exist')
    })
    it("Il n'y a plus d'étape incomplète", function() {
      cy.get(".c-newaid-stage5expl.is-ok-false").should('have.length', 0)
    })
    it("Auquel cas l'aide est signalée comme totalement remplie", function() {
      cy.get(".c-newaid-subtitle").shouldHaveTrimmedText("L'aide a toutes les informations requises.")
    })
    it("Auquel cas on signale à l'utilisateur qu'il peut demander la relecture", function() {
      cy.get(".c-newaid-subtitle-expl").shouldHaveTrimmedText("Elle sera publiée sur le site après relecture par un tiers.")
    })
    it("Auquel cas il y a 3 actions possibles", function() {
      cy.get(".c-newaid-finalactions .c-newbutton").should('have.length', 3)
    })
    it("Auquel cas le bouton de demande de relecture est présent et actif", function() {
      cy.get(".c-newaid-finalactions .c-newbutton.js-askforreread").should("not.have.attr", "disabled")
    })
    it("Auquel cas le bouton de conservation du brouillon est présent et actif", function() {
      cy.get(".c-newaid-finalactions .c-newbutton.js-keepdraft").should("not.have.attr", "disabled")
    })
    it("Auquel cas le bouton de conservation du brouillon est présent et actif", function() {
      cy.get(".c-newaid-finalactions .c-newbutton.c-newaid-removedraft").should("not.have.attr", "disabled")
    })
    it("Si le contributeur choisi de conserver le brouillon, il apparaît comme brouillon complété dans la liste des aides", function() {
      cy.get(".js-keepdraft").click()
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin')})
      cy.get('span[data-name="test-stage-5"][data-col="aid.status"]').shouldHaveTrimmedText("Brouillon, complet")
    })
    it("Si le contributeur choisi de demander la relecture, il apparaît comme en attente de relecture dans la liste des aides", function() {
      //given
      cy.visit('/admin/aid_creation/new_aid_stage_5?modify=true&slug=test-stage-5')
      cy.get(".js-askforreread").should("exist")
      //when
      cy.get(".js-askforreread").click()
      //then
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin')})
      cy.get('span[data-name="test-stage-5"][data-col="aid.status"]').shouldHaveTrimmedText("En attente de relecture")
    })
    it("Si le contributeur choisi de revenir en modification sur l'aide, il n'y a plus d'actions possibles à l'étape 5", function() {
      //given
      //when
      cy.visit('/admin/aid_creation/new_aid_stage_5?modify=true&slug=test-stage-5')
      cy.get(".c-newaid-subtitle").should("exist")
      //then
      cy.get(".c-newaid-finalactions .c-newbutton").should('have.length', 0)
    })
  })

  describe("Si un relecteur arrive sur l'écran de modification de l'aide", function() {
    before(function() {
      // given
      cy.connect_as_relecteur1()
      // when
      cy.visit("/admin/aid_creation/new_aid_stage_5?modify=true&slug=test-stage-5")
    })
    it("Auquel cas il n'y a qu'une action possible", function() {
      // then
      cy.get(".c-newaid-finalactions .c-newbutton").should('have.length', 1)
    })
    it("Cette action est la publication sur le site web, en front", function() {
      // then
      cy.get(".c-newaid-finalactions .c-newbutton.js-publishonsite").should("exist")
    })
    it("Si le relecteur choisi de publier l'aide, elle apparaît comme publiée dans la liste des aides", function() {
      // when
      cy.get(".c-newaid-finalactions .c-newbutton.js-publishonsite").click()
      // then
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin')})
      cy.get('span[data-name="test-stage-5"][data-col="aid.status"]').shouldHaveTrimmedText("Publiée")
    })
    it("Elle est publiée sur le front grand public après vidage manuel du cache", function() {
      //given
      cy.clear_the_cache()
      //when
      cy.visit("/aides/detail/test-stage-5")
      //then
      cy.get("body.c-body.detail").should("exist")
    })
  })


})


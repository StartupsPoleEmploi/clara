describe("Étape 4", function() {

  const MAIN_TITLE_SELECTOR = ".c-newaid-title"

  before(function() {
    cy.connect_as_contributeur1()
  })

  after(function() {
    cy.delete_an_aid("test-stage-5")
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
    cy.get(".c-newaid-askforreread").should("have.attr", "disabled")
  })
  it("Auquel cas le bouton de conservation du brouillon est présent et actif", function() {
    cy.get(".c-newaid-keepdraft").should("not.have.attr", "disabled")
  })
  it("Auquel cas le bouton de conservation du brouillon est présent et actif", function() {
    cy.get(".c-newaid-removedraft").should("not.have.attr", "disabled")
  })
  describe("Si il complète les étapes manquantes", function() {
    before(function() {
      
      cy.visit('/admin/aid_creation/new_aid_stage_2?modify=true&slug=test-stage-5')
      cy.get('.field-unit--ckeditor').should('exist')

      cy.window().then(win => {win.CKEDITOR.instances["aid_what"].setData("<p>Ma description</p>");});
            
      cy.get('#accordion_0-1_tab').click()
      cy.window().then(win => {win.CKEDITOR.instances["aid_additionnal_conditions"].setData("<p>Mes conditions à remplir</p>");});

      cy.get('#accordion_0-2_tab').click()
      cy.window().then(win => {win.CKEDITOR.instances["aid_how_much"].setData("<p>Combien?</p>");});

      cy.get('#accordion_0-3_tab').click()
      cy.window().then(win => {win.CKEDITOR.instances["aid_how_and_when"].setData("<p>Comment je fais la demande</p>");});

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
    it("Auquel cas le bouton de demande de relecture est présent et actif", function() {
      cy.get(".c-newaid-askforreread").should("not.have.attr", "disabled")
    })
    it("Auquel cas le bouton de conservation du brouillon est présent et actif", function() {
      cy.get(".c-newaid-keepdraft").should("not.have.attr", "disabled")
    })
    it("Auquel cas le bouton de conservation du brouillon est présent et actif", function() {
      cy.get(".c-newaid-removedraft").should("not.have.attr", "disabled")
    })
  })

})


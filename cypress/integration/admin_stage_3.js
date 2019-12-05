describe("Étape 3", function() {

  const MAIN_TITLE_SELECTOR = ".c-newaid-title"

  before(function() {
    cy.connect_as_contributeur1()
  })

  after(function() {
    cy.delete_an_aid("test-stage-3")
  })

  before(function() {
    cy.visit('/admin/aid_creation/new_aid_stage_1')

    cy.get('.field-unit input#aid_name').type('test-stage-3')
    cy.get('.field-unit select#aid_contract_type_id').select("1")
    
    cy.get('button.c-newaid-actionrecord').click()
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_2')})

    cy.get('button.c-newaid-actionrecord').click()
  })

  it("Si on vient de l'étape 2, on arrive sur l'étape 3 en création", function() {
    // then
    cy.get(MAIN_TITLE_SELECTOR).should('have.text', 'Créer  une aide')
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_3')})
  })

  it("L'étape 3 est optionnelle : si on valide directement, on arrive sur l'étape 4", function() {
    // when
    cy.get('button.c-newaid-actionrecord').click()
    // then
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_4')})
  })

  it("On peut accéder à l'écran directement en modification", function() {
    // when
    cy.visit('/admin/aid_creation/new_aid_stage_3?modify=true&slug=test-stage-3').then((contentWindow) => {
      // then
      cy.get(MAIN_TITLE_SELECTOR).should('have.text', 'Modifier  une aide')
    })
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

    // then
    cy.get("#aid_filter_ids").invoke("val").should('not.equal', null)
  })

  it("Si on quitte l'écran sans valider, rien n'est sauvegardé", function() {

    // given
    cy.get('#js-stage-2-link').click()
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_2')})

    // when
    cy.get('button.c-newaid-actionrecord').click()

    // then
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_3')})
    cy.get("#aid_filter_ids").invoke("val").should('equal', null)
    cy.get(".c-resultaid__smalltxt").should('have.text', "")
  })

  it("Si on valide et on revient, tout est sauvegardé", function() {
    // given
    cy.get('#aid_short_description').type("Un résumé possible de l'aide")
    cy.get("#aid_filter_ids-selectized").click()
    cy.get("#aid_filter_ids-selectized").type("{enter}")
    cy.get("#aid_filter_ids-selectized").type("{esc}")
    
    // when
    cy.get('button.c-newaid-actionrecord').click()
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_4')})
    cy.get('#js-stage-3-link').click()
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_3')})

    // then
    cy.get("#aid_filter_ids").invoke("val").should('not.equal', null)
    cy.get(".c-resultaid__smalltxt").should('have.text', "Un résumé possible de l'aide")
  })



})


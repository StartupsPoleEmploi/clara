describe("Étape 2", function() {

  before(function() {
    cy.connect_as_contributeur1()
  })

  after(function() {
    cy.delete_an_aid("test-stage-2")
  })

  before(function() {
    cy.visit('/admin/aid_creation/new_aid_stage_1')
  })

  it("si on vient de créer une aide, on arrive sur un écran avec 5 champs éditables, tous vides, le premier est déplié", function() {
    // GIVEN
    cy.get('.field-unit input#aid_name').type('test stage 2')
    cy.get('.field-unit select#aid_contract_type_id').select("1")
    
    // WHEN
    cy.get('button.c-newaid-actionrecord').click()
    
    // THEN
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_2')})

    cy.wait(2000)

    // close notice
    cy.get('.tooltip__closetext__container').click()

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

  it("on peut renseigner une description, elle se mets à jour en temps réel", function() {

    cy.get('#accordion_0-0_tab').click()
    cy.window().then(win => {win.CKEDITOR.instances["aid_what"].setData("<p>Ma description</p>");});
    cy.get('.js-what').contains('Ma description')
  })
  
  it("on peut renseigner des conditions à remplir, avec mise à jour en temps réel", function() {

    cy.get('#accordion_0-1_tab').click()
    cy.window().then(win => {win.CKEDITOR.instances["aid_additionnal_conditions"].setData("<p>Mes conditions à remplir</p>");});
    cy.get('.js-additionnal-conditions').contains('Mes conditions à remplir')
  })


})


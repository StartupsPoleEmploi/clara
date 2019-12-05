describe("Étape 3", function() {

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

  it("Si on vient de l'étape 2, on arrive sur l'étape 3", function() {
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_3')})
  })

  it("L'étape 3 est optionnelle : si on valide directement, on arrive sur l'étape 4", function() {
    cy.get('button.c-newaid-actionrecord').click()
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_4')})
  })

  it("On peut renseigner du texte : il se met à jour dans l'aperçu", function() {
  })

  it("On peut renseigner des filtres", function() {
  })

  it("Si on quitte l'écran sans valider, rien n'est sauvegardé", function() {
  })

  it("Si on valide et on revient, tout est sauvegardé", function() {
  })

})


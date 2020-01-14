describe("Pour une aide déjà publiée", function() {

  let slug = "vsi-volontariat-de-solidarite-internationale"

  before(function() {
    cy.connect_as_contributeur1()
  })


  it("L'étape 1 a bouton de validation 'Publier les modifications' ", function() {
    cy.visit('/admin/aid_creation/new_aid_stage_1?locale=fr&modify=true&slug=' + slug)
    cy.get("button.c-newaid-actionrecord").shouldHaveTrimmedText("Publier les modification")
  })
  it("L'étape 1 a bouton de validation qui est désactivé", function() {
    cy.get("button.c-newaid-actionrecord").should("have.attr", "disabled")
  })
  it("Si on entre du texte dans un des champs de l'étape 1, le bouton devient activé", function() {
    cy.get('.field-unit textarea#aid_source').type("d").type("{backspace}")
    cy.get("button.c-newaid-actionrecord").should("not.have.attr", "disabled")
  })
  it("Si on valide l'étape 1, le texte de la notification est adapté", function() {
    cy.get("button.c-newaid-actionrecord").click()
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_2')})
    cy.get(".flash").first().shouldHaveTrimmedText("Les modifications vont être publiées sur le site web !  Cela peut prendre quelques secondes.")
  })
  it("L'étape 2 a bouton de validation 'Publier les modifications' ", function() {
    cy.visit('/admin/aid_creation/new_aid_stage_2?locale=fr&modify=true&slug=' + slug)
    cy.get("button.c-newaid-actionrecord").shouldHaveTrimmedText("Publier les modification")
  })
  it("L'étape 2 a bouton de validation qui est désactivé", function() {
    cy.get("button.c-newaid-actionrecord").should("have.attr", "disabled")
  })
  it("L'étape 3 a bouton de validation 'Publier les modifications' ", function() {
    cy.visit('/admin/aid_creation/new_aid_stage_3?locale=fr&modify=true&slug=' + slug)
    cy.get("button.c-newaid-actionrecord").shouldHaveTrimmedText("Publier les modification")
  })
  it("L'étape 3 a bouton de validation qui est désactivé", function() {
    cy.get("button.c-newaid-actionrecord").should("have.attr", "disabled")
  })
  it("Si on entre du texte dans un des champs de l'étape 3, le bouton devient activé", function() {
    cy.get('#aid_short_description').type("t").type("{backspace}")
    cy.get("button.c-newaid-actionrecord").should("not.have.attr", "disabled")
  })
  it("Si on valide l'étape 3, le texte de la notification est adapté", function() {
    cy.get("button.c-newaid-actionrecord").click()
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_4')})
    cy.get(".flash").first().shouldHaveTrimmedText("Les modifications vont être publiées sur le site web !  Cela peut prendre quelques secondes.")
  })
  it("L'étape 4 a bouton de validation 'Publier les modifications' ", function() {
    cy.visit('/admin/aid_creation/new_aid_stage_4?locale=fr&modify=true&slug=' + slug)
    cy.get("button#record_root_rule").shouldHaveTrimmedText("Publier les modification")
  })
  it("L'étape 4 a bouton de validation qui est désactivé", function() {
    cy.get("button#record_root_rule").should("have.attr", "disabled")
  })
  it("L'étape 4 : on change quelque chose, le bouton de validation devient activé", function() {
    cy.get("#domtom_seulement").click()
    cy.get("#tout").click()
    cy.get("button#record_root_rule").should("not.have.attr", "disabled")
  })
  it("Si on valide l'étape 4, le texte de la notification est adapté", function() {
    cy.get("button#record_root_rule").click()
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aid_creation/new_aid_stage_5')})
    cy.get(".flash").first().shouldHaveTrimmedText("Les modifications vont être publiées sur le site web !  Cela peut prendre quelques secondes.")
  })
})


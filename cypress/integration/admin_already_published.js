describe("Pour une aide déjà publiée", function() {

  before(function() {
    cy.connect_as_contributeur1()
  })


  it("L'étape 1 a bouton de validation 'Publier les modifications' ", function() {
    cy.visit('/admin/aid_creation/new_aid_stage_1?locale=fr&modify=true&slug=erasmus')
    cy.get("button.c-newaid-actionrecord").shouldHaveTrimmedText("Publier les modification")
  })
  it("L'étape 1 a bouton de validation qui est désactivé", function() {
    cy.get("button.c-newaid-actionrecord").should("have.attr", "disabled")
  })
  it("Si on entre du texte dans un des champs de l'étape 1, le bouton devient activé", function() {
    cy.get('.field-unit textarea#aid_source').type("du texte")
    cy.get("button.c-newaid-actionrecord").should("not.have.attr", "disabled")
  })
  it("L'étape 2 a bouton de validation 'Publier les modifications' ", function() {
    cy.visit('/admin/aid_creation/new_aid_stage_2?locale=fr&modify=true&slug=erasmus')
    cy.get("button.c-newaid-actionrecord").shouldHaveTrimmedText("Publier les modification")
  })
  it("L'étape 2 a bouton de validation qui est désactivé", function() {
    cy.get("button.c-newaid-actionrecord").should("have.attr", "disabled")
  })
  it("L'étape 3 a bouton de validation 'Publier les modifications' ", function() {
    cy.visit('/admin/aid_creation/new_aid_stage_3?locale=fr&modify=true&slug=erasmus')
    cy.get("button.c-newaid-actionrecord").shouldHaveTrimmedText("Publier les modification")
  })
  it("L'étape 3 a bouton de validation qui est désactivé", function() {
    cy.get("button.c-newaid-actionrecord").should("have.attr", "disabled")
  })
  it("Si on entre du texte dans un des champs de l'étape 3, le bouton devient activé", function() {
    cy.get('#aid_short_description').type("t").type("{backspace}")
    cy.get("button.c-newaid-actionrecord").should("not.have.attr", "disabled")
  })
})


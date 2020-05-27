describe("Pour un visiteur", function () {

  const AMOB_SPECTACLE = '[data-aslug="aide-a-la-mobilite-professionnelle-des-artistes-et-technicien-ne-s-du-spectacle"]'

  it("On peut consulter les CGU depuis la page d'accueil", function () {
    // given
    cy.visit('/')
    // when
    cy.get('.c-footer-cgu').contains("Conditions générales d'utilisation").click()
    // then
    cy.get("body.c-body.welcome.terms").should("exist")
  })
  it("On peut consulter la page d'accessibilité depuis la page d'accueil", function () {
    // given
    cy.visit('/')
    // when
    cy.get('.c-footer-cgu').contains("Accessibilité").click()
    // then
    cy.get("body.c-body.welcome.accessibility").should("exist")
  })
  it("On peut consulter la page de confidentialité depuis la page d'accueil", function () {
    // given
    cy.visit('/')
    // when
    cy.get('.c-footer-cgu').contains("Cookies et politique de confidentialité").click()
    // then
    cy.get("body.c-body.confidentiality.index").should("exist")
  })
  it("On peut consulter la page de contact depuis la page d'accueil", function () {
    // given
    cy.visit('/')
    // when
    cy.get('.c-footer-cgu').contains("Nous contacter").click()
    // then
    cy.get("body.c-body.contact.index").should("exist")
  })
  it("On peut voir toutes les aides depuis la page d'accueil", function () {
    // given
    cy.visit('/')
    // when
    cy.get('.c-body__footer').contains("Toutes nos aides").click()
    // then
    cy.get("body.c-body.aides.index").should("exist")
  })
  // TEST FAILURE
  it("On peut voir une rubrique depuis la page d'accueil", function () {
    // given
    cy.visit('/')
    // when
    cy.get('.c-body__footer').contains("Aide pour se former ou travailler à l'international").click()
    // then
    cy.get("body.c-body.type.show").should("exist")
  })
})

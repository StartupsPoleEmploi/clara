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
})

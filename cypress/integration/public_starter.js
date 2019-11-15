describe("Pour un visiteur", function () {


  it("Quand on arrive sur la page principale, on peut démarrer le formulaire", function () {
    // given
    cy.visit('/')
    // when
    cy.get('.c-main-cta').click()
    // then
    cy.location().should((loc) => { expect(loc.pathname).contains('question') })
  })

})


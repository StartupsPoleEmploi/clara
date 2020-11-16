/// <reference types="cypress" />

context('Sans PEID', () => {


  describe("Pour un visiteur", () => {

    const AMOB_SPECTACLE = '[data-aslug="aide-a-la-mobilite-professionnelle-des-artistes-et-technicien-ne-s-du-spectacle"]'

    it("Quand on arrive sur la page principale, on peut ouvrir la modale de démarrage le formulaire", () => {
      // given
      cy.visit('/')
      cy.get('#login-form').should('not.be.visible')
      // when
      cy.get('#start_wizard_form1').click()
      // then
      cy.get('#login-form').should('be.visible')
    })

    it("On peut commencer sans se connecter", () => {
      // given
      // when
      cy.get('#start-clara').click()
      // then
      cy.location().should((loc) => { expect(loc.pathname).contains('question') })
    })
  
  })


})

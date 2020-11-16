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
  

    it("On peut remplir toutes les questions, on arrive sur l'écran de résultat", () => {

      // given
      cy.get('#moins_d_un_an').should("exist")
      cy.get('#moins_d_un_an').click()
      cy.get('.js-next').click()

      cy.get('#cat_12345').should("exist")
      cy.get('#cat_12345').click()
      cy.get('.js-next').click()

      cy.get('#radio_ARE_ASP').should("exist")
      cy.get('#radio_ARE_ASP').click()
      cy.get('.js-next').click()

      cy.get('#montant').should("exist")
      cy.get('#montant').type("842")
      cy.get('.js-next').click()

      cy.get('#age').should("exist")
      cy.get('#age').type("16")
      cy.get('.js-next').click()

      cy.get('#niveau_4').should("exist")
      cy.get('#niveau_4').click()
      cy.get('.js-next').click()

      cy.get('#search').should("exist")
      cy.get('#search').type("49490")
      cy.get('li.autocomplete-item').should("exist")
      cy.get('li.autocomplete-item').first().click()
      cy.get('.js-next').click()

      cy.get('#val_spectacle').should("exist")
      cy.get('#val_spectacle').click()

      //when
      cy.get('.js-next').click()

      cy.get('label[for="se-deplacer"]').click()
      cy.get('.js-next').click()

      //then 
      cy.get("body.c-body.aides").should("exist")

    })
  
  })


})

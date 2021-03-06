context('Simple visiteur : Parcours du formulaire', () => {


  before(() => {
    cy.request('/cypress_rails_reset_state')
    cy.visit('/inscription_questions/new')
  })

  describe("Pour un visiteur qui commence par la question inscription", () => {

    it("On peut remplir toutes les questions, on arrive sur l'écran de résultat", () => {

      // given
      cy.get('#moins_d_un_an').should("exist")
      cy.get('#moins_d_un_an').click()
      cy.get('.js-next').click()

      cy.get('#cat_12345').should("exist")
      cy.get('#cat_12345').click()
      cy.get('.js-next').click()

      cy.get('input#ARE_ASP').should("exist")
      cy.get('input#ARE_ASP').click()
      cy.get('.js-next').click()

      // cy.get(".c-question-title").then(function($elem) {
      //   cy.log($elem.text())
      // })

      cy.get('#montant').should("exist")
      cy.get('#montant').type("842")
      cy.get('.js-next').click()

      cy.get('#age').should("exist")
      cy.get('#age').type("26")
      cy.get('.js-next').click()

      cy.get('#niveau_4').should("exist")
      cy.get('#niveau_4').click()
      cy.get('.js-next').click()

      cy.window().then((win) => {
        cy.log('----------------------win.clara.env.ARA_URL_GEO_API--------------------------------------')
        cy.log(win.clara.env.ARA_URL_GEO_API)
      })

      cy.get('#search').should("exist")
      cy.get('#search').type("49490")
      cy.get('li.autocomplete-item').should("exist")
      cy.get('li.autocomplete-item').first().click()
      cy.get('.js-next').click()

      cy.get('#val_spectacle').should("exist")
      cy.get('#val_spectacle').click()
      cy.get('.js-next').click()

      cy.location().should((loc) => {expect(loc.pathname).to.eq('/filter_questions/new')})
      cy.get('.js-next').click()

      cy.location().should((loc) => {expect(loc.pathname).to.eq('/aides')})

      cy.get('.c-btn--result').eq(0).click()
      cy.get('.c-btn--aid').eq(0).click()
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/aides/detail/aide-test-mobilite')})
    })

  })


})

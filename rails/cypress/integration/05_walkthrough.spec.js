context('Pages autres que le questionnaire', () => {


  before(() => {
    cy.visit('/')
  })

  describe("Pour un visiteur qui découvre la home", () => {

    it("On peut faire une recherche 'plain-text', au moins un résultat est trouvé", () => {

      // Given
      cy.get('.c-search-front-submit.c-loop.js-modal').click()
      cy.get('#u-search-modal').should("exist")
      cy.get('#u-search-modal').type("descr")
      // When
      cy.get('.c-search-front-submit-modal').click()
      // Then
      cy.location().should((loc) => {
        expect(loc.pathname).to.eq('/get_search_front')
        expect(loc.search).to.eq('?usearch=descr')
      })
      cy.get('.c-result-line-front-item').should("exist")

    })

    it("On peut aller voir toutes les aides, et faire une recherche dessus", () => {

      // Given
      // When
      cy.get('a.c-link-to-all-aides').click()
      cy.location().should((loc) => {
        // Then
        expect(loc.pathname).to.eq('/aides')
      })

      // Given
      // When
      cy.get('input.c-search-usearch').type("mob")
      cy.get('input.c-search-form-submit').click()
      cy.location().should((loc) => {
        // Then
        expect(loc.pathname).to.eq('/aides')
        expect(loc.search).to.eq('?usearch=mob')
      })

    })

    it("Contact : Une erreur s'affiche si le formulaire est mal rempli", () => {
      //given
      cy.visit('/contact')
      cy.get('body.contact.index').should('exist')
      cy.get('h2.c-contact-errors-title').should('not.exist')
      //when
      cy.get('input#send_message').click()    
      //then
      cy.get('h2.c-contact-errors-title').should('exist')
    })

    it("Contact : un message de confirmation s'affiche si le formulaire a été correctement rempli", () => {
      //given
      cy.visit('/contact')
      cy.get('body.contact.index').should('exist')
      cy.get('#first_name').clear().invoke('val', 'johann').trigger('input');
      cy.get('#last_name').clear().invoke('val', 'strauss').trigger('input');
      cy.get('#email').clear().invoke('val', 'johann@strauss.com').trigger('input');
      cy.get('select#region').select("ARA")
      cy.get('input#contact_form_youare_particulier').click()
      cy.get('input#contact_form_askfor_referencer').click()
      cy.get('textarea#question').clear().invoke('val', 'Ceci est ma question non musicale').trigger('input');
      cy.get('input#send_message').click()    
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/contact_sent')})
    })

  })

})

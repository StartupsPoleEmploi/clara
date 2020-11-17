context('Parcours du formulaire', () => {


  beforeEach(() => {
    cy.visit('/admin')
  })


  describe("Pour un administrateur qui veut créer et publier une aide", () => {

    it("Il tente d'accèder à l'interface d'admin, mais il est redirigé vers la page de connexion", () => {
      cy.location().should((location) => {
        expect(location.pathname).to.eq('/sign_in')
      })
      cy.get('#flash_alert').should('contain', 'Merci de vous connecter avant de continuer.')
    })

    it("Il entre des identifiants incorrect, l'accès est refusé", () => {
      // given
      cy.get('#session_email')
        .type('fake@email.com').should('have.value', 'fake@email.com')
      cy.get('#session_password')
        .type('invalid_password').should('have.value', 'invalid_password')

      // when
      cy.get('.c-login-connect input').click()

      // then
      cy.location().should((location) => {
        expect(location.pathname).to.eq('/session')
      })
      cy.get('#flash_notice').should('contain', 'Utilisateur ou mot de passe non reconnu')
    })

    it("Il entre des identifiants corrects, l'accès est accepté", () => {
      // given
      cy.get('#session_email')
        .type('superadmin@clara.com').should('have.value', 'superadmin@clara.com')
      cy.get('#session_password')
        .type('bar').should('have.value', 'bar')

      // when
      cy.get('.c-login-connect input').click()

      // then
      cy.location().should((location) => {
        expect(location.pathname).to.eq('/admin')
      })
    })

  })


})

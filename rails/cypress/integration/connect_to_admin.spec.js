context("Connexion à l'admin", () => {

  before(() => { 
    cy.request('/cypress_rails_reset_state')
  })
  beforeEach(() => {
    Cypress.Cookies.preserveOnce('clara', 'remember_token')
  })
  after(() => {
    cy.clearCookie('clara')
    cy.clearCookie('remember_token')
  })

  describe("Tentative de connexion", () => {

    it("Il tente d'accèder à l'interface d'admin, mais il est redirigé vers la page de connexion", () => {
      cy.visit('/admin')
      cy.location().should((location) => {
        expect(location.pathname).to.eq('/sign_in')
      })
      cy.get('#flash_alert').should('contain', 'Merci de vous connecter avant de continuer.')
    })

    it("Il entre des identifiants incorrect, l'accès est refusé", () => {
      // given
      cy.get('#session_email').type('fake@email.com').should('have.value', 'fake@email.com')
      cy.get('#session_password').type('invalid_password').should('have.value', 'invalid_password')
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
      cy.getCookies().should((cookies) => {
        // each cookie has these properties
        cy.log('--------------------cookies--------------------')
        cy.log(cookies)
      })
    })

  })

})

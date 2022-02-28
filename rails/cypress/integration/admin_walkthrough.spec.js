context('Administrateur : tour des pages disponibles', () => {


  before(() => {
    cy.request('/cypress_rails_reset_state')
    cy.connect_and_remember_as_superadmin()
  })
  beforeEach(() => {
    Cypress.Cookies.preserveOnce('clara', 'remember_token')
  })
  after(() => {
    cy.clearCookie('clara')
    cy.clearCookie('remember_token')
  })


  describe("Pour un superadmin", () => {

    it("On peut voir une aide", () => {
      cy.visit('/admin/aids/aide-test-mobilite')
      cy.get('#name').siblings('dd').eq(0).should('contain', 'Aide test mobilite')
      cy.get('#what').siblings('dd').eq(0).should('contain', 'what...')
      cy.get('.c-detail-condition-intro').should('contain', 'au moins une des conditions')
      cy.get('.c-history-datetime').should('exist')
    })

    it("On peut créer un nouvel administrateur, il apparaît alors en haut de la liste des administrateurs, en tant que simple contributeur", () => {
      cy.visit('/admin/get_hidden_admin')
      cy.contains('Créer un nouvel administrateur').click()
      cy.location().should((location) => {expect(location.pathname).to.eq('/sign_up')})

      cy.get('#user_email').type('utilisateur@email.com').should('have.value', 'utilisateur@email.com')
      cy.get('#user_password').type('99ValidPassword!').should('have.value', '99ValidPassword!')
      cy.contains('Créer ce nouvel administrateur').click()

      cy.location().should((location) => {
        expect(location.pathname).to.eq('/admin/users')
        expect(location.search).to.eq('?user[direction]=desc&user[order]=created_at')
      })

      cy.get('.js-table-row')
        .first()
        .should('have.attr', 'data-email', 'utilisateur@email.com')
        .and('have.attr', 'data-role', 'contributeur')

    })

    it("On peut se déconnecter, il n'est alors plus possible d'accéder à l'interface d'administration", () => {
      cy.get('.js-sign-out').click()
      cy.visit('/admin')
      cy.location().should((location) => {
        expect(location.pathname).to.eq('/sign_in')
      })
    })
  })

})

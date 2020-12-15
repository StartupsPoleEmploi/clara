context('Administrateur : tour des pages disponibles', () => {


  before(() => {
    cy.request('/cypress_rails_reset_state')
    cy.connect_as_superadmin()
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

    it("On peut prévisualiser une aide", () => {
      cy.get('.c-cutebutton.is-preview').invoke('removeAttr', 'target')
      cy.get('.c-cutebutton.is-preview').click()
      cy.location().should((location) => {
        expect(location.pathname).to.eq('/aides/detail/aide-test-mobilite')
      })
    })

  })

})

context("Création et publication d'une aide", () => {

  before(() => {
    cy.connect_as_superadmin()
  })
  beforeEach(() => {
    Cypress.Cookies.preserveOnce('clara', 'remember_token')
  })
  after(() => {
    cy.clearCookie('clara')
    cy.clearCookie('remember_token')
  })

  describe("Création d'une rubrique", () => {
    before(() => {
      cy.visit('/admin/contract_types')
    })
    it("On peut créer une rubrique", function() {
      // then
      cy.get('a.js-create-contract-type').click()
      cy.location().should((location) => {
        expect(location.pathname).to.eq('/admin/aid_creation/new_aid_stage_1')
      })
    })
    it("On peut créer une rubrique", function() {
      // then
      cy.get('a.js-create-contract-type').should('have.length', 1)
    })
  })

})

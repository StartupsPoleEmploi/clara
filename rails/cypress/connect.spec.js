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

  describe("Création d'une aide", () => {
    describe("Il rempli l'étape 1", () => {
      before(() => {
        cy.visit('/admin/aid_creation/new_aid_stage_1')
      })
      it("Il y a 4 champs", function() {
        // then
        cy.get('.field-unit').should('have.length', 4)
      })
    })

  })

})

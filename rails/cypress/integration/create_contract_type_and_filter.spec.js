context("Administrateur : création Rubriques et filtres", () => {

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

  describe("Création d'une rubrique", () => {

    before(() => {
      cy.visit('/admin/contract_types/new')
    })

    it("Une fois la rubrique créé, on l'affiche", function() {
      cy.get('#contract_type_ordre_affichage').type("42")
      cy.get('#contract_type_name').type("aide a la mobilisation")

      cy.get('#create-ct').click()

      cy.location().should((location) => {
        expect(location.pathname).to.eq('/admin/contract_types/aide-a-la-mobilisation')
      })

    })

  })

  describe("Création d'un filtre", () => {

    before(() => {
      cy.visit('/admin/filters/new')
    })

    it("Une fois le filtre créé, on l'affiche", function() {
      cy.get('#filter_name').type("deplacement")
      cy.get('#filter_ordre_affichage').type("2")

      cy.get('.c-filter-record').click()

      cy.location().should((location) => {
        expect(location.pathname).to.eq('/admin/filters/deplacement')
      })

    })

  })

})

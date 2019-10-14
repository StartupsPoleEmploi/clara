describe("Impossible de supprimer une aide pour un simple admin", function() {
  before(function() {
    cy.connect_as_simple_admin()
  })
  after(function() {
    cy.disconnect_from_admin()
  })
  it("quand on liste les aides", function() {
    cy.visit('/admin/aids')
    cy.get('a.js-delete-aid').should('not.exist') 
  })
})
describe("Possible de supprimer une aide pour un super-admin", function() {
  before(function() {
    cy.connect_as_super_admin()
  })
  after(function() {
    cy.disconnect_from_admin()
  })
  it("quand on liste les aides", function() {
    cy.visit('/admin/aids')
    cy.get('a.js-delete-aid').should('exist') 
  })
})


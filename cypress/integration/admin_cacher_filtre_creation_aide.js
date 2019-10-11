describe("Cacher les filtres inutiles à la création de l'aide pour un simple admin", function() {
  before(function() {
    cy.connect_as_simple_admin()
  })
  after(function() {
    cy.disconnect_from_admin()
  })
  it("lors de la création", function() {
    cy.visit('/admin/aids/new')
    cy.stage_3_has_few_fields()
  })
  it("lors de la modification", function() {
    cy.visit('/admin/aids/erasmus/edit')
    cy.stage_3_has_few_fields()
  })
})
describe("Montrer les filtres inutiles de l'aide pour un super-admin", function() {
  before(function() {
    cy.connect_as_super_admin()
  })
  after(function() {
    cy.disconnect_from_admin()
  })
  it("lors de la création", function() {
    cy.visit('/admin/aids/new')
    cy.stage_3_has_all_fields()
  })
  it("lors de la modification", function() {
    cy.visit('/admin/aids/erasmus/edit')
    cy.stage_3_has_all_fields()
  })
})


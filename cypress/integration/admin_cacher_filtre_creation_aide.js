describe("Cacher les filtres inutiles à la création de l'aide pour un simple admin", function() {
  it("lors de la création", function() {
    cy.connect_as_simple_admin()
    cy.visit('/admin/aids/new')
    cy.stage_3_has_few_fields()
  })
  it("lors de la modification", function() {
    cy.connect_as_simple_admin()
    cy.visit('/admin/aids/erasmus/edit')
    cy.stage_3_has_few_fields()
  })
})
describe("Montrer les filtres inutiles de l'aide pour un super-admin", function() {
  it("lors de la création", function() {
    cy.connect_as_super_admin()
    cy.visit('/admin/aids/new')
    cy.stage_3_has_all_fields()
  })
  it("lors de la modification", function() {
    cy.connect_as_super_admin()
    cy.visit('/admin/aids/erasmus/edit')
    cy.stage_3_has_all_fields()
  })
})


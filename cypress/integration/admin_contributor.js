describe("Pour un contributeur", function() {

  before(function() {
    cy.connect_as_contributor()
  })

  after(function() {
    cy.disconnect_from_admin()
  })

  describe("Quand on liste les aides", function() {
    before(function() {
      cy.visit('/admin/aids')
    })
    it("Il est impossible de supprimer une aide", function() {
      cy.get('a.js-delete-aid').should('not.exist') 
    })
  })
  
  describe("À la création d'aide", function() {
    before(function() {
      cy.visit('/admin/aids/new')
    })
    it("Ne montrer que le filtre \"Page de résultats\"", function() {
      cy.get('#label_need_filters').should('not.exist') 
      cy.get('#label_custom_filters').should('not.exist') 
      cy.get('#label_filters').should('exist')  // Filtres page de résultat
    })
    it("Ne pas montrer la date d'archivage", function() {
      cy.get('input[name="aid[archived_at]"]').should('not.exist')
    })
  })
  
  describe("À la modification d'aide", function() {
    before(function() {
      cy.visit('/admin/aids/erasmus/edit')
    })
    it("Ne montrer que le filtre \"Page de résultats\"", function() {
      cy.get('#label_filters').should('exist')  // Filtres page de résultat
    })
    it("Ne pas montrer la date d'archivage", function() {
      cy.get('input[name="aid[archived_at]"]').should('not.exist')
    })
  })

})


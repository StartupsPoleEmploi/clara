describe("Lister les aides", function() {

  describe("Pour un relecteur", function() {
    before(function() {
      // given
      cy.connect_as_relecteur1()
      // when
      cy.visit('/admin/aids')

    })

    it("Pour un relecteur, la suppression d'une aide est possible", function() {
      // then
      cy.get('a.js-delete-aid').should('exist')
    })  
  })

  describe("Pour un contributeur", function() {
    before(function() {
      // given
      cy.connect_as_contributeur1()
      // when
      cy.visit('/admin/aids')

    })

    it("Pour un contributeur, aucune aide ne peut être supprimée", function() {
      // then
      cy.get('a.js-delete-aid').should('not.exist')
    })  
  })

})


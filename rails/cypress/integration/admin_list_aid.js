describe("Lister les aides", function() {

  describe("Pour un superadmin", function() {
    before(function() {
      // given
      cy.connect_as_superadmin()
      // when
      cy.visit('/admin/aids')

    })

    it("Pour un superadmin, la suppression d'une aide est possible", function() {
      // then
      cy.get('a.js-delete-aid').should('exist')
    })  
    it("Pour un superadmin, l'archivage d'une aide est possible", function() {
      // then
      cy.get('a.js-archive-aid').should('exist')
    })  
  })

  describe("Pour un relecteur", function() {
    before(function() {
      // given
      cy.connect_as_relecteur1()
      // when
      cy.visit('/admin/aids')

    })

    it("Pour un relecteur, la suppression d'une aide n'est pas possible", function() {
      // then
      cy.get('a.js-delete-aid').should('not.exist')
    })  
    it("Pour un relecteur, l'archivage d'une aide est pas possible", function() {
      // then
      cy.get('a.js-archive-aid').should('exist')
    })  
  })

  describe("Pour un contributeur", function() {
    before(function() {
      // given
      cy.connect_as_contributeur1()
      // when
      cy.visit('/admin/aids')
    })

    it("Pour un contributeur, la suppression d'une aide n'est pas possible", function() {
      // then
      cy.get('a.js-delete-aid').should('not.exist')
    })  
    it("Pour un contributeur, l'archivage d'une aide n'est pas possible", function() {
      // then
      cy.get('a.js-archive-aid').should('not.exist')
    }) 
  })

})


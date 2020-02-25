describe("Lister les aides", function() {


  describe("Pour un relecteur", function() {
    before(function() {
      // given
      cy.connect_as_relecteur1()
      // when
      cy.visit('/admin/aid_creation/new_aid_stage_5?locale=fr&modify=true&slug=erasmus')
    })
    it("Pour un relecteur, l'archivage est possible depuis l'étape 5", function() {
      cy.get('input.c-newaid-actionrecord').should('have.value', 'Archiver cette aide')
      cy.get('input.c-newaid-actionrecord').click()
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin')})
      cy.get('[data-col="aid.name"]').first().shouldHaveTrimmedText('Erasmus +')
      cy.get('[data-col="aid.status"]').first().shouldHaveTrimmedText('Archivée')
    })  
    it("On peut republier depuis l'étape 5", function() {
      cy.visit('/admin/aid_creation/new_aid_stage_5?locale=fr&modify=true&slug=erasmus')
      cy.get('.c-newaid-actionrecord').should('exist')
      cy.get('input.c-newaid-actionrecord').should('have.value', 'Publier sur le site web')
      cy.get('input.c-newaid-actionrecord').click()
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin')})
      cy.get('[data-col="aid.name"]').first().shouldHaveTrimmedText('Erasmus +')
      cy.get('[data-col="aid.status"]').first().shouldHaveTrimmedText('Publiée')
    })  
    it("Pour un relecteur, l'archivage est possible depuis la liste des aides", function() {
      cy.get('.js-archive-aid').first().click()
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/aids')})
      cy.get('[data-col="aid.name"]').first().shouldHaveTrimmedText('Erasmus +')
      cy.get('[data-col="aid.status"]').first().shouldHaveTrimmedText('Archivée')
    })  
    it("On peut republier à nouveau depuis l'étape 5", function() {
      cy.visit('/admin/aid_creation/new_aid_stage_5?locale=fr&modify=true&slug=erasmus')
      cy.get('.c-newaid-actionrecord').should('exist')
      cy.get('input.c-newaid-actionrecord').should('have.value', 'Publier sur le site web')
      cy.get('input.c-newaid-actionrecord').click()
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin')})
      cy.get('[data-col="aid.name"]').first().shouldHaveTrimmedText('Erasmus +')
      cy.get('[data-col="aid.status"]').first().shouldHaveTrimmedText('Publiée')
    })  
  })
})


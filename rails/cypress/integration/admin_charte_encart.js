describe("Voir l'encart de la charte", function() {

  const ORIGINAL_URL = '/admin/aid_creation/new_aid_stage_2?slug=erasmus&modify=true'
  const OTHER_URL = '/admin/aid_creation/new_aid_stage_3?slug=erasmus&modify=true'

  before(function () {
    // when
    cy.connect_as_relecteur1()
  })
  after(function () {
    cy.disconnect_from_admin()
  })
  describe("Pour un relecteur, sur l'étape 2 (url originale)", function () {
    before(function () {
      // given
      cy.get('.alert-convention').should('not.exist')
      // when
      cy.visit(ORIGINAL_URL)
    })
    it("L'encart est visible", function () {
      // then
      cy.get('.alert-convention').should('exist')
    })
    it("Si on clique sur EN SAVOIR PLUS, on arrive sur la charte éditoriale", function () {
      cy.get('.js-know-more').click()
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/conventions/1')})
    })
    it("Si on revient sur l'URL originale, l'encart est toujours présent", function () {
      cy.visit(ORIGINAL_URL)
      cy.get('.alert-convention').should('exist')
    })
    it("Si on clique sur OK, l'encart disparaît", function () {
      cy.get('.js-hide-convention').click()
      cy.get('.alert-convention').should('not.be.visible')
    })
  })

})


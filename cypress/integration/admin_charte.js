describe("Voir la charte", function() {

  describe("Pour un relecteur", function () {
    before(function () {
      // when
      cy.connect_as_relecteur1()
      cy.visit('/admin/conventions/1')
    })
    it("Afficher le bouton modifier", function () {
      // then
      cy.get('header > div > a.button').should('have.attr', 'href').and('include', 'edit')
    })
  })

  describe("Pour un contributeur", function () {
    before(function () {
      // when
      cy.connect_as_contributeur1()
      cy.visit('/admin/conventions/1')
    })
    it("Omettre le bouton modifier", function () {
      // then
      cy.get('header > div > a.button').should('have.attr', 'href').and('not.include', 'edit')
    })
  })


})


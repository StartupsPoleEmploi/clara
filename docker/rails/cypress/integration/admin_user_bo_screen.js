describe("Voir les utilisateurs du BO", function() {

  describe("Pour un superadmin", function () {
    before(function () {
      // when
      cy.connect_as_superadmin()
      cy.visit('/admin/users')
    })
    it("Montrer l'email d'un utilisateur'", function () {
      // then
      cy.get('span[data-key*="user.email"]').should('exist')
    })
    it("Montrer le lien Modifier", function () {
      // then
      cy.get('a[href*="edit"]').should('exist')
    })
    it("Montrer le lien Supprimer", function () {
      // then
      cy.get('a[data-method="delete"][href*="users"]').should('exist')
    })
  })

  describe("Pour un relecteur BO", function () {
    before(function () {
      // when
      cy.connect_as_relecteur1()
      cy.visit('/admin/users')
    })
    it("Montrer l'email d'un utilisateur'", function () {
      // then
      cy.get('span[data-key*="user.email"]').should('exist')
    })
    it("Omettre le lien Modifier", function () {
      // then
      cy.get('a[href*="edit"]').should('not.exist')
    })
    it("Omettre le lien Supprimer", function () {
      // then
      cy.get('a[data-method="delete"][href*="users"]').should('not.exist')
    })
  })


})


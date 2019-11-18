describe("Pour un relecteur", function () {

  before(function () {
    cy.connect_as_relecteur1()
  })

  after(function () {
    cy.connect_as_superadmin()
    cy.visit('/admin/aids?aid%5Bdirection%5D=desc&aid%5Border%5D=updated_at')
    cy.get('a.js-delete-aid[href="/admin/aids/ma-nouvelle-aide?locale=fr"]').click()
  })

  describe("Quand on liste les aides", function () {
    before(function () {
      cy.visit('/admin/aids')
    })
    it("Il est possible de supprimer une aide", function () {
      cy.get('a.js-delete-aid').should('exist')
    })
  })

  describe("Écran de création d'une aide", function () {
    before(function () {
      cy.visit('/admin/aids/new')
    })
    it("Ne montrer que le filtre \"Page de résultats\"", function () {
      cy.get('#label_need_filters').should('not.exist')
      cy.get('#label_custom_filters').should('not.exist')
      cy.get('#label_filters').should('exist')  // Filtres page de résultat
    })
    it("Ne pas montrer la date d'archivage", function () {
      cy.get('input[name="aid[archived_at]"]').should('not.exist')
    })
  })

  describe("Possibilité d'effectivement créer une aide", function () {
    it("Un relecteur peut créer une aide", function () {
      cy.create_old_aid("Ma nouvelle aide")
    })
  })

  describe("À la modification d'une aide créé par lui-même", function () {
    before(function () {
      cy.visit('/admin/aids/ma-nouvelle-aide/edit')
    })
    it("Ne pas montrer la date d'archivage", function () {
      cy.get('input[name="aid[archived_at]"]').should('not.exist')
    })
  })

  describe("Écran de modification de cette même aide par un tiers (contributeur)", function () {
    before(function () {
      cy.connect_as_contributeur1()
      cy.visit('/admin/aids/ma-nouvelle-aide/edit')
    })
    it("Montrer la date d'archivage", function () {
      cy.get('input[name="aid[archived_at]"]').should('exist')
    })
    after(function () {
      cy.connect_as_relecteur1()
    })
  })

  describe("Écran de la charte éditoriale", function () {
    before(function () {
      cy.visit('/admin/conventions/1?locale=fr')
    })
    it("Afficher le bouton modifier", function () {
      cy.get('header > div > a.button').should('have.attr', 'href').and('include', 'edit')
    })
    it("Omettre le bouton créer", function () {
      cy.get('header > div > a.button').should('have.attr', 'href').and('not.include', 'new')
    })
    it("Omettre le bouton supprimer", function () {
      cy.get('header > div > a.button').should('have.attr', 'href').and('not.include', 'delete')
    })
  })

  describe("Écran des administrateurs BO", function () {
    before(function () {
      cy.visit('/admin/users?locale=fr')
    })
    it("Montrer l'email d'un utilisateur'", function () {
      cy.get('span[data-key*="user.email"]').should('exist')
    })
    it("Omettre le lien Modifier", function () {
      cy.get('a[href*="edit"]').should('not.exist')
    })
    it("Omettre le lien Supprimer", function () {
      cy.get('a[data-method="delete"][href*="users"]').should('not.exist')
    })
  })

  describe("Écran des utilisateurs API", function () {
    before(function () {
      cy.visit('/admin/api_users?locale=fr')
    })
    it("Montrer l'email d'un utilisateur'", function () {
      cy.get('span[data-key*="user.email"]').should('exist')
    })
    it("Omettre le lien Modifier", function () {
      cy.get('a[href*="edit"]').should('not.exist')
    })
    it("Omettre le lien Supprimer", function () {
      cy.get('a[data-method="delete"][href*="users"]').should('not.exist')
    })
  })

  describe("Le relecteur peut créer un contributeur", function () {
    before(function () {
      // given
      cy.create_a_user('new_contributeur@clara.com', 'password')
    })
    after(function () {
      cy.delete_a_user('new_contributeur@clara.com')
    })
    it("L'utilisateur créé apparaît bien en tant que contributeur dans la liste des administrateurs", function () {
      // when
      cy.visit('/admin/users?user[direction]=desc&user[order]=updated_at')
      //then
      cy.get('tr[data-email="new_contributeur@clara.com"]').invoke('attr', 'data-role').should('contain', 'contributeur')

      // cy.get('tr').contains('new_contributeur@clara.com').should('exist')
      // cy.get('td.cell-data--enum-field > a.action-show').first().contains('Contributeur').should('exist')
    })
  })

})

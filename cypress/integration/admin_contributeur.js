describe("Pour un contributeur", function () {

  before(function () {
    cy.connect_as_contributeur1()
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
    it("Il est impossible de supprimer une aide", function () {
      cy.get('a.js-delete-aid').should('not.exist')
    })
  })

  describe("Affichages au moment de créer une aide", function () {
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
    it("Un contributeur peut créer une aide", function () {
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

  describe("À la modification d'une aide créé par un autre contributeur", function () {
    before(function () {
      cy.connect_as_contributeur2()
      cy.visit('/admin/aids/ma-nouvelle-aide/edit')
    })
    it("Montrer la date d'archivage", function () {
      cy.get('input[name="aid[archived_at]"]').should('exist')
    })
  })

  describe("Sur la page de la charte éditoriale", function () {
    before(function () {
      cy.connect_as_contributeur2()
      cy.visit('/admin/conventions/1?locale=fr')
    })
    it("Omettre le bouton modifier", function () {
      cy.get('button.button.edit').should('not.exist')
    })
  })

})


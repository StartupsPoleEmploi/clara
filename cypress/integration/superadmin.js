describe("Pour un super-admin", function() {

  before(function() {
    cy.connect_as_super_admin()
  })

  after(function() {
    cy.disconnect_from_admin()
  })
  describe("Quand on liste les aides", function() {
    before(function() {
      cy.visit('/admin/aids')
    })
    it("Il est possible de supprimer une aide", function() {
      cy.get('a.js-delete-aid').should('exist') 
    })
  })
  describe("À la création d'aide", function() {
    before(function() {
      cy.visit('/admin/aids/new')
    })
    it("Montrer les tous filtres", function() {
      cy.get('#label_need_filters').should('exist') 
      cy.get('#label_custom_filters').should('exist') 
      cy.get('#label_filters').should('exist')  // Filtres page de résultat
    })
    it("Ne pas montrer la date d'archivage", function() {
      cy.get('input[name="aid[archived_at]"]').should('not.exist')
    })
    it("On peut renseigner uniquement les champs obligatoires et valider", function() {
      cy.get('input#aid_name').type('My new aid')
      cy.get('select#aid_contract_type_id').select('Aide à la mobilité')
      cy.get('input#aid_ordre_affichage').type('42')
      cy.get('input#modify-aid').click()
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/admin/aids/new')})
    })
    it("L'aide est créée avec une date d'archivage égale à la date du jour", function() {
      cy.visit('/admin/aids/my-new-aid')
      const getDate = dateTime => {
        return Cypress.moment(dateTime).format('DD MMMM YYYY') // 06 February 2019
      }
      const monthes = {"January" : "janvier","February" : "février","March" : "mars","April" : "avril","May" : "mai","June" : "juin","July" : "juillet","August" : "août","September" : "septembre","October" : "octobre","November" : "novembre","December" : "décembre",}
      let expected_date = getDate() + " 00h 00min 00s"
      let fr_month = monthes[expected_date.split(" ")[1]]
      let array_monthes = expected_date.split(" ")
      array_monthes[1] = fr_month
      let fr_date = array_monthes.join(" ")

      cy.get('dt#archived_at').nextAll().eq(0).contains(fr_date)
    })
    it("On peut supprimer l'aide créée", function() {
      cy.visit('/admin/aids?aid%5Bdirection%5D=desc&aid%5Border%5D=updated_at')
      cy.get('a.js-delete-aid[href="/admin/aids/my-new-aid?locale=fr"]').click()
    })
  })
  describe("À la modification d'aide", function() {
    before(function() {
      cy.visit('/admin/aids/erasmus/edit')
    })
    it("Montrer les tous filtres", function() {
      cy.get('#label_need_filters').should('exist') 
      cy.get('#label_custom_filters').should('exist') 
      cy.get('#label_filters').should('exist')  // Filtres page de résultat
    })
    it("Montrer la date d'archivage", function() {
      cy.get('input[name="aid[archived_at]"]').should('exist')
    })
  })

})


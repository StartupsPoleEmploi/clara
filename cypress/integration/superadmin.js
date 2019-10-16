describe("Pour un super-admin", function() {

  before(function() {
    cy.connect_as_super_admin()
  })

  after(function() {
    cy.disconnect_from_admin()
  })

  // describe("Quand on liste les aides", function() {
  //   before(function() {
  //     cy.visit('/admin/aids')
  //   })
  //   it("Il est possible de supprimer une aide", function() {
  //     cy.get('a.js-delete-aid').should('exist') 
  //   })
  // })
  
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
    it("Le bouton d'enregistrement a un texte expliquant qu'il y aura relecture", function() {
      cy.get('#record_root_rule').contains("Enregistrer pour relecture")
    })
    it("Il y a un texte expliquant qu'il y aura relecture", function() {
      cy.get('.c-aid-detail-subfooter-text').contains("l'aide créée sera relue")
    })
    it("On peut enregistrer un champ d'application et enregistrer l'aide. Une popup s'affiche qui averti de la publication après relecture", function() {
      cy.get('select#rule_variable_id').select('v_age')
      cy.get('select#rule_operator_kind').select('more_than')
      cy.get('input#rule_value_eligible').type('18')
      cy.get('.c-apprule-button.is-validation').click()
      cy.get('button#record_root_rule').click()
      cy.get('dialog#js-tooltip').contains("Mise à jour du champ d'application effectué. L'aide sera publiée sur le site après relecture par l'équipe de modération.")
    })
    it("L'aide est créée avec une date d'archivage égale à la date du jour", function() {
      cy.visit('/admin/aids/my-new-aid')
      const getDate = dateTime => {
        return Cypress.moment(dateTime).format('DD MMMM YYYY') // 06 February 2019
      }
      const monthes = {"January" : "janvier","February" : "février","March" : "mars","April" : "avril","May" : "mai","June" : "juin","July" : "juillet","August" : "août","September" : "septembre","October" : "octobre","November" : "novembre","December" : "décembre",}
      let expected_date = getDate() + " 00h 00min 00s"
      let array_monthes = expected_date.split(" ")
      let fr_month = monthes[array_monthes[1]]
      array_monthes[1] = fr_month
      let fr_date = array_monthes.join(" ")

      cy.get('dt#archived_at').nextAll().eq(0).contains(fr_date)
    })
    it("En modification, la date du jour est inscrite par défaut", function() {
      cy.visit('/admin/aids/my-new-aid/edit')
      const getDateOfToday = dateTime => {
        return Cypress.moment(dateTime).format('DD/MM/YYYY') // 16/02/2019
      }
      cy.get('input#aid_archived_at').should('have.value', getDateOfToday())
    })
    it("En modification du champ d'appli, il n'y a plus de petit texte explicatif, le bouton d'enregistrement a un texte plus simple, la popup de confirmation également", function() {
      cy.visit('/admin/rule_creation?aid=my-new-aid')
      cy.get('.c-aid-detail-subfooter-text').should('not.exist')
      cy.get('#record_root_rule').contains("Enregistrer les modifications")
      cy.get('button#record_root_rule').click()
      cy.get('dialog#js-tooltip').contains("Mise à jour du champ d'application effectué.")
    })
    it("On peut supprimer l'aide créée", function() {
      cy.visit('/admin/aids?aid%5Bdirection%5D=desc&aid%5Border%5D=updated_at')
      cy.get('a.js-delete-aid[href="/admin/aids/my-new-aid?locale=fr"]').click()
    })
    it("L'aide n'apparaît plus dans la liste", function() {
      cy.visit('/admin/aids?aid%5Bdirection%5D=desc&aid%5Border%5D=updated_at')
      cy.get('a.js-delete-aid[href="/admin/aids/my-new-aid?locale=fr"]').should('not.exist')
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


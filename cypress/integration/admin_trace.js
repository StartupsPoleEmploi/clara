describe("Tracer une aide", function() {

  describe("Pour un superadmin", function() {
    before(function() {
      cy.connect_as_superadmin()
      cy.authorize_google_analytics()
    })

    after(function() {
      cy.visit('/admin/tracings/')
      cy.get('.js-table-row a[data-method="delete"]').click()
      cy.visit('/admin/traces/')
      cy.get('.js-table-row a[data-method="delete"]').click()
    })

    it("On part d'un état où aucun suivi n'a encore eu lieu", function () {
      cy.visit('/admin/traces')
      cy.get('table[aria-labelledby="page-title"] tbody').shouldHaveTrimmedText('')
      cy.visit('/admin/tracings')
      cy.get('table[aria-labelledby="page-title"] tbody').shouldHaveTrimmedText('')
    })


    it("Pour un superadmin, la création d'un suivi est possible", function() {
      cy.visit('/admin/tracings/new')
      cy.get('input#tracing_name').clear().invoke('val', 'suivi-test').trigger('input');
      cy.get('textarea#tracing_description').clear().invoke('val', 'une description').trigger('input');
      cy.get('select#tracing_rule_id').select("362")
      cy.get('input#tracing_all_aids').click()
      cy.get('input[value="Créer ce suivi"]').click()
      cy.clear_the_cache()
    })  

    it("Si un simple visiteur effectue une visite sur la page de détail qui correspond aux critères de suivi, le suivi est enregistré", function () {
      cy.visit('/aides/detail/erasmus?for_id=MjMsNCxuLDEsNixuLHAsLCxub3RfYXBwbGljYWJsZSxu')
      cy.get('body.detail.show').should('exist')
      cy.visit('/admin/traces?trace[direction]=desc&trace[order]=created_at')
      cy.get('table[aria-labelledby="page-title"] tbody td').first().shouldHaveTrimmedText('suivi-test')
    })
    // ?for_id=MjMsNCxuLDEsNixuLHAsLCxub3RfYXBwbGljYWJsZSxu
  })


})


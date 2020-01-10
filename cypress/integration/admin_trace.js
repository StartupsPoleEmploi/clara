describe("Tracer une aide", function() {

  describe("Pour un superadmin", function() {
    before(function() {
      // given
      cy.connect_as_superadmin()
      // when
      cy.visit('/admin/tracings/new')
    })

    // after(function() {
    //   cy.visit('/admin/tracings/')
    //   cy.get('.js-table-row a[data-method="delete"]').click()
    // })

    it("Pour un superadmin, la création d'un suivi est possible", function() {
      cy.get('input#tracing_name').clear().invoke('val', 'suivi-test').trigger('input');
      cy.get('textarea#tracing_description').clear().invoke('val', 'une description').trigger('input');
      cy.get('select#tracing_rule_id').select("362")
      cy.get('input#tracing_all_aids').click()
      cy.get('input[value="Créer ce suivi"]').click()
    })  

    it("Si un simple visiteur effectue une visite sur la page de détail qui correspond aux critères de suivi, le suivi est enregistré", function () {
      cy.visit('/aides/detail/erasmus?for_id=MjMsNCxuLDEsNixuLHAsLCxub3RfYXBwbGljYWJsZSxu')
      
    })
    // ?for_id=MjMsNCxuLDEsNixuLHAsLCxub3RfYXBwbGljYWJsZSxu
  })


})


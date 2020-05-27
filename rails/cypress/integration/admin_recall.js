describe("En tant que superadmin", function () {

  before(function() {
    cy.clear_mailbox()
    cy.connect_as_superadmin()
  })
  after(function() {
    cy.visit('/admin/recalls')
    cy.get('a.text-color-red').first().click()
  })

  it("Il est possible d'accéder à la liste des rappels depuis le menu de gauche", function () {
    //given
    cy.visit('/admin')
    cy.get('nav.navigation').should('exist')
    //when
    cy.get('nav.navigation a.navigation__link').last().click()    
    //then
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/recalls')})
    cy.get('#page-title').shouldHaveTrimmedText('Liste des rappels')    
  })

  it("Il est possible de créer un nouveau rappel", function () {
    //given
    cy.get('a.new-recall-link').click()
    //then
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/recalls/new')})
  })
  it("L'email est prérempli, mais en lecture seule", function () {
    cy.get("input#recall_email").should('have.attr', 'readonly')
    cy.get("input#recall_email").invoke('val').should((txt) => {expect(txt).to.eq('superadmin@clara.com')})
  })
  it("La date et l'aide sont vides par défaut", function () {
    cy.get("input#recall_trigger_at").invoke('val').should((txt) => {expect(txt).to.eq('')})
    cy.get("select#recall_aid_id").should('have.value', '')
  })
  it("Si on valide sans rien remplir, des erreurs sont affichées pour l'aide et la date", function () {
    cy.get('input[value="Créer ce rappel"]').click()
    cy.get("li.flash-error").first().shouldHaveTrimmedText('Aide : doit être renseigné(e)')
    cy.get("li.flash-error").last().shouldHaveTrimmedText("Date d'envoi prévue : doit être renseigné(e)")
  })
  it("Si on rempli et on valide, la création est validée avec succès", function () {
    cy.get("input#recall_trigger_at").type('20/02/2020')
    cy.get("select#recall_aid_id").select('Erasmus +')
    cy.get('input[value="Créer ce rappel"]').click()
    
    cy.get(".flash-notice")
      .first()
      .shouldHaveTrimmedText("Création effectuée avec succès.")
  })

  // TEST FAILURE
  // it("Si un visiteur visite la page de détail d'une aide, et qu'un rappel n'a pas encore été envoyé, un email adéquat est envoyé", function () {
  //   cy.visit("/aides/detail/illico-solidaire?force=true&for_id=MjcsNCxuLCwxLG4sbiw0MzAwMiw0MzAwMCxub3RfYXBwbGljYWJsZSxv")
  //   cy.visit('/letter_opener')
  //     cy.get('iframe#mail').then(function ($iframe) {
  //     const $body = $iframe.contents().find('body')

  //     cy.wrap($body)
  //       .find('iframe[seamless="seamless"]')
  //       .then(function ($iframe2) {
  //         const $body2 = $iframe2.contents().find('body')

  //         cy.wrap($body2)
  //           .find('div')
  //           .eq(1)
  //           .shouldHaveTrimmedText('Vous avez créé une alerte automatique pour l\'aide "Erasmus +".')
  //       })
  //   })

  // })
})


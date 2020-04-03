describe("En tant que superadmin", function () {

  before(function() {
    cy.clear_mailbox()
  })


  it("Je peux remplir le formulaire de contact sans remplir les champs, les erreurs s'affichent", function () {
    //given
    cy.visit('/contact')
    cy.get('body.contact.index').should('exist')
    cy.get('h2.c-contact-errors-title').should('not.exist')
    //when
    cy.get('input#send_message').click()    
    //then
    cy.get('h2.c-contact-errors-title').should('exist')
  })

  it("Je peux remplir le formulaire de contact", function () {
    //given
    cy.visit('/contact')
    cy.get('body.contact.index').should('exist')
    cy.get('#first_name').clear().invoke('val', 'johann').trigger('input');
    cy.get('#last_name').clear().invoke('val', 'strauss').trigger('input');
    cy.get('#email').clear().invoke('val', 'johann@strauss.com').trigger('input');
    cy.get('select#region').select("ARA")
    cy.get('input#contact_form_youare_particulier').click()
    cy.get('input#contact_form_askfor_referencer').click()
    cy.get('textarea#question').clear().invoke('val', 'Ceci est ma question non musicale').trigger('input');
    cy.get('input#send_message').click()    
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/contact_sent')})
  })
  it("Un email a bien été envoyé", function () {
    //given
    cy.visit('/letter_opener')
    cy.get('iframe#mail').then(function ($iframe) {
      const $body = $iframe.contents().find('body')
      cy.wrap($body)
        .find('iframe[seamless="seamless"]')
        .then(function ($iframe2) {
          const $body2 = $iframe2.contents().find('body')
          cy.wrap($body2).find('h1').first().shouldHaveTrimmedText('Un formulaire a été rempli correctement')
        })
    })
  })

})


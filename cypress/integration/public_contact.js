describe("En tant que simple visiteur", function () {

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

})


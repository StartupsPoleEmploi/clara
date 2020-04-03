describe("En tant que superadmin", function () {

  before(function() {
    cy.clear_mailbox()
    cy.connect_as_superadmin()
  })


  it("Il est possible d'accéder à la liste des rappels", function () {
    //given
    cy.visit('/admin')
    cy.get('nav.navigation').should('exist')
    //when
    cy.get('nav.navigation a.navigation__link').last().click()    
    //then
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/admin/recalls')})
    cy.get('#page-title').shouldHaveTrimmedText('Liste des rappels')    
  })

})


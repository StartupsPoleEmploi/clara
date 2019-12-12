describe("Pour un visiteur", function () {


  it("Quand on arrive sur la page principale, on peut démarrer le formulaire", function () {
    // given
    cy.visit('/')
    // when
    cy.get('.c-main-cta').click()
    // then
    cy.location().should((loc) => { expect(loc.pathname).contains('question') })
  })

  it("On peut remplir toutes les questions, on arrive sur l'écran de résultat", function () {

    // given
    cy.get('#moins_d_un_an').should("exist")
    cy.get('#moins_d_un_an').click()
    cy.get('.js-next').click()

    cy.get('#cat_12345').should("exist")
    cy.get('#cat_12345').click()
    cy.get('.js-next').click()

    cy.get('#radio_ARE_ASP').should("exist")
    cy.get('#radio_ARE_ASP').click()
    cy.get('.js-next').click()

    cy.get('#montant').should("exist")
    cy.get('#montant').type("842")
    cy.get('.js-next').click()

    cy.get('#age').should("exist")
    cy.get('#age').type("16")
    cy.get('.js-next').click()
    
    cy.get('#niveau_4').should("exist")
    cy.get('#niveau_4').click()
    cy.get('.js-next').click()
    
    cy.get('#search').should("exist")
    cy.get('.js-next').click()
    
    cy.get('#val_spectacle').should("exist")
    cy.get('#val_spectacle').click()

    //when
    cy.get('.js-next').click()

    //then 
    cy.get("body.c-body.aides").should("exist")

  })
  it("Sur l'écran de résultat il y a les aides éligibles et non éligibles", function () {
    cy.get('.c-resultcard--green').its('length').should('be.gt', 0)
    cy.get('.c-resultcard--red').its('length').should('be.gt', 0)
  })
})


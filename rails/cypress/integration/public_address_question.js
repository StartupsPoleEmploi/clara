describe("Quand on arrive sur la question adresse", function () {

  before(function () {
    cy.visit('/')
    cy.get("body.c-body.welcome.index").should('exist')
    cy.visit('/address_questions/new')
  })

  it("Les éléments : retour, progressbar, et numéro de question sont présents", function () {
    cy.get('.c-progressbar').should("exist")
    cy.get('.c-question-number').should("exist")
    cy.get('.c-back-question').should("exist")
  })

  it("Champ nombre vide", function () {
    cy.get('input[type="number"]').should('be.empty')
  })

  it("focus sur le champ nombre", function () {
    cy.get('input[type="number"]').first().should('have.focus')
  })

  it("Absence d'erreur lorqu'on arrive sur la page", function () {
    cy.get('.c-label.is-error').should('not.exist')
  })

  it("Erreur si on ne remplit rien ", function () {
    // when
    cy.get('input[value="Continuer"]').click()
    // then
    cy.get('.c-label.is-error').should('exist')
  })

  it("Cas nominal : on renseigne un code postal, on sélectionne une ville et on valide, ", function () {
    // given
    cy.visit('/address_questions/new')
    cy.get('input#search').first().type("44200")
    cy.get('li.autocomplete-item').should("exist")
    cy.get('li.autocomplete-item').first().click()
    // when
    cy.get('input[value="Continuer"]').click()
    // then
    cy.location('pathname').should('not.contain', 'address_questions')
  })
  it("Erreur : on renseigne un code postal, on sélectionne une ville, on la modifie et on valide", function () {
    // given
    cy.visit('/address_questions/new')
    cy.get('.c-label.is-error').should('not.exist')
    cy.get('input#search').first().type("44200")
    cy.get('li.autocomplete-item').should("exist")
    cy.get('li.autocomplete-item').first().click()
    cy.get('input#search').first().type("not_allowed_chars")
    // when
    cy.get('input[value="Continuer"]').click()
    // then
    cy.get('.c-label.is-error').should('exist')
  })
  it("Cas compliqué : arrondissement de grande ville", function () {
    // given
    cy.visit('/address_questions/new')
    cy.get('input#search').clear()
    cy.get('input#search').first().type("75017")
    cy.get('li.autocomplete-item').should("exist")
    cy.get('li.autocomplete-item').first().click()
    // when
    cy.get('input[value="Continuer"]').click()
    // then
    cy.location('pathname').should('not.contain', 'address_questions')
    // then
    cy.get('input#val_spectacle').click()
    cy.get('input[value="Continuer"]').click()
    // given
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/filter_questions/new')})
    cy.get('input[value="Continuer"]').click()
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/aides')})
    // then
    cy.get(".c-situation--address").shouldHaveTrimmedText("75017 Paris")
  })

})

describe("Pour un visiteur", function () {


  it("Quand on arrive sur la page principale, on peut démarrer le formulaire", function () {
    // given
    cy.visit('/')
    // when
    cy.get('.c-main-cta').click()
    // then
    cy.location().should((loc) => { expect(loc.pathname).contains('question') })
  })

  describe("Quand on arrive sur la question inscription", function () {

    before(function () {
      cy.visit('/inscription_questions/new')
    })

    it("Aucun radiobutton coché", function () {
      cy.get('input[type="radio"]').should('not.be.checked')
      // aucun radiobutton coché
    })

    it("focus sur le premier radiobutton ", function () {
      cy.get('input[type="radio"]').first().should('have.focus')
    })

    it("Absence d'erreur lorqu'on arrive sur la page", function () {
      cy.get('.c-label.is-error').should('not.exist')
      // Absence d'erreur
    })

    it("Erreur si on ne coche rien ", function () {
      // when
      cy.get('input[value="Continuer"]').click()
      // then
      cy.get('.c-label.is-error').should('exist')
    })

    it("Cas nominal : on coche une case et on valide, ", function () {
      // given
      cy.visit('/inscription_questions/new')
      cy.get('input[type="radio"]').first().check()
      // when
      cy.get('input[value="Continuer"]').click()
      // then
      cy.location('pathname').should('not.contain', 'inscription_questions')
    })

    it("On peut revenir à l'écran précédent", function () {
      // given
      cy.visit('/inscription_questions/new')
      // when
      cy.get('input[value="Revenir"]').click()
      // then
      cy.location('pathname').should('not.contain', 'inscription_questions')
    })
  })
})


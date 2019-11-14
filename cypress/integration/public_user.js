describe("Pour un visiteur", function () {


  it("Quand on arrive sur la page principale, on peut démarrer le formulaire", function () {
    // given
    cy.visit('/')
    // when
    cy.get('.c-main-cta').click()
    // then
    cy.location().should((loc) => {expect(loc.pathname).contains('question')})
  })

  describe("Quand on arrive sur la question inscription", function () {

    it("Aucun radiobutton coché", function () {
      // given
      // when
      cy.visit('/inscription_questions/new')
      // then
      // aucun radiobutton coché
    })

    it("focus sur le premier radiobutton ", function () {
      // given
      // when
      cy.visit('/inscription_questions/new')
      // then
      // focus sur le premier radiobutton
    })


    it("Quand on arrive sur la question inscription, ", function () {
      // given
      // when
      cy.visit('/inscription_questions/new')
      // then
      // pas d'erreur .c-error-in-form length === 0
    })

    it("Quand on arrive sur la question inscription, ", function () {
      // given
      // when
      cy.visit('/inscription_questions/new')
      // then
      // pas d'erreur .c-error-in-form length === 0
    })

    it("Cas nominal : on coche une case et on valide, ", function () {
      // given
      cy.visit('/inscription_questions/new')
      // coche une case
      // when
      // on valide
      // then
      // l'URL a changé
    })

    it("On peut revenir à l'écran précédent", function () {
      // given
      cy.visit('/inscription_questions/new')
      // when
      // on clique sur le bouton revenir
      // then
      // on revient à la home
    })

  })

  



        // it("Il existe un champ de recherche d'aide", function () {
        //     cy.get('input[placeholder*="Rechercher"]').should('exist')
        // })
        // it("Il existe un lien vers Pôle Emploi", function () {
        //     cy.get('a[href="https://www.pole-emploi.fr/"]').should('exist')
        // })
        // it("Il existe un lien vers la page principale", function () {
        //     cy.get('a[href="/"]').should('exist')
        // })
        // it("Il existe un bouton vers la modale de video", function () {
        //     cy.get('button[data-modal-content-id="modal_video"]').should('exist')
        // })
        // it("Il existe un CTA vers le wizard de recherche d'aides", function () {
        //     cy.get('form[action="/welcome/start_wizard"] > input[]value="Je commence"]').should('exist')
        // })
        // it("Il existe un deuxième CTA vers le wizard de recherche d'aides", function () {
        //     cy.get('a[href="/inscription_questions/new"]').should('exist')
        // })
        // it("Il existe un bouton pour accepter les cookies", function () {
        //     cy.get('input.c-cookies-button').should('exist')
        // })

    // describe("Affichage du formulaire", function () {
    //     before(function () {
    //         cy.visit('/inscription_questions/new')
    //     })
    //     it("Montrer des boutons radios", function () {
    //         cy.get('input[type="radio"]').should('exist')
    //     })
    //     it("Repondre aux questions au hasard", function () {
    //         while (cy.get('input[value="Continuer"]').its('length') > 0) {
    //             cy.make_random_choice()
    //             cy.Submit_wizard_choice()
    //             cy.wait(500)
    //         }
    //         cy.wait(500)
    //         cy.wait(500)
    //         cy.location('pathname').should('include', '/aides?for_id')
    //     })
    // })
})


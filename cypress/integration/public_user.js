describe("Pour un visiteur", function () {


    describe("Quand on arrive sur la page principale", function () {
        before(function () {
            cy.visit('/')
        })
        it("Il existe un champ de recherche d'aide", function () {
            cy.get('input[placeholder*="Rechercher"]').should('exist')
        })
        it("Il existe un lien vers Pôle Emploi", function () {
            cy.get('a[href="https://www.pole-emploi.fr/"]').should('exist')
        })
        it("Il existe un lien vers la page principale", function () {
            cy.get('a[href="/"]').should('exist')
        })
        it("Il existe un bouton vers la modale de video", function () {
            cy.get('button[data-modal-content-id="modal_video"]').should('exist')
        })
        it("Il existe un CTA vers le wizard de recherche d'aides", function () {
            cy.get('form[action="/welcome/start_wizard"] > input[]value="Je commence"]').should('exist')
        })
        it("Il existe un deuxième CTA vers le wizard de recherche d'aides", function () {
            cy.get('a[href="/inscription_questions/new"]').should('exist')
        })
        it("Il existe un bouton pour accepter les cookies", function () {
            cy.get('input.c-cookies-button').should('exist')
        })
    })

    describe("Affichage du formulaire", function () {
        before(function () {
            cy.visit('/inscription_questions/new')
        })
        it("Montrer des boutons radios", function () {
            cy.get('input[type="radio"]').should('exist')
        })
        it("Repondre aux questions au hasard", function () {
            while (cy.get('input[value="Continuer"]').size() > 0) {
                cy.make_random_choice()
                cy.Submit_wizard_choice()
            }
            cy.location('pathname').should('include', '/aides?for_id')
        })
    })
})


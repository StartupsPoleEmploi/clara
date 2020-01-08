describe("Réinitialisation du mot de passe", function() {

  before(function() {
    cy.connect_as_contributeur2()
    cy.disconnect_from_admin()
    cy.visit('/sign_in')
  })

  it("On peut demander à réinitialiser son mot de passe", function() {
    cy.get('a#forgot_link').click()
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/passwords/new')})
  })

  it("Par défaut l'email n'est pas renseigné", function() {
    cy.get('input#password_email').should('have.value', '')
    cy.get('input#password_email').click()
  })

  it("Si on renseigne l'email et qu'on soumet le formulaire, un message s'affiche comme quoi un email de rénitialisation a bien été envoyé", function() {
    cy.get('input#password_email').first().type("contributeur2@clara.com")
    cy.get('input[value="Suivant"]').click()
    cy.location().should((loc) => {expect(loc.pathname).to.eq('/passwords')})
    cy.get('.c-login-card h1').first().should('have.text', 'Consultez vos emails !')
  })

  it("Si on clique sur le lien dans l'email, on accède à la page de réinitialisation", function() {
    cy.visit('/letter_opener')
    cy.get('iframe#mail').then(function ($iframe) {
      const $body = $iframe.contents().find('body')

      cy.wrap($body)
        .find('iframe[seamless="seamless"]')
        .then(function ($iframe2) {
          const $body2 = $iframe2.contents().find('body')

          cy.wrap($body2)
            .find('a#change_password_please').first().invoke('attr', 'href')
            .then(href => {
              cy.visit(href)
            });
        })
    })
  })

  it("Par défaut le mot de passe n'est pas renseigné", function() {
    cy.get('input#password_reset_password').should('have.value', '')
  })
  it("Un mot de passe ne peut être vide", function() {
    cy.get('input#password_reset_password').click()
    cy.get('input[value="Enregistrer"]').click()
    cy.get('#flash_notice').shouldHaveTrimmedText("✖ Le mot de passe ne peut être vide.");
  })
  it("Un mot de passe ne peut avoir moins de 8 caractères", function() {
    cy.get('input#password_reset_password').clear()
    cy.get('input#password_reset_password').type("Conur2+")
    cy.get('input#password_reset_password').click()
    cy.get('input[value="Enregistrer"]').click()
    cy.get('#flash_notice').shouldHaveTrimmedText("✖ Le mot de passe doit avoir au moins 8 caractères.");
  })
  it("Un mot de passe doit avoir un caractère spécial au moins", function() {
    cy.get('input#password_reset_password').clear()
    cy.get('input#password_reset_password').type("Contributeur2")
    cy.get('input#password_reset_password').click()
    cy.get('input[value="Enregistrer"]').click()
    cy.get('#flash_notice').shouldHaveTrimmedText("✖ Le mot de passe doit avoir au moins un caractère spécial.");
  })
  it("Un mot de passe doit avoir un chiffre au moins", function() {
    cy.get('input#password_reset_password').clear()
    cy.get('input#password_reset_password').type("Contributeur+")
    cy.get('input#password_reset_password').click()
    cy.get('input[value="Enregistrer"]').click()
    cy.get('#flash_notice').shouldHaveTrimmedText("✖ Le mot de passe doit avoir au moins un chiffre.");
  })
  it("Un mot de passe doit avoir une majuscule au moins", function() {
    cy.get('input#password_reset_password').clear()
    cy.get('input#password_reset_password').type("contributeur2+")
    cy.get('input#password_reset_password').click()
    cy.get('input[value="Enregistrer"]').click()
    cy.get('#flash_notice').shouldHaveTrimmedText("✖ Le mot de passe doit avoir au moins une majuscule.");
  })
  it("Un mot de passe correct est accepté", function() {
    cy.get('input#password_reset_password').first().type("Contributeur2+")
    cy.get('input[value="Enregistrer"]').click()
    cy.get('body[data-path="admin_aids_path"]').should('exist')
  })

})


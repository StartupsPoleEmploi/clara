context("PEconnect", () => {

  before(() => {
    cy.connect_as_superadmin()
  })
  beforeEach(() => {
    Cypress.Cookies.preserveOnce('clara', 'remember_token')
  })
  after(() => {
    cy.clearCookie('clara')
    cy.clearCookie('remember_token')
  })

  describe("Sur la home on démarre directement le formulaire", () => {

    before(() => {
      cy.visit('/')
    })

    it("Je clique sur démarrer sur la home, le formulaire simple démarre", function() {
      cy.get('#start_wizard_form1').click()
      cy.get('#start-clara-peconnect').should('not.be.visible')
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/inscription_questions/new')})
    })
  })


  describe("Activation du PEConnect en admin", () => {

    before(() => {
      cy.visit('/admin/get_switch_peconnect')
    })

    it("On peut activer/désactiver le PEConnect", function() {
      cy.get('.peconnect-status').eq(0).contains('Pe connect est actuellement désactivé')
      cy.get('input#submit-toggle-peconnect').click()
      cy.get('.peconnect-status').eq(0).contains('Pe connect est actuellement activé')
    })

  })

  describe("Sur la home on essaye d'atteindre PE connect quand il est activé", () => {

    before(() => {
      cy.visit('/')
    })

    it("Sur la modale de démarrage on atteint PEConnect", function() {
      cy.get('#start_wizard_form1').click()
      cy.get('#start-clara-peconnect').click()
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/connexion/oauth2/authorize')})

    })

  })

  describe("Une fois connecté à PEConnect, un petit résumé est visible", () => {

    before(() => {
      cy.visit('/peconnect_callback?fake=1')
    })

    it("Le résumé donne les information", function() {
      cy.get('.c-callback-userinfo').eq(1).find('span').eq(0).contains('Age :')
      cy.get('.c-callback-userinfo').eq(1).find('span').eq(1).contains('38')
    })

    it("Si l'utilisateur valide il arrive sur la page de résultats", function() {
      cy.wait(750)
      cy.get('button#c-callback-submit2').click()
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/aides')})
    })

  })

  describe("Désactivation du PEConnect en admin", () => {

    before(() => {
      cy.visit('/admin/get_switch_peconnect')
    })

    it("On peut activer/désactiver le PEConnect", function() {
      cy.get('.peconnect-status').eq(0).contains('Pe connect est actuellement activé')
      cy.get('input#submit-toggle-peconnect').click()
      cy.get('.peconnect-status').eq(0).contains('Pe connect est actuellement désactivé')
    })

  })


})

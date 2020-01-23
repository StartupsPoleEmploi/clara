Cypress.on('window:before:load', (win) => {
  // because this is called before any scripts
  // have loaded - the ga function is undefined
  // so we need to create it.
  win.ga = cy.stub().as('ga')
})

describe('Google Analytics', function () {

  it('Google analytics peut être bloqué', function () {
    cy.forbid_google_analytics()

    cy
    .get('@ga')
    .should('not.be.calledWith', 'create', 'UA-99713524-3')

  })
  it('Google analytics peut être autorisé', function () {
    cy.authorize_google_analytics()

    cy
    .get('@ga')
    .should('be.calledWith', 'create', 'UA-99713524-3')
    .and('be.calledWith', 'set', 'dimension1', 'true')
    .and('be.calledWith', 'send', 'pageview')
    .and('be.calledWith', 'set', 'location', '/')

    // now click the anchor tag which causes a hashchange event
    cy.get('.c-main-cta').click()
    cy.location().should((loc) => { expect(loc.pathname).contains('question') })

    // make sure GA was sent this pageview
    cy
    .get('@ga')
    .should('be.calledWith', 'create', 'UA-99713524-3')
    .and('be.calledWith', 'set', 'dimension1', 'true')
    .and('be.calledWith', 'send', 'pageview')
    .and('be.calledWith', 'set', 'location', '/inscription_questions/new')

  })
})

describe('Hotjar', function () {

  const HOTJAR_POLL = '#_hjRemoteVarsFrame'

  it('Hotjar peut être bloqué', function () {
    cy.forbid_hotjar()

    cy.visit("http://localhost:3000/aides?for_id=LDQsbywsNixuLG4sMzIwMTMsbm90X2FwcGxpY2FibGUsbg==")
    cy.get("body.c-body.aides.index").should("exist")

    cy.get(HOTJAR_POLL).should("not.exist")

  })
  it('Hotjar peut être autorisé', function () {
    cy.authorize_hotjar()

    cy.visit("http://localhost:3000/aides?for_id=LDQsbywsNixuLG4sMzIwMTMsbm90X2FwcGxpY2FibGUsbg==")
    cy.get("body.c-body.aides.index").should("exist")

    cy.get(HOTJAR_POLL).should("exist")
  })
})

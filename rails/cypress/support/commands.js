// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add("login", (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add("drag", { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add("dismiss", { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This will overwrite an existing command --
// Cypress.Commands.overwrite("visit", (originalFn, url, options) => { ... })

Cypress.Commands.overwrite('log', (subject, message) => cy.task('log', message));

Cypress.Commands.add('connect_as_superadmin', () => {
  cy.request('POST', '/session', { email: 'superadmin@clara.com', password: 'bar', remember_me: '0' })
});

Cypress.Commands.add('connect_and_remember_as_superadmin', () => {
  cy.request('POST', '/session', { email: 'superadmin@clara.com', password: 'bar', remember_me: '1' })
});

Cypress.Commands.add('connect_as_contributeur', () => {
  cy.request('POST', '/session', { email: 'contributeur1@clara.com', password: 'contributeur1' })
});

Cypress.Commands.add('connect_as_relecteur', () => {
  cy.request('POST', '/session', { email: 'relecteur1@clara.com', password: 'relecteur1' })
});


Cypress.Commands.add(
  'selectNth',
  { prevSubject: 'element' },
  (subject, pos) => {
    cy.wrap(subject)
      .children('option')
      .eq(pos)
      .then(e => {
        cy.wrap(subject).select(e.val())
      })
  }
)

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
  cy.visit('/sign_in')
  cy.get('#session_email').clear().invoke('val', 'superadmin@clara.com').trigger('input');
  cy.get('#session_password').clear().invoke('val', 'bar').trigger('input');
  cy.get('.c-login-connect input').click()
  cy.location('pathname').should('include', '/admin')
  cy.get('body').should('have.attr', 'data-path', 'admin_aids_path')
});

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
// -- This is will overwrite an existing command --
// Cypress.Commands.overwrite("visit", (originalFn, url, options) => { ... })

Cypress.Commands.add('create_old_aid', (aid_name) => {
  cy.visit('/admin/aids/new')
  cy.get('input#aid_name').type(aid_name)
  cy.get('select#aid_contract_type_id').select('Aide à la mobilité')
  cy.get('input#aid_ordre_affichage').type('42')
  cy.get('input#modify-aid').click()
  cy.location().should((loc) => { expect(loc.pathname).not.to.eq('/admin/aids/new') })
});

Cypress.Commands.add('connect_as_contributeur1', () => {
  cy.visit('/sign_in')
  cy.get('#session_email')
    .type('contributeur1@clara.com').should('have.value', 'contributeur1@clara.com')
  cy.get('#session_password')
    .type('contributeur1').should('have.value', 'contributeur1')
  cy.get('.c-login-connect input').click()
  cy.location('pathname').should('include', '/admin')
  cy.get('body').should('have.attr', 'data-path', 'admin_aids_path')
});

Cypress.Commands.add('connect_as_relecteur1', () => {
  cy.visit('/sign_in')
  cy.get('#session_email')
    .type('relecteur1@clara.com').should('have.value', 'relecteur1@clara.com')
  cy.get('#session_password')
    .type('relecteur1').should('have.value', 'relecteur1')
  cy.get('.c-login-connect input').click()
  cy.location('pathname').should('include', '/admin')
  cy.get('body').should('have.attr', 'data-path', 'admin_aids_path')
});

Cypress.Commands.add('connect_as_contributeur2', () => {
  cy.visit('/sign_in')
  cy.get('#session_email')
    .type('contributeur2@clara.com').should('have.value', 'contributeur2@clara.com')
  cy.get('#session_password')
    .type('contributeur2').should('have.value', 'contributeur2')
  cy.get('.c-login-connect input').click()
  cy.location('pathname').should('include', '/admin')
  cy.get('body').should('have.attr', 'data-path', 'admin_aids_path')
});

Cypress.Commands.add('connect_as_superadmin', () => {
  cy.visit('/sign_in')
  cy.get('#session_email')
    .type('superadmin@clara.com').should('have.value', 'superadmin@clara.com')
  cy.get('#session_password')
    .type('bar').should('have.value', 'bar')
  cy.get('.c-login-connect input').click()
  cy.location('pathname').should('include', '/admin')
  cy.get('body').should('have.attr', 'data-path', 'admin_aids_path')
});

Cypress.Commands.add('disconnect_from_admin', () => {
  cy.get('.js-sign-out').click()
});

Cypress.Commands.add('create_a_user', (email, password) => {
  cy.visit('/sign_up?locale=fr&text=contributeur')
  cy.get('#user_email')
    .type(email).should('have.value', email)
  cy.get('#user_password')
    .type(password).should('have.value', password)
  cy.get('.c-login-connect input').click()
  cy.location('pathname').should('include', 'admin/users')
});

Cypress.Commands.add('delete_a_user', (email) => {
  cy.connect_as_superadmin()
  cy.visit('/admin/users?locale=fr')
  cy.get('a.js-user-deletion[data-email="' + email + '"]').click()
  cy.location('pathname').should('include', 'admin/users')
  cy.disconnect_from_admin()
});

Cypress.Commands.add('delete_an_aid', (aid_slug) => {
  cy.connect_as_superadmin()
  cy.visit('/admin/aids')
  cy.get('a.js-delete-aid[href="/admin/aids/' + aid_slug + '?locale=fr"]').click()
  cy.disconnect_from_admin()
});

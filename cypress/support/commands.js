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
Cypress.Commands.add('connect_as_simple_admin', () => { 
    cy.visit('/sign_in')
    cy.get('#session_email')
      .type('admin@clara.com').should('have.value', 'admin@clara.com')
    cy.get('#session_password')
      .type('foo').should('have.value', 'foo')
    cy.get('.c-login-connect input').click()
    cy.location('pathname').should('include', '/admin')
    cy.get('body').should('have.attr', 'data-path', 'admin_aids_path')
 });
Cypress.Commands.add('stage_3_has_all_fields', () => { 
    cy.get('#label_tab_3').click()
    cy.get('#tab_3 .field-unit').should('have.length', 4)
    cy.get('#tab_3 .field-unit .field-unit__label label').eq(0).should('have.text', "Résumé")
    cy.get('#tab_3 .field-unit .field-unit__label label').eq(1).should('have.text', "Filtres sur la page de résultat")
    cy.get('#tab_3 .field-unit .field-unit__label label').eq(2).should('have.text', "Filtres personnalisés")
    cy.get('#tab_3 .field-unit .field-unit__label label').eq(3).should('have.text', "Filtres par besoins")
 });
Cypress.Commands.add('stage_3_has_few_fields', () => { 
    cy.get('#label_tab_3').click()
    cy.get('#tab_3 .field-unit').should('have.length', 2)
    cy.get('#tab_3 .field-unit .field-unit__label label').first().should('have.text', "Résumé")
    cy.get('#tab_3 .field-unit .field-unit__label label').last().should('have.text', "Filtres sur la page de résultat")
 });
Cypress.Commands.add('connect_as_super_admin', () => { 
    cy.visit('/sign_in')
    cy.get('#session_email')
      .type('superadmin@clara.com').should('have.value', 'superadmin@clara.com')
    cy.get('#session_password')
      .type('foo').should('have.value', 'foo')
    cy.get('.c-login-connect input').click()
    cy.location('pathname').should('include', '/admin')
    cy.get('body').should('have.attr', 'data-path', 'admin_aids_path')
 });
Cypress.Commands.add('disconnect_from_admin', () => { 
    cy.get('.js-sign-out').click()
 });

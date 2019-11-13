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

Cypress.Commands.add('make_a_random_choice', () => {
  if (cy.get('input[type="radio"]').size() > 0) {
    cy.check_random_radio_button()
  }
  else if (cy.get('input[name="age_form[number_of_years]"]').size() > 0) {
    cy.enter_random_age()
  }
  else if (cy.get('input[name="address_form[label]"]').size() > 0) {
    cy.enter_random_post_code()
  }
  else if (cy.get('input[type="checkbox"]').size() > 0) {
    cy.check_random_checkbox()
  }
});

Cypress.Commands.add('check_random_radio_button', () => {
  var random_radio_box = Math.floor(Math.random() * cy.get('input[type="radio"]').size());
  cy.get('input[type="radio"]').eq(random_radio_box).check()
});
Cypress.Commands.add('check_random_checkbox', () => {
  var random_checkbox = Math.floor(Math.random() * cy.get('input[type="checkbox"]').size());
  cy.get('input[type="radio"]').eq(random_checkbox).check()
});
Cypress.Commands.add('enter_random_age', () => {
  var random_age = Math.floor(Math.random() * 100) + 18
  cy.get('input[name="age_form[number_of_years]"]').type(random_age)
});
Cypress.Commands.add('enter_random_post_code', () => {
  var random_post_code = 44200 // Math.floor(Math.random() * 20000)
  cy.get('input[name="address_form[label]"]').type(random_post_code)
  cy.get('li.autocomplete-item').click()
});
Cypress.Commands.add('Submit_wizard_choice', () => {
  cy.get('input[value="Continuer"]').click()
});
Cypress.Commands.add('go_back_wizard', () => {
  cy.get('input[value="Revenir"]').click()
});

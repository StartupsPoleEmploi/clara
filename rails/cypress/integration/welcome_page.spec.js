/// <reference types="cypress" />

context('Welcome page', () => {

  beforeEach(() => {
    cy.visit('/')
  })

  describe('Title section', () => {

    it('should contain a welcome message', () => {
      cy.get('.c-title').contains('Hello')
    })

  })

})

describe("Voir une aide", function() {

  describe("Pour un contributeur", function() {
    before(function() {
      // given
      cy.connect_as_contributeur1()
      // when
      cy.visit('/admin/aids/erasmus')

    })

    it("Pour un contributeur, la rubrique n'est pas cliquable", function() {
      // then
      const $contract_type_elt = Cypress.$("#contract_type").next().children()
      expect($contract_type_elt.prop("tagName")).to.equal("DIV")
    })  
  })

  describe("Pour un superadmin", function() {
    before(function() {
      // given
      cy.connect_as_superadmin()
      // when
      cy.visit('/admin/aids/erasmus')

    })

    it("Pour un contributeur, la rubrique est cliquable", function() {
      // then
      const $contract_type_elt = Cypress.$("#contract_type").next().children()
      expect($contract_type_elt.prop("tagName")).to.equal("A")
    })  
  })


})


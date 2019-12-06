describe("Pour un contributeur", function () {


  const YES_FAIL = {failOnStatusCode: false}
  const SEL = "body header h1"

  before(function () {
    cy.connect_as_contributeur1()
  })

  function yes_for(url) {
    cy.visit('/admin/aids', YES_FAIL).then(() => { cy.get(SEL).then($el => { expect($el.text()).not.includes("Error");});})
  }


  describe("Accès aux aides", function () {
    it("OUI pour /admin/aids", function () {
      yes_for("/admin/aids")
    })
    it("Accès à /admin/custom_filters : non", function () {
      cy.visit('/admin/custom_filters', YES_FAIL).then(() => { cy.get(SEL).then($el => { expect($el.text()).includes("Error");});})
      // cy.visit('/admin/custom_filters', YES_FAIL).then(() => { cy.get(SEL).then($el => { expect($el.text()).not.includes("Error");});})
    })
  })

})


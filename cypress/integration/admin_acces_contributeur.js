describe("Pour un contributeur", function () {


  const POSSIBLY_FAIL = {failOnStatusCode: false}
  const SEL = "body header h1"

  before(function () {
    cy.connect_as_contributeur1()
  })

  function yes_for(url) {
    cy.visit(url, POSSIBLY_FAIL).then(() => { 
      cy.get(SEL).then($el => {
        expect($el.text()).not.includes("Error");
      });
    })
  }

  function no_for(url) {
    cy.visit(url, POSSIBLY_FAIL).then(() => { 
      cy.get(SEL).then($el => {
        expect($el.text()).includes("Error");
      });
    })
  }


  describe("URLs autorisées", function () {
    let urls = [
                "/admin/aids", 
                "/admin/aids/erasmus",
                "/admin/aids/erasmus/edit",
                "/admin/aids/new",
                ]
    urls.forEach(function(url) {
      it("OUI pour " + url, function () {
        yes_for(url)
      })
    })
  })

  describe("URLs non-autorisées", function () {
    let urls = [
                "/admin/custom_filters", 
                "/admin/custom_filters/new",
                ]
    urls.forEach(function(url) {
      it("NON pour " + url, function () {
        no_for(url)
      })
    })
  })

  // describe("URL NON-autorisées", function () {
  //   it("Accès à /admin/custom_filters : non", function () {
  //     no_for("/admin/custom_filters")
  //   })
  // })

})


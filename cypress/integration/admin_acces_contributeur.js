describe("Pour un contributeur", function () {


  const POSSIBLY_FAIL = {failOnStatusCode: false}
  const ERROR_MSG = "Exception caught"

  before(function () {
    cy.connect_as_contributeur1()
  })

  function yes_for(url) {
    cy.visit(url, POSSIBLY_FAIL).then(() => { 
      cy.title().should('not.include', ERROR_MSG)
    })
  }

  function no_for(url) {
    cy.visit(url, POSSIBLY_FAIL).then(() => { 
      cy.title().should('include', ERROR_MSG)
    })
  }


  // TODO : manque la plupart des edit, delete, post
  describe("URLs autorisées", function () {
    let urls = [
                  "/admin/aids", 
                  "/admin/get_hidden_admin", 
                  "/admin/conventions/1", 
                  "/admin/get_cache", 
                  "/apidocs", 
               ]
    urls.forEach(function(url) {
      it("Accès AUTORISÉ pour " + url, function () {
        yes_for(url)
      })
    })
  })

  // TODO : manque la plupart des edit, delete, post
  describe("URLs non-autorisées", function () {
    let urls = [
                  "/sign_up", 
                  "/admin/tracings", 
                  "/admin/traces", 
                  "/admin/users", 
                  "/admin/api_users", 
                  "/admin/rules", 
                  "/admin/contract_types",
                  "/admin/custom_filters", 
                  "/admin/filters", 
                  "/admin/need_filters", 
                  "/admin/axle_filters", 
                  "/admin/domain_filters", 
                  "/admin/aids/erasmus/edit", 
                  "/admin/aids/new", 
                  "/admin/variables", 
                  "/admin/explicitations", 
               ]
    urls.forEach(function(url) {
      it("Accès INTERDIT pour " + url, function () {
        no_for(url)
      })
    })
  })

})


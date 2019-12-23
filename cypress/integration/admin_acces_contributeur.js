describe("Liste des accès", function () {
  const POSSIBLE_URLS = [
    "/admin/aids",
    "/admin/get_hidden_admin",
    "/admin/conventions/1",
    "/admin/get_cache",
    "/apidocs",
    "/sign_up",
    "/admin/conventions/new",
    "/admin/conventions/1/edit",
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

  const POSSIBLY_FAIL = {failOnStatusCode: false}
  const ERROR_MSG = "Exception caught"

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

  describe("Pour un contributeur", function () {

    before(function () {
      cy.connect_as_contributeur1()
    })

    let authorizeds = [
      "/admin/aids", 
      "/admin/get_hidden_admin",
      "/admin/conventions/1",
      "/admin/get_cache",
      "/apidocs"]


    if (!Cypress._.every(authorizeds, function(authorized){return POSSIBLE_URLS.includes(authorized)})) {
      throw {msg: "authorizeds URL must be a POSSIBLE_URL"}
    }

    // TODO : manque la plupart des edit, delete, post
    describe("URLs autorisées", function () {

      let urls = Cypress._.filter(POSSIBLE_URLS, function(e) { return authorizeds.includes(e); })
      urls.forEach(function(url) {
        it("Accès AUTORISÉ pour " + url, function () {
          yes_for(url)
        })
      })
    })

    // TODO : manque la plupart des edit, delete, post
    describe("URLs non-autorisées", function () {
      let urls = Cypress._.filter(POSSIBLE_URLS, function(e) {return !authorizeds.includes(e);})
      urls.forEach(function(url) {
        it("Accès INTERDIT pour " + url, function () {
          no_for(url)
        })
      })
    })

  })

  describe("Pour un relecteur", function () {

    before(function () {
      cy.connect_as_relecteur1()
    })

    let authorizeds = [
      "/admin/aids", 
      "/admin/get_hidden_admin",
      "/admin/conventions/1",
      "/admin/get_cache",
      "/apidocs",
      "/sign_up",
      "/admin/users",
      "/admin/api_users",
      "/admin/conventions/1/edit",
      ]


    if (!Cypress._.every(authorizeds, function(authorized){return POSSIBLE_URLS.includes(authorized)})) {
      throw {msg: "authorizeds URL must be a POSSIBLE_URL"}
    }

    // TODO : manque la plupart des edit, delete, post
    describe("URLs autorisées", function () {

      let urls = Cypress._.filter(POSSIBLE_URLS, function(e) { return authorizeds.includes(e); })
      urls.forEach(function(url) {
        it("Accès AUTORISÉ pour " + url, function () {
          yes_for(url)
        })
      })
    })

    // TODO : manque la plupart des edit, delete, post
    describe("URLs non-autorisées", function () {
      let urls = Cypress._.filter(POSSIBLE_URLS, function(e) {return !authorizeds.includes(e);})
      urls.forEach(function(url) {
        it("Accès INTERDIT pour " + url, function () {
          no_for(url)
        })
      })
    })

  })

})


describe("Liste des accès", function () {
  const POSSIBLE_URLS = [
    "/admin/aids",
    "/admin/aids/erasmus/edit",
    "/admin/aids/new",
    "/admin/get_hidden_admin",
    "/admin/conventions/1",
    "/admin/get_cache",
    "/admin/rule_checks",
    "/apidocs",
    "/sign_up",
    "/admin/conventions/new",
    "/admin/conventions/1/edit",
    "/admin/tracings",
    "/admin/traces",
    "/admin/users",
    "/admin/api_users",
    "/admin/custom_filters",
    "/admin/custom_filters/partenaire",
    "/admin/custom_filters/partenaire/edit",
    "/admin/custom_filters/new",
    "/admin/custom_parent_filters",
    "/admin/custom_parent_filters/prestataire",
    "/admin/custom_parent_filters/prestataire/edit",
    "/admin/custom_parent_filters/new",
    "/admin/filters",
    "/admin/need_filters",
    "/admin/axle_filters",
    "/admin/domain_filters",
    "/admin/variables",
    "/admin/variables/new",
    "/admin/variables/1",
    "/admin/variables/1/edit",
    "/admin/explicitations",
    "/admin/explicitations/new",
    "/admin/explicitations/e_v_age_equal_",
    "/admin/explicitations/e_v_age_equal_/edit",
    "/admin/rules",
    "/admin/rules/new?rule_kind=composite",
    "/admin/rules/new?rule_kind=simple",
    "/admin/rules/362",
    "/admin/rules/362/edit",
    "/admin/contract_types",
    "/admin/contract_types/new",
    "/admin/contract_types/aide-a-la-mobilite",
    "/admin/contract_types/aide-a-la-mobilite/edit",
    "/admin/get_zrr",
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

  function check_authorized_urls(authorizeds) {
    if (!Cypress._.every(authorizeds, function(authorized){return POSSIBLE_URLS.includes(authorized)})) {
      throw {msg: "authorizeds URL must be a POSSIBLE_URL"}
    }
    return authorizeds
  }

  describe("Pour un superadmin", function () {

    before(function () {
      cy.connect_as_superadmin()
    })

    let unauthorizeds = check_authorized_urls([
      "/admin/aids/erasmus/edit",
      "/admin/aids/new",
    ])

    describe("URLs autorisées", function () {

      let urls = Cypress._.filter(POSSIBLE_URLS, function(e) { return !unauthorizeds.includes(e); })
      urls.forEach(function(url) {
        it("Accès AUTORISÉ pour " + url, function () {
          yes_for(url)
        })
      })
    })

    describe("URLs non-autorisées", function () {
      let urls = Cypress._.filter(POSSIBLE_URLS, function(e) {return unauthorizeds.includes(e);})
      urls.forEach(function(url) {
        it("Accès INTERDIT pour " + url, function () {
          no_for(url)
        })
      })
    })

  })


  describe("Pour un contributeur", function () {

    before(function () {
      cy.connect_as_contributeur1()
    })

    let authorizeds = check_authorized_urls([
      "/admin/aids", 
      "/admin/get_hidden_admin",
      "/admin/conventions/1",
      "/admin/get_cache",
      "/apidocs"])

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

    let authorizeds = check_authorized_urls([
      "/admin/aids", 
      "/admin/get_hidden_admin",
      "/admin/conventions/1",
      "/admin/get_cache",
      "/apidocs",
      "/sign_up",
      "/admin/users",
      "/admin/api_users",
      "/admin/conventions/1/edit",
      ])

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

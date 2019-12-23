describe("Pour un contributeur", function () {


  const POSSIBLY_FAIL = {failOnStatusCode: false}
  const ERROR_MSG = "Exception caught"


  const POSSIBLE_URLS = [
    {url_value: "/admin/aids",                access_authorized: true},
    {url_value: "/admin/get_hidden_admin",    access_authorized: true},
    {url_value: "/admin/conventions/1",       access_authorized: true},
    {url_value: "/admin/get_cache",           access_authorized: true},
    {url_value: "/apidocs",                   access_authorized: true},
    {url_value: "/sign_up",                   access_authorized: false},
    {url_value: "/admin/conventions/new",     access_authorized: false},
    {url_value: "/admin/conventions/1/edit",  access_authorized: false},
    {url_value: "/admin/tracings",            access_authorized: false},
    {url_value: "/admin/traces",              access_authorized: false},
    {url_value: "/admin/users",               access_authorized: false},
    {url_value: "/admin/api_users",           access_authorized: false},
    {url_value: "/admin/rules",               access_authorized: false},
    {url_value: "/admin/contract_types",      access_authorized: false},
    {url_value: "/admin/custom_filters",      access_authorized: false},
    {url_value: "/admin/filters",             access_authorized: false},
    {url_value: "/admin/need_filters",        access_authorized: false},
    {url_value: "/admin/axle_filters",        access_authorized: false},
    {url_value: "/admin/domain_filters",      access_authorized: false},
    {url_value: "/admin/aids/erasmus/edit",   access_authorized: false},
    {url_value: "/admin/aids/new",            access_authorized: false},
    {url_value: "/admin/variables",           access_authorized: false},
    {url_value: "/admin/explicitations",      access_authorized: false},
  ]

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

    let urls = Cypress._.chain(POSSIBLE_URLS)
      .filter(function(e) {return e.access_authorized === true})
      .map(function(e) {return e.url_value})
      .value()

    urls.forEach(function(url) {
      it("Accès AUTORISÉ pour " + url, function () {
        yes_for(url)
      })
    })
  })

  // TODO : manque la plupart des edit, delete, post
  describe("URLs non-autorisées", function () {
    let urls = Cypress._.chain(POSSIBLE_URLS)
      .filter(function(e) {return e.access_authorized === false})
      .map(function(e) {return e.url_value})
      .value()
    urls.forEach(function(url) {
      it("Accès INTERDIT pour " + url, function () {
        no_for(url)
      })
    })
  })

})


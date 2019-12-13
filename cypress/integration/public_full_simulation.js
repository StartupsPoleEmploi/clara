describe("Pour un visiteur", function () {

  const AMOB_SPECTACLE = '[data-aslug="aide-a-la-mobilite-professionnelle-des-artistes-et-technicien-ne-s-du-spectacle"]'

  it("Quand on arrive sur la page principale, on peut démarrer le formulaire", function () {
    // given
    cy.visit('/')
    // when
    cy.get('.c-main-cta').click()
    // then
    cy.location().should((loc) => { expect(loc.pathname).contains('question') })
  })

  it("On peut remplir toutes les questions, on arrive sur l'écran de résultat", function () {

    // given
    cy.get('#moins_d_un_an').should("exist")
    cy.get('#moins_d_un_an').click()
    cy.get('.js-next').click()

    cy.get('#cat_12345').should("exist")
    cy.get('#cat_12345').click()
    cy.get('.js-next').click()

    cy.get('#radio_ARE_ASP').should("exist")
    cy.get('#radio_ARE_ASP').click()
    cy.get('.js-next').click()

    cy.get('#montant').should("exist")
    cy.get('#montant').type("842")
    cy.get('.js-next').click()

    cy.get('#age').should("exist")
    cy.get('#age').type("16")
    cy.get('.js-next').click()
    
    cy.get('#niveau_4').should("exist")
    cy.get('#niveau_4').click()
    cy.get('.js-next').click()
    
    cy.get('#search').should("exist")
    cy.get('#search').type("49490")
    cy.get('li.autocomplete-item').should("exist")
    cy.get('li.autocomplete-item').first().click()
    cy.get('.js-next').click()
    
    cy.get('#val_spectacle').should("exist")
    cy.get('#val_spectacle').click()

    //when
    cy.get('.js-next').click()

    //then 
    cy.get("body.c-body.aides").should("exist")

  })
  it("Sur l'écran de résultat, il y a un récapitulatif", function () {
    //then 
    cy.get(".c-situation--age").shouldHaveTrimmedText("16")
    cy.get(".c-situation--grade").shouldHaveTrimmedText("Bac")
    cy.get(".c-situation--address").shouldHaveTrimmedText("49490 Noyant-Villages")
    cy.get(".c-situation--zrr").shouldHaveTrimmedText("indisponible")
    cy.get(".c-situation--inscription").shouldHaveTrimmedText("moins d'un an")
    cy.get(".c-situation--category").shouldHaveTrimmedText("12345")
    cy.get(".c-situation--allocation-montant").shouldHaveTrimmedText("842")
    cy.get(".c-situation--spectacle").shouldHaveTrimmedText("oui")
    cy.get(".c-situation--handicap").shouldHaveTrimmedText("non")
    cy.get(".c-situation--cadre").shouldHaveTrimmedText("non")
  })
  it("Sur l'écran de résultat il y a au moins les aides éligibles", function () {
    //then 
    cy.get('.c-resultcard--green').its('length').should('be.gt', 0)
  })
  it("Une aide peut passer d'éligible à inéligible si on change un paramètre", function () {
    // given
    const CHECKED_AID = ".c-resultaid.is-ineligible" + AMOB_SPECTACLE
    cy.get(".js-open").first().click()
    cy.get(CHECKED_AID).should("not.exist")
    cy.get(".js-recap-zone").click()
    cy.get("a.js-modify-other").click()
    // when
    cy.get("#none").click()
    cy.get('.js-next').click()
    // then
    cy.get("body.c-body.aides").should("exist")
    cy.get(".js-toggle-ineligies").first().click()
    cy.get(".js-ineligibles-zone .js-open").first().click()
    cy.get(CHECKED_AID).should("exist")
    
  })
  it("Sur l'écran de résultat on peut déplier une rubrique", function () {
    //then 
    cy.get('.c-btn.js-open').first().click()
  })
  it("Sur l'écran de résultat cliquer sur \"En savoir plus\" pour connaître le détail d'une aide", function () {
    // when
    cy.get('.c-btn--aid').first().click()
    // then
    cy.get("body.c-body.detail.show").should("exist")
  })
  it("On peut accéder directement à l'écran de résultat, par URL", function () {
    //when (reinit cache)
    cy.visit("/")
    cy.get("body.c-body.welcome.index").should("exist")
    //then 
    cy.visit("http://localhost:3000/aides?for_id=LDQsbywsNixuLG4sMzIwMTMsbm90X2FwcGxpY2FibGUsbg==")
    cy.get("body.c-body.aides").should("exist")
  })
  it("Il peut y avoir des réultats éligibles, incertains et inéligibles", function () {
    cy.get('.c-resultcard--red').its('length').should('be.gt', 0)
    cy.get('.c-resultcard--orange').its('length').should('be.gt', 0)
    cy.get('.c-resultcard--green').its('length').should('be.gt', 0)
  })
  describe("On peut filtrer les résultats", function () {
    const HIDDEN_ELTS = ".c-resultcard.u-hidden-visually"
    const VISIBLE_TAGS = '.c-resultfilter[data-name="travailler-a-l-international"]:visible'
    before(function () {
      //given
      cy.get(HIDDEN_ELTS).should('not.exist')
      cy.get(VISIBLE_TAGS).should('not.exist')
      //when
      cy.get('#check_2').click()
    })
    it("Certains résultats sont cachés", function(){
      //then
      cy.get(HIDDEN_ELTS).should('exist')
    })
    it("Les petites étiquettes apparaissent", function(){
      //when
      cy.get(".js-toggle-ineligies").first().click()
      //then
      cy.get(VISIBLE_TAGS).should('exist')
    })

  })

})


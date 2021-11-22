context('Simple visiteur : Parcours de la question inscription', () => {


  before(() => {
    cy.request('/cypress_rails_reset_state')
  })

  describe("Pour un visiteur qui accède la question inscription", () => {

    beforeEach(() => {
      cy.visit('/inscription_questions/new')
    })
    it("Cas d'erreur", () => {
      //Given
      cy.get('.c-label.is-error').should("not.exist")
      cy.get('#moins_d_un_an').should("exist")
      //When
      cy.get('.js-next').click()
      //Then
      cy.get('.c-label.is-error').should("exist")
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/inscription_questions/new')})
    })
    it("Cas de retour", () => {
      //When
      cy.get('.c-back-question').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/inscription_questions/new')})
    })
    it("Cas nominal", () => {
      //When
      cy.get('#moins_d_un_an').should("exist")
      cy.get('#moins_d_un_an').click()
      cy.get('.js-next').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/inscription_questions/new')})
    })

  })

  describe("Pour un visiteur qui accède la question categorie", () => {

    beforeEach(() => {
      cy.visit('/category_questions/new')
    })
    it("Cas d'erreur", () => {
      //Given
      cy.get('.c-label.is-error').should("not.exist")
      cy.get('#cat_12345').should("exist")
      //When
      cy.get('.js-next').click()
      //Then
      cy.get('.c-label.is-error').should("exist")
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/category_questions/new')})
    })
    it("Cas de retour", () => {
      //When
      cy.get('.c-back-question').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/category_questions/new')})
    })
    it("Cas nominal", () => {
      //When
      cy.get('#cat_12345').should("exist")
      cy.get('#cat_12345').click()
      cy.get('.js-next').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/category_questions/new')})
    })

  })

  describe("Pour un visiteur qui accède la question ARE", () => {

    beforeEach(() => {
      cy.visit('/are_questions/new')
    })
    it("Cas nominal", () => {
      //When
      cy.get('#montant').should("exist")
      cy.get('#montant').type("842")
      cy.get('.js-next').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/are_questions/new')})
    })

  })

  describe("Pour un visiteur qui accède la question du montant", () => {

    beforeEach(() => {
      cy.visit('/are_questions/new')
    })
    it("Cas nominal", () => {
      //When
      cy.get('#montant').should("exist")
      cy.get('#montant').type("842")
      cy.get('.js-next').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/are_questions/new')})
    })

  })

  describe("Pour un visiteur qui accède la question age", () => {

    beforeEach(() => {
      cy.visit('/age_questions/new')
    })
    it("Cas nominal", () => {
      //When
      cy.get('#age').should("exist")
      cy.get('#age').type("26")
      cy.get('.js-next').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/age_questions/new')})
    })
  })

  describe("Pour un visiteur qui accède la question diplome", () => {

    beforeEach(() => {
      cy.visit('/grade_questions/new')
    })
    it("Cas nominal", () => {
      //When
      cy.get('#niveau_4').should("exist")
      cy.get('#niveau_4').click()
      cy.get('.js-next').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/grade_questions/new')})
    })

  })

  describe("Pour un visiteur qui accède la question adresse", () => {

    beforeEach(() => {
      cy.visit('/address_questions/new')
    })
    it("Cas nominal", () => {
      //When
      cy.get('#search').should("exist")
      cy.get('#search').type("49490")
      cy.get('li.autocomplete-item').should("exist")
      cy.get('li.autocomplete-item').first().click()
      cy.get('.js-next').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/address_questions/new')})
    })

  })

  describe("Pour un visiteur qui accède la question autres", () => {
    beforeEach(() => {
      cy.visit('/other_questions/new')
    })
    it("Cas d'erreur", () => {
      //Given
      cy.get('.c-label.is-error').should("not.exist")
      cy.get('#val_spectacle').should("exist")
      //When
      cy.get('.js-next').click()
      //Then
      cy.get('.c-label.is-error').should("exist")
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/other_questions/new')})
    })
    it("Cas de retour", () => {
      //When
      cy.get('.c-back-question').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/other_questions/new')})
    })
    it("Cas nominal", () => {
      //When
      cy.get('#val_spectacle').should("exist")
      cy.get('#val_spectacle').click()
      cy.get('.js-next').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).not.to.eq('/other_questions/new')})
    })
  })

  describe("Pour un visiteur qui accède aux filtres", () => {
    before(() => {
      cy.visit('/filter_questions/new')
    })
    it("Cas nominal", () => {
      //When
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/filter_questions/new')})
      cy.get('.js-next').should("exist")
      cy.get('.js-next').click()
      //Then
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/aides')})
    })
    it("Voir toutes les réponse et accéder au détail", () => {
      cy.get('.c-btn--result').eq(0).click()
      cy.get('.c-btn--aid').eq(0).click()
      cy.location().should((loc) => {expect(loc.pathname).to.eq('/aides/detail/aide-test-mobilite')})
    })
  })


})

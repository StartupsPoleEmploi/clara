describe("Utiliser l'API", function() {

  const ANSWER_SEL = "td.col.response-col_description div h5"
  const ANSWER_SEL_HEADER = "td.col.response-col_description span"
  const EXEC_SEL = "button.btn.execute"
  const TRY_SEL = "button.try-out__btn"
  const INPUT_JWT_SEL = 'input[placeholder="Authorization - Bearer [your JWT token here]"]'

  let reusable_jwt_token;

  function first_steps(cy) {
    cy.get(TRY_SEL).first().click()
    cy.get(EXEC_SEL).should("exist")
  }

  function fire(cy) {
    cy.get(EXEC_SEL).click()
    cy.get(ANSWER_SEL).first().should("exist")
  }

  function authenticate(cy) {
    cy.get(INPUT_JWT_SEL)
      .clear()
      .invoke('val', reusable_jwt_token)
      .trigger('input')
    cy.get(INPUT_JWT_SEL).click()
    cy.get(INPUT_JWT_SEL).type(" ")
    cy.get("a.tablinks").first().click()
  }
  
  function badly_authenticate(cy) {
    cy.get(INPUT_JWT_SEL)
      .clear()
      .invoke('val', 'wrong_auth')
      .trigger('input')
    cy.get(INPUT_JWT_SEL).click()
    cy.get(INPUT_JWT_SEL).type(" ")
    cy.get("a.tablinks").first().click()
  }

  function actual_answer(cy) {
    cy.get(ANSWER_SEL).first().siblings().invoke('text')
  }

  describe("Un simple ping", function () {
    before(function () {
      // given
      cy.visit('/apidocs#/ping/getPing')
    })
    it("Doit répondre ok", function () {
      // when
      first_steps(cy)
      fire(cy)
      cy.get(ANSWER_SEL).first().siblings().invoke('text').should(
        (txt) => {expect(txt.replace(/[\s\n\r]+/g, '')).to.eq('{"status":"ok"}')}
      )
    })
  })
  describe("Authentification", function () {
    before(function () {
      // given
      cy.visit('/apidocs#/user/api_user_token')
    })
    it("Doit renvoyer un token JWT de longueur 140", function () {
      first_steps(cy)
      cy.get(".body-param__text").click()
      cy.get('.body-param__text').clear().invoke('val', '{"auth":\n {\n   "email": "foo@bar.com",\n   "password": "Zecret+237"\n}\n}\n').trigger('input')
      cy.get(".body-param__text").click()
      cy.get(".body-param__text").type(" ")
      cy.get("a.tablinks").first().click()
      fire(cy)
      cy.get(ANSWER_SEL).first().siblings().invoke('text').then(
        (txt) => {
          let answer = txt.replace(/[\s\n\r]+/g, '')
          let almost_jwt = answer.split(":")[1]
          let jwt = almost_jwt.substring(0, almost_jwt.length - 2).substr(1);
          reusable_jwt_token = jwt
          expect(reusable_jwt_token).to.have.length(140)
        }
      )
    })
  })

  // console.log(txt.replace(/[\s\n\r]+/g, ''));
  describe("La liste des aides éligibles", function () {
    beforeEach(function () {
      // given
      cy.visit('apidocs#/aids/getEligibleAids')
    })
    it("Doit renvoyer les données d'entrée, suivi des aides éligibles", function () {
      // when
      first_steps(cy)
      authenticate(cy)
      cy.get('input[placeholder="age - Age of asker"]')
        .clear()
        .invoke('val', '2')
        .trigger('input')
      cy.get('input[placeholder="age - Age of asker"]').click()
      cy.get('input[placeholder="age - Age of asker"]').type("2")
      cy.get("a.tablinks").first().click()
      fire(cy)
      cy.get(ANSWER_SEL).first().siblings().invoke('text').should(
        (txt) => {expect(txt.replace(/[\s\n\r]+/g, '').indexOf('{"input":{"asker":{"age":"22"}},"aids":[{')).to.eq(0)}
      )
    })
    it("Doit renvoyer une 401 si mal authentifié", function () {
      // when
      first_steps(cy)
      badly_authenticate(cy)
      fire(cy)
      cy.get(ANSWER_SEL_HEADER).first().invoke('text').should(
        (txt) => {expect(txt.indexOf('Error: Unauthorized')).to.eq(0)}
      )
    })
  })

  // console.log(txt.replace(/[\s\n\r]+/g, ''));
  describe("La liste des aides inéligibles", function () {
    beforeEach(function () {
      // given
      cy.visit('apidocs#/aids/getIneligibleAids')
    })
    it("Doit renvoyer les données d'entrée, suivi des aides inéligibles", function () {
      // when
      first_steps(cy)
      authenticate(cy)
      cy.get('input[placeholder="age - Age of asker"]')
        .clear()
        .invoke('val', '1')
        .trigger('input')
      cy.get('input[placeholder="age - Age of asker"]').click()
      cy.get('input[placeholder="age - Age of asker"]').type("7")
      cy.get("a.tablinks").first().click()
      fire(cy)
      cy.get(ANSWER_SEL).first().siblings().invoke('text').should(
        (txt) => {expect(txt.replace(/[\s\n\r]+/g, '').indexOf('{"input":{"asker":{"age":"17"}},"aids":[{')).to.eq(0)}
      )
    })
    it("Doit renvoyer une 401 si mal authentifié", function () {
      // when
      first_steps(cy)
      badly_authenticate(cy)
      fire(cy)
      cy.get(ANSWER_SEL_HEADER).first().invoke('text').should(
        (txt) => {expect(txt.indexOf('Error: Unauthorized')).to.eq(0)}
      )
    })
  })

  describe("La liste des aides incertaines", function () {
    before(function () {
      // given
      cy.visit('apidocs#/aids/getUncertainAids')
    })
    it("Doit renvoyer les données d'entrée, suivi des aides incertaines", function () {
      // when
      first_steps(cy)
      authenticate(cy)
      fire(cy)
      cy.get(ANSWER_SEL).first().siblings().invoke('text').should(
        (txt) => {expect(txt.replace(/[\s\n\r]+/g, '').indexOf('{"input":{"asker":{}},"aids":[{')).to.eq(0)}
      )
    })
  })

  describe("La liste des filtres, correctement authentifié", function () {
    beforeEach(function () {
      // given
      cy.visit('/apidocs#/filters/getNeedFilters')
    })
    it("Doit renvoyer la liste des filtres de l'écran de résultats", function () {
      // when
      first_steps(cy)
      authenticate(cy)
      fire(cy)
      cy.get(ANSWER_SEL).first().siblings().invoke('text').should(
        (txt) => {expect(txt.replace(/[\s\n\r]+/g, '').indexOf('{"need_filters":[')).to.eq(0)}
      )
    })
    it("Doit renvoyer une 401 si mal authentifié", function () {
      // when
      first_steps(cy)
      badly_authenticate(cy)
      fire(cy)
      cy.get(ANSWER_SEL_HEADER).first().invoke('text').should(
        (txt) => {expect(txt.indexOf('Error: Unauthorized')).to.eq(0)}
      )
    })
  })

  describe("La liste des filtres par besoin", function () {
    beforeEach(function () {
      // given
      cy.visit('/apidocs#/filters/getNeedFilters')
    })
    it("Doit renvoyer la liste des filtres par besoin", function () {
      // when
      first_steps(cy)
      authenticate(cy)
      fire(cy)
      cy.get(ANSWER_SEL).first().siblings().invoke('text').should(
        (txt) => {expect(txt.replace(/[\s\n\r]+/g, '').indexOf('{"need_filters":[')).to.eq(0)}
      )
    })
    it("Doit renvoyer une 401 si mal authentifié", function () {
      // when
      first_steps(cy)
      badly_authenticate(cy)
      fire(cy)
      cy.get(ANSWER_SEL_HEADER).first().invoke('text').should(
        (txt) => {expect(txt.indexOf('Error: Unauthorized')).to.eq(0)}
      )
    })
  })

  describe("Le détail d'une aide", function () {
    beforeEach(function () {
      // given
      cy.visit('/apidocs#/aids/getAidDetail')
    })
    it("Doit renvoyer le détail d'une aide", function () {
      // when
      first_steps(cy)
      authenticate(cy)
      cy.get('input[placeholder="aidSlug - Slug of aid"]')
        .clear()
        .invoke('val', 'erasmu')
        .trigger('input')
      cy.get('input[placeholder="aidSlug - Slug of aid"]').click()
      cy.get('input[placeholder="aidSlug - Slug of aid"]').type("s")
      cy.get("a.tablinks").first().click()
      fire(cy)
      cy.get(ANSWER_SEL).first().siblings().invoke('text').should(
        (txt) => {expect(txt.replace(/[\s\n\r]+/g, '').indexOf('{"aid":{"name":"Erasmus+"')).to.eq(0)}
      )
    })
    it("Doit renvoyer une 401 si mal authentifié", function () {
      // when
      first_steps(cy)
      badly_authenticate(cy)
      cy.get('input[placeholder="aidSlug - Slug of aid"]')
        .clear()
        .invoke('val', 'erasmu')
        .trigger('input')
      cy.get('input[placeholder="aidSlug - Slug of aid"]').click()
      cy.get('input[placeholder="aidSlug - Slug of aid"]').type("s")
      cy.get("a.tablinks").first().click()
      fire(cy)
      cy.get(ANSWER_SEL_HEADER).first().invoke('text').should(
        (txt) => {expect(txt.indexOf('Error: Unauthorized')).to.eq(0)}
      )
    })
  })

})


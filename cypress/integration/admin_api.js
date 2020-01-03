describe("Utiliser l'API", function() {

  const ANSWER_SEL = "td.col.response-col_description div h5"
  const EXEC_SEL = "button.btn.execute"
  const TRY_SEL = "button.try-out__btn"

  let reusable_jwt_token;

  function first_steps(cy) {
    cy.get(TRY_SEL).click()
    cy.get(EXEC_SEL).should("exist")
  }

  function fire(cy) {
    cy.get(EXEC_SEL).click()
    cy.get(ANSWER_SEL).first().should("exist")
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
    it("Doit répondre ok", function () {
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
        }
      )
    })
  })



})


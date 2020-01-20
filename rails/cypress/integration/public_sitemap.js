describe("En tant que simple visiteur", function () {

  it("Je peux visiter le sitemap", function () {
    cy.request('/sitemap.xml').then((response) => {
      expect(response.status).to.eq(200)
      const xml = Cypress.$.parseXML(response.body)
      const sitemapindex = xml.getElementsByTagName('sitemapindex')
      expect(Cypress.$(sitemapindex).find("sitemap>loc").first().text()).to.eq("http://localhost:3000/aides-sitemap.xml")
      expect(Cypress.$(sitemapindex).find("sitemap>loc").last().text()).to.eq("http://localhost:3000/types-aides-sitemap.xml")
    })
  })

  it("Je peux visiter le sitemap des aides", function () {
    cy.request('/aides-sitemap.xml').then((response) => {
      expect(response.status).to.eq(200)
      const xml = Cypress.$.parseXML(response.body)
      const urlset = xml.getElementsByTagName('urlset')
      expect(Cypress.$(urlset).find("url>loc").last().text().indexOf("/aides/detail/")).to.be.greaterThan(0)
    })
  })

  it("Je peux visiter le sitemap des types d'aides", function () {
    cy.request('/types-aides-sitemap.xml').then((response) => {
      expect(response.status).to.eq(200)
      const xml = Cypress.$.parseXML(response.body)
      const urlset = xml.getElementsByTagName('urlset')
      expect(Cypress.$(urlset).find("url>loc").last().text().indexOf("/aides/type/")).to.be.greaterThan(0)
    })
  })

})


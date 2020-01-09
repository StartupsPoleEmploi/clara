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

})


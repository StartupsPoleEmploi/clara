class SitemapController < ApplicationController

  layout nil

  def index
    headers['Content-Type'] = 'application/xml'
  end

  def aides
    headers['Content-Type'] = 'application/xml'
    respond_to do |format|
      format.xml {@aids = Aid.activated.map{|e| e.attributes}}
    end
  end

  def types
    headers['Content-Type'] = 'application/xml'
    respond_to do |format|
      format.xml {@types = ContractType.all.map{|e| e.attributes}}
    end
  end

end

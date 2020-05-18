class ReqController < ApplicationController

  def index
    res = request.headers.env.reject { |key| key.to_s.include?('.') }
    res["RUBY_VERSION"] = RUBY_VERSION
    res["RAILS_VERSION"] = Rails.version
    hydrate_view(
      res
      )
  end

end

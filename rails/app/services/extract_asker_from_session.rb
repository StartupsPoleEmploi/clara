class ExtractAskerFromSession

  def call(context)
    Asker.new(JSON.parse(context.session[:asker].to_s))
  end

end

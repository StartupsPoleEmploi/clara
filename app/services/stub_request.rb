class StubRequest < ClaraService
  initialize_with_keywords :a_request

  is_callable

  def call
    a_request
  end

end

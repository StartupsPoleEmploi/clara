class GetPaginationSearchNumberService < ClaraService

  is_callable

  # Number of items per page
  def call
    20
  end

end

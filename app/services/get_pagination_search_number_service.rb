class GetPaginationSearchNumberService < ClaraService

  is_callable

  # Number of items per page
  def call
    5
  end

end

class GetPreviousAreValue
  
  def call(are)
    are.minimum_income == "not_applicable" ? "" : are.minimum_income
  end

end

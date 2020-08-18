class GetPreviousGradeForm
  
  def call(previous_value)
    GradeForm.new(value: previous_value)
  end

end

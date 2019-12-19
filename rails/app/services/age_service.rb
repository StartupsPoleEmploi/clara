class AgeService

  def upload(age, asker)
    asker.v_age = age.number_of_years
  end

  def new_and_download(asker)
    @age = AgeForm.new
    @age.number_of_years = asker.v_age
    @age
  end

end

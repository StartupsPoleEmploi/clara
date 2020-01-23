class NewAidStep < ViewObject


  def initialize(context, args = {})
    @context = context
    after_init(args)
  end


  def disability
    @aid_status == "Publiée" ? 'disabled=disabled' : ''
  end

  def action_displayed
    @aid_status == "Publiée" ? "Publier les modifications" : "Continuer"
  end

end

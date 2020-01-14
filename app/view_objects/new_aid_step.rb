class NewAidStep < ViewObject

  def disability
    @aid_status == "Publiée" ? 'disabled=disabled' : ''
  end

  def action_displayed
    @aid_status == "Publiée" ? "Publier les modification" : "Continuer"
  end

end

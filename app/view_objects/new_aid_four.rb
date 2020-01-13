class NewAidFour < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @aid = locals[:page].resource
    @aid_status = locals[:aid_status]
  end

  def action_displayed
    @aid_status == "Publiée" ? "Publier les modification" : "Continuer"
  end

end

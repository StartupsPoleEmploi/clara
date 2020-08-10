class ClearanceFindByUserAndToken

  def call(params, user_param, token)
    Clearance.configuration.user_model.find_by_id_and_confirmation_token params[user_param], token.to_s
  end

end

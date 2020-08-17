class PasswordComplexEnough
  
  def call(password)
    
    message = ""
    if password.blank?
      message = "Le mot de passe ne peut être vide."
    elsif password.size < 8
      message = "Le mot de passe doit avoir au moins 8 caractères."
    elsif !password.match(/[a-z]/)
      message = "Le mot de passe doit avoir au moins une minuscule."
    elsif !password.match(/[A-Z]/)
      message = "Le mot de passe doit avoir au moins une majuscule."
    elsif !password.match(/\d/)
      message = "Le mot de passe doit avoir au moins un chiffre."
    elsif !password.match(/\W/)
      message = "Le mot de passe doit avoir au moins un caractère spécial."
    end
    message

  end

end

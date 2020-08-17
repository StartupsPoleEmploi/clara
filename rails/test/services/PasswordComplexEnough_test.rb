require "test_helper"

class PasswordComplexEnoughTest < ActiveSupport::TestCase

  test ".call refuses empty password" do
    #given
    #when
    res = PasswordComplexEnough.new.call("")
    #then
    assert_equal("Le mot de passe ne peut être vide.", res)
  end
  test ".call refuses too short password" do
    #given
    #when
    res = PasswordComplexEnough.new.call("abc")
    #then
    assert_equal("Le mot de passe doit avoir au moins 8 caractères.", res)
  end
  test ".call refuses lack of uppercase" do
    #given
    #when
    res = PasswordComplexEnough.new.call("ABCDEFGHIJKL")
    #then
    assert_equal("Le mot de passe doit avoir au moins une minuscule.", res)
  end
  test ".call refuses lack of lowercase" do
    #given
    #when
    res = PasswordComplexEnough.new.call("abcdefghijkl")
    #then
    assert_equal("Le mot de passe doit avoir au moins une majuscule.", res)
  end
  test ".call refuses lack of number" do
    #given
    #when
    res = PasswordComplexEnough.new.call("ABCDEfghijkl")
    #then
    assert_equal("Le mot de passe doit avoir au moins un chiffre.", res)
  end
  test ".call refuses lack of special char" do
    #given
    #when
    res = PasswordComplexEnough.new.call("ABCDEfghijkl23")
    #then
    assert_equal("Le mot de passe doit avoir au moins un caractère spécial.", res)
  end

end

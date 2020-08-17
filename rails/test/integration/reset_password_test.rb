require 'test_helper'

class ResetPasswordTest < ActionDispatch::IntegrationTest

  test "reset password : fail if empty" do
    user = User.create(email: "superadmin@clara.com", password: "bar", role: "superadmin")
    allow_any_instance_of(ClearanceFindByUserAndToken).to receive(:call).and_return(user)
    put user_password_url(user.id), params: { password_reset: { password: '' }}
    assert text_of('.c-flash-error').include?("Le mot de passe ne peut être vide")
  end

end

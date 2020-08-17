require 'test_helper'

class ResetPasswordTest < ActionDispatch::IntegrationTest

  test "connect to session : refused if unexisting user" do
    post session_url, params: { session: { email: 'fake@email.com', password: 'any' }}
    assert_response :unauthorized
  end

  test "connect to session : accepted if existing user" do
    user = User.create(email: "superadmin@clara.com", password: "bar", role: "superadmin")
    post session_url, params: { session: { email: user.email, password: user.password }}
    assert_response :found
  end

  test "reset password : fail if empty" do
    user = User.create(email: "superadmin@clara.com", password: "bar", role: "superadmin")
    allow_any_instance_of(ClearanceFindByUserAndToken).to receive(:call).and_return(user)
    put user_password_url(user.id), params: { password_reset: { password: '' }}
    assert text_of('.c-flash-error').include?("Le mot de passe ne peut être vide")
  end

  test "reset password : fail if less than 8 characters" do
    user = User.create(email: "superadmin@clara.com", password: "bar", role: "superadmin")
    allow_any_instance_of(ClearanceFindByUserAndToken).to receive(:call).and_return(user)
    put user_password_url(user.id), params: { password_reset: { password: 'short' }}
    assert text_of('.c-flash-error').include?("Le mot de passe doit avoir au moins 8 caractères")
  end

  test "reset password : fail if only 1 special char" do
    user = User.create(email: "superadmin@clara.com", password: "bar", role: "superadmin")
    allow_any_instance_of(ClearanceFindByUserAndToken).to receive(:call).and_return(user)
    put user_password_url(user.id), params: { password_reset: { password: 'Abcdefgh2' }}
    assert text_of('.c-flash-error').include?("Le mot de passe doit avoir au moins un caractère spécial")
  end

  test "reset password : fail if only 1 special char" do
    user = User.create(email: "superadmin@clara.com", password: "bar", role: "superadmin")
    allow_any_instance_of(ClearanceFindByUserAndToken).to receive(:call).and_return(user)
    put user_password_url(user.id), params: { password_reset: { password: 'Abcdefgh2' }}
    assert text_of('.c-flash-error').include?("Le mot de passe doit avoir au moins un caractère spécial")
  end

end

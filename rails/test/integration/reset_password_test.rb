require 'test_helper'

class ResetPasswordTest < ActionDispatch::IntegrationTest

  test "reset password : fail if empty" do
    #given
    user = User.create(email: "superadmin@clara.com", password: "bar", role: "superadmin")
    allow_any_instance_of(ClearanceFindByUserAndToken).to receive(:call).and_return(user)
    #when
    put user_password_url(user.id), params: { password_reset: { password: '' }}
    #then
    assert text_of('.c-flash-error').include?("Le mot de passe ne peut être vide")
  end

  test "create password : deliver email if forgotten" do
    #given
    user = User.create(email: "superadmin@clara.com", password: "bar", role: "superadmin")

    #See https://stackoverflow.com/a/32127013/2595513
    mail = double
    expect(mail).to receive(:deliver_later).with(no_args)
    expect(CustomClearanceMailer).to receive(:change_password)
      .with('superadmin@clara.com', URI::regexp(%w(http https)))
      .and_return(mail)

    #when
    post user_password_url(user.id), params: { password: { email: 'superadmin@clara.com' }}
    #then
    # expect(email).to receive(:deliver_later).with(no_args)
    assert text_of('h1').include?("Consultez vos emails !")
  end

  test "reset password : an admin can display a screen where changing password is possible" do
    #given
    #when
    get new_custom_password_path
    #then
    assert text_of('h1').include?("Récupérer votre mot de passe")
  end

  test "edit password : an admin can ask to change its password" do
    #given
    user = User.create(email: "superadmin@clara.com", password: "bar", role: "superadmin")
    allow_any_instance_of(ClearanceFindByUserAndToken).to receive(:call).and_return(user)
    #when
    get edit_user_password_url(user.id)
    #then
    assert text_of('h1').include?("Nouveau mot de passe")
  end

  test "edit password : an admin can notice that password was changed" do
    #given
    user = User.create(email: "superadmin@clara.com", password: "bar", role: "superadmin")
    allow_any_instance_of(ClearanceFindByUserAndToken).to receive(:call).and_return(user)
    #when
    get edit_user_password_url(user.id) + '?token=22'
    #then
    assert_redirected_to edit_user_password_url
  end

end

Clearance.configure do |config|
  config.routes = false
  config.mailer_sender = ENV["ARA_EMAIL_FROM"] 
  config.rotate_csrf_on_sign_in = true
  config.redirect_url = "/admin"
  config.cookie_expiration = ->(cookies) do
    if !!cookies[:remember_me]
      1.year.from_now
    else
      nil
    end
  end
end

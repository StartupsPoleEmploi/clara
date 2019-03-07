Clearance.configure do |config|
  config.routes = false
  config.mailer_sender = ENV["ARA_EMAIL_FROM"] 
  config.rotate_csrf_on_sign_in = true
  config.redirect_url = "/admin"
end

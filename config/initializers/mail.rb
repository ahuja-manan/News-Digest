MANDRILL_API_KEY = "lXc9c2DPlKq4Lyy0H1H02g"

ActionMailer::Base.smtp_settings = {
  :address   => "smtp.mandrillapp.com",
  :port      => 587,
  :enable_starttls_auto => true, 
  :user_name => "mananahuja14@gmail.com",
  :password  => MANDRILL_API_KEY,
  :authentication => "login"
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: "utf-8"
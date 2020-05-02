if Rails.env.production?
  ActionMailer::Base.smtp_settings = {
    :user_name => Rails.application.credentials.sendgrid[:user_name],
    :password => Rails.application.credentials.sendgrid[:password],
    :domain => 'wadokaichin.games',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
  }
end
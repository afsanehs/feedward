# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => "a9a78429-093c-4423-ab83-65f7f190c5a1",
  :password => "a9a78429-093c-4423-ab83-65f7f190c5a1",
  :address => 'smtp.postmarkapp.com',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

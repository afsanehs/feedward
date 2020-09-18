# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV["POSTMARK_KEY"],
  :password => ENV["POSTMARK_KEY"],
  :address => 'smtp.postmarkapp.com',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

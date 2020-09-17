class UserMailer < ApplicationMailer
  #Don't forget to change the mail
  default from: 'getfeedward@outlook.fr'
  
  def welcome_email(user)
    @user = user 
    @url  = "http://#{ENV["DOMAIN_NAME"]}" || 'http://localhost:3000'
    mail(to: @user.email, subject: 'Bienvenue sur Feedward !') 
  end
end

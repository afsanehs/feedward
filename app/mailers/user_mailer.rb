class UserMailer < ApplicationMailer
  #Don't forget to change the mail
  default from: 'chaton-maton@outlook.fr'
  
  def welcome_email(user)
    @user = user 
    @url  = 'http://monsite.fr/login' 
    mail(to: @user.email, subject: 'Bienvenue sur Feedward !') 
  end
end

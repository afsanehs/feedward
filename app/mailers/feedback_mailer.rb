class FeedbackMailer < ApplicationMailer
  #Don't forget to change the mail
  default from: 'chaton-maton@outlook.fr'
  
  def new_feedback_user(user)
    @user = user 
    @url  = 'http://monsite.fr/login' 
    mail(to: @user.email, subject: 'Thanks for your feedabck !') 
  end

  def new_feedback_admin
    mail(to: "yanis@feedward.com", subject: 'A new feedward had been created') 
  end
end

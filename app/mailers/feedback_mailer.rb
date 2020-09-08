class FeedbackMailer < ApplicationMailer
  #Don't forget to change the mail
  default from: 'chaton-maton@outlook.fr'
  
  def new_feedback_user(user)
    @user = user 
    @url  = 'http://monsite.fr/login' 
    mail(to: @user.email, subject: 'Merci pour ton feedabck') 
  end

  def new_feedback_admin
    mail(to: "yanis@feedward.com", subject: 'Un nouveau feedback a été crée') 
  end
end

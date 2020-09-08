class FeedbackMailer < ApplicationMailer
  #Don't forget to change the mail
  default from: 'chaton-maton@outlook.fr'
  
  def new_feedback_user(user)
    @user = user 
    @url  = 'http://monsite.fr/login' 
    mail(to: @user.email, subject: 'Merci pour ton feedback') 
  end

  def new_feedback_admin
    @admin_email = "yanis@feedward.com"
    mail(to:  @admin_email, subject: 'Un nouveau feedback a été crée') 
  end
end

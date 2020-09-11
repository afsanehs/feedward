class FeedbackMailer < ApplicationMailer
  #Don't forget to change the mail
  default from: 'getfeedward@outlook.fr'
  
  def new_feedback_user(user)
    @user = user 
    @url  = 'http://getfeedward.com' 
    mail(to: @user.email, subject: 'Merci pour ton feedback') 
  end

  def new_feedback_admin
    @admin_email = "getfeedward@outlook.fr"
    mail(to:  @admin_email, subject: 'Un nouveau feedback a été crée') 
  end
end

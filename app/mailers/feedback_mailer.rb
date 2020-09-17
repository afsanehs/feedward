class FeedbackMailer < ApplicationMailer
  #Don't forget to change the mail
  default from: 'getfeedward@outlook.fr'
  
  def new_feedback_user(user)
    @user = user 
    @url  = "http://#{ENV["DOMAIN_NAME"]}" || 'http://localhost:3000'
    mail(to: @user.email, subject: 'Merci pour ton feedback') 
  end

  def new_feedback_admin
    @admin_email = "getfeedward@outlook.fr"
    mail(to:  @admin_email, subject: 'Un nouveau feedback a été crée') 
  end

  def new_feedback_receiver(receiver)
    @receiver = receiver
    @url  = "http://#{ENV["DOMAIN_NAME"]}" || 'http://localhost:3000'
    mail(to:  @receiver.email, subject: 'Tu viens de recevoir un feedback') 
  end

end

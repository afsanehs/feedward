class FeedbackMailer < ApplicationMailer
  #Don't forget to change the mail
  default from: 'b00685318@essec.edu'
  
  def new_feedback_user(user)
    @user = user 
    @url  = "http://#{ENV["DOMAIN_NAME"]}" || 'http://localhost:3000'
    mail(to: @user.email, subject: 'Merci pour ton feedback') 
  end

  def new_feedback_receiver(receiver)
    @receiver = receiver
    @url  = "http://#{ENV["DOMAIN_NAME"]}" || 'http://localhost:3000'
    mail(to:  @receiver.email, subject: 'Tu viens de recevoir un feedback') 
  end

end

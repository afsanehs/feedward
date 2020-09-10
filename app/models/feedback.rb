class Feedback < ApplicationRecord
  belongs_to :sender, class_name: "User" #the sender is the one who has fulfilled the feedback
  belongs_to :receiver, class_name: "User" #a feedback can be sent by the sender to a specific receiver

  after_create :new_feedback_mail

  validates :score_global,
    presence:true,
    inclusion: { in:(1..5), message: "%{value} is not valid" }
  validates :score_workspace, presence:true
  validates :score_missions, presence:true

  validates :answer_global, length: { minimum: 20 }
  validates :answer_workspace, length: { minimum: 20 }
  validates :answer_missions, length: { minimum: 20 }
  validates :answer_final, length: { minimum: 20 }

  def new_feedback_mail
    if !self.sender.nil?
      FeedbackMailer.new_feedback_user(self.sender).deliver_now
    end
    FeedbackMailer.new_feedback_admin.deliver_now
  end
end

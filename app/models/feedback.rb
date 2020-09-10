class Feedback < ApplicationRecord
  belongs_to :sender, class_name: "User" #the sender is the one who has fulfilled the feedback
  belongs_to :receiver, class_name: "User", optional: true #a feedback can be sent by the sender to a specific receiver

  after_create :new_feedback_mail
  before_validation :convert_to_integer

  validates :score_global,
    presence:true,
    inclusion: { in:(0..5), message: "%{value} is not valid" }
  validates :score_workspace, presence:true, inclusion: { in:(0..5), message: "%{value} is not valid" }
  validates :score_missions, presence:true, inclusion: { in:(0..5), message: "%{value} is not valid" }

  validates :answer_global, presence: {message: ": Le commentaire est obligatoire pour les notes inférieures à 3."}, unless: -> { self.score_global >= 3}
  validates :answer_workspace,presence: {message: ": Le commentaire est obligatoire pour les notes inférieures à 3."}, unless: -> { self.score_workspace >= 3}
  validates :answer_missions, presence: {message: ": Le commentaire est obligatoire pour les notes inférieures à 3."}, unless: -> { self.score_missions >= 3}


  def new_feedback_mail
    if !self.sender.nil?
      FeedbackMailer.new_feedback_user(self.sender).deliver_now
    end
    FeedbackMailer.new_feedback_admin.deliver_now
  end



  private
  def convert_to_integer
    self.score_global = self.score_global.to_i
    self.score_workspace = self.score_workspace.to_i
    self.score_missions = self.score_missions.to_i
  end
end

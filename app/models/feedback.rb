class Feedback < ApplicationRecord
  belongs_to :sender, class_name: "User" #the sender is the one who has fulfilled the feedback
  belongs_to :receiver, class_name: "User", optional: true #a feedback can be sent by the sender to a specific receiver
  has_many :notifications, dependent: :destroy

  after_create :new_feedback_mail
  after_create :notify_feedback_create
  after_update :notify_feedback_update

  before_validation :convert_to_integer
  before_save :save_score_average


  validates :score_global,
    presence:true,
    inclusion: { in:(0..5), message: "%{value} n'est pas valide." }
  validates :score_workspace, presence:true, inclusion: { in:(0..5), message: "%{value} n'est pas valide." }
  validates :score_missions, presence:true, inclusion: { in:(0..5), message: "%{value} n'est pas valide." }

  validates :answer_global, presence: {message: ": Le commentaire est obligatoire pour les notes inférieures à 3."}, unless: -> { self.score_global >= 3}
  validates :answer_workspace,presence: {message: ": Le commentaire est obligatoire pour les notes inférieures à 3."}, unless: -> { self.score_workspace >= 3}
  validates :answer_missions, presence: {message: ": Le commentaire est obligatoire pour les notes inférieures à 3."}, unless: -> { self.score_missions >= 3}


  def new_feedback_mail
    if !self.sender.nil?
      FeedbackMailer.new_feedback_user(self.sender).deliver_later
    end
    if !self.receiver.nil?
      FeedbackMailer.new_feedback_receiver(self.receiver).deliver_later
    end
  end


  # Instance method
  def save_score_average
    score = (self.score_global + self.score_workspace + self.score_missions)/3.0
    self.score_average =  score.nil? ? 0 : score.round(2)
  end

  #-----------------------------------------------------------
  # Helper method
  # If version v1 for MVP
  def self.is_separated_by_company?
    return true
  end
 

  #-------------------------
  # Get score by company
  def self.all_company_fbs(company_id)
    if self.is_separated_by_company? != true
      return Feedback.all
    end
    return Feedback.joins(:sender).where(users:{company_id: company_id})
  end
  
  def self.global_score(company_id)
    feedbacks = self.all_company_fbs(company_id)
    average = feedbacks.average(:score_global)
    return average.nil? ? 0 : average.round(2)
  end
  def self.workspace_score(company_id)
    feedbacks = self.all_company_fbs(company_id)
    average = feedbacks.average(:score_workspace)
    return average.nil? ? 0 : average.round(2)
  end
  def self.missions_score(company_id)
    feedbacks = self.all_company_fbs(company_id)
    average = feedbacks.average(:score_missions)
    return average.nil? ? 0 : average.round(2)
  end
  def self.company_score(company_id)
    global_score = self.global_score(company_id)
    workspace_score = self.workspace_score(company_id)
    missions_score = self.missions_score(company_id)
    arr = [global_score, workspace_score, missions_score]
    return (arr.inject(0.0) { |sum, el| sum + el }.to_f / arr.size).round(2)
  end


  #-------------------------
  # Get score by user
  def self.global_score_user(user_id)
    user = User.find(user_id)
    feedbacks = Feedback.where(sender_id: user_id)
    average =  feedbacks.average(:score_global)
    return average.nil? ? 0 : average.round(2)
  end
  def self.workspace_score_user(user_id)
    user = User.find(user_id)
    feedbacks = Feedback.where(sender_id: user_id)
    average = feedbacks.average(:score_workspace)
    return average.nil? ? 0 : average.round(2)
  end
  def self.missions_score_user(user_id)
    user = User.find(user_id)
    feedbacks = Feedback.where(sender_id: user_id)
    average = feedbacks.average(:score_missions)
    return average.nil? ? 0 : average.round(2)
  end

  def self.user_score(user_id)
    global_score = self.global_score_user(user_id)
    workspace_score = self.workspace_score_user(user_id)
    missions_score = self.missions_score_user(user_id)
    arr = [global_score, workspace_score, missions_score]
    return (arr.inject(0.0) { |sum, el| sum + el }.to_f / arr.size).round(2)
  end



  # Score before date
  def self.global_score_by_date(company_id, date)
    feedbacks = self.all_company_fbs(company_id)
    average =  feedbacks.where("DATE(feedbacks.created_at) <= ?", date).average(:score_global)
    return average.nil? ? 0 : average.round(2)
  end 

  def self.workspace_score_by_date(company_id,date)
    feedbacks = self.all_company_fbs(company_id)
    average =  feedbacks.where("DATE(feedbacks.created_at) <= ?", date).average(:score_workspace)
    return average.nil? ? 0 : average.round(2)
  end 

  def self.missions_score_by_date(company_id,date)
    feedbacks = self.all_company_fbs(company_id)
    average =  feedbacks.where("DATE(feedbacks.created_at) <= ?", date).average(:score_missions)
    return average.nil? ? 0 : average.round(2)
  end 

  # Yesterday score
  def self.global_score_yesterday(company_id)
    return self.global_score_by_date(company_id, Date.today-1)
  end 

  def self.workspace_score_yesterday(company_id)
    return self.workspace_score_by_date(company_id, Date.today-1)
  end 

  def self.missions_score_yesterday(company_id)
    return self.missions_score_by_date(company_id, Date.today-1)
  end 

  def self.company_score_yesterday(company_id)
    global_score = self.global_score_yesterday(company_id)
    workspace_score = self.workspace_score_yesterday(company_id)
    missions_score = self.missions_score_yesterday(company_id)
    arr = [global_score, workspace_score, missions_score]
    return (arr.inject(0.0) { |sum, el| sum + el }.to_f / arr.size).round(2)
  end

  # Lastweek score
  def self.global_score_lastweek(company_id)
    return self.global_score_by_date(company_id, Date.today - 1.week)
  end 

  def self.workspace_score_lastweek(company_id)
    return self.workspace_score_by_date(company_id, Date.today - 1.week)
  end 

  def self.missions_score_lastweek(company_id)
    return self.missions_score_by_date(company_id, Date.today - 1.week)
  end 

  def self.company_score_lastweek(company_id)
    global_score = self.global_score_lastweek(company_id)
    workspace_score = self.workspace_score_lastweek(company_id)
    missions_score = self.missions_score_lastweek(company_id)
    arr = [global_score, workspace_score, missions_score]
    return (arr.inject(0.0) { |sum, el| sum + el }.to_f / arr.size).round(2)
  end



  private
  def convert_to_integer
    self.score_global = self.score_global.to_i
    self.score_workspace = self.score_workspace.to_i
    self.score_missions = self.score_missions.to_i
  end


  def notify_feedback_create
    activity_type = Activity.find_by(name: "feedback_created")
    notification = Notification.create(user_id: self.sender.id, feedback_id: self.id, activity: activity_type)
  end 

  def notify_feedback_update
    activity_type = Activity.find_by(name: "feedback_updated")
    notification = Notification.create(user_id: self.sender.id, feedback_id: self.id, activity: activity_type)
  end 

end

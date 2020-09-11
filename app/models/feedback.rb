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

  # Instance method
  def score_average
    score = (self.score_global + self.score_workspace + self.score_missions)
    return score.nil? ? 0 : score.round(2)
  end

  #-----------------------------------------------------------
  # Helper method
  # If version v1 for MVP
  def self.is_separated_by_company?
    return false
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
    feedbacks = self.all_company_fbs(user.company.id)
    average =  feedbacks.average(:score_global)
    return average.nil? ? 0 : average.round(2)
  end
  def self.workspace_score_user(user_id)
    user = User.find(user_id)
    feedbacks = self.all_company_fbs(user.company.id)
    average = feedbacks.average(:score_workspace)
    return average.nil? ? 0 : average.round(2)
  end
  def self.missions_score_user(user_id)
    user = User.find(user_id)
    feedbacks = self.all_company_fbs(user.company.id)
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



  # Score in a period back
  def self.global_score_by_period_back(company_id, date)
    feedbacks = self.all_company_fbs(company_id)
    average =  feedbacks.where("DATE(created_at) <= ?", date).average(:score_global)
    return average.nil? ? 0 : average.round(2)
  end 

  def self.workspace_score_by_period_back(company_id,date)
    feedbacks = self.all_company_fbs(company_id)
    average =  feedbacks.where("DATE(created_at) <= ?", date).average(:score_workspace)
    return average.nil? ? 0 : average.round(2)
  end 

  def self.missions_score_by_period_back(company_id,date)
    feedbacks = self.all_company_fbs(company_id)
    average =  feedbacks.where("DATE(created_at) <= ?", date).average(:score_missions)
    return average.nil? ? 0 : average.round(2)
  end 

  # Score in a period next
  def self.global_score_by_period_next(company_id, date)
    feedbacks = self.all_company_fbs(company_id)
    average =  feedbacks.where("DATE(created_at) >= ?", date).average(:score_global)
    return average.nil? ? 0 : average.round(2)
  end 

  def self.workspace_score_by_period_next(company_id,date)
    feedbacks = self.all_company_fbs(company_id)
    average =  feedbacks.where("DATE(created_at) >= ?", date).average(:score_workspace)
    return average.nil? ? 0 : average.round(2)
  end 

  def self.missions_score_by_period_next(company_id,date)
    feedbacks = self.all_company_fbs(company_id)
    average =  feedbacks.where("DATE(created_at) >= ?", date).average(:score_missions)
    return average.nil? ? 0 : average.round(2)
  end 

  # Yesterday score
  def self.global_score_yesterday(company_id)
    return self.global_score_by_period_back(company_id, Date.today-1)
  end 

  def self.workspace_score_yesterday(company_id)
    return self.workspace_score_by_period_back(company_id, Date.today-1)
  end 

  def self.missions_score_yesterday(company_id)
    return self.missions_score_by_period_back(company_id, Date.today-1)
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
    return self.global_score_by_period_next(company_id, 1.week.ago.utc)
  end 

  def self.workspace_score_lastweek(company_id)
    return self.workspace_score_by_period_next(company_id, 1.week.ago.utc)
  end 

  def self.missions_score_lastweek(company_id)
    return self.missions_score_by_period_next(company_id, 1.week.ago.utc)
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
end

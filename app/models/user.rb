class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  after_create :welcome_send
  before_save :notify_profile_updated , if: :company_id_changed?
  before_save :is_always_validate_account_for_admin

  belongs_to :company, optional: true #an employee works for only one company
  has_many :received_feedbacks, class_name: "Feedback", foreign_key: :receiver_id, dependent: :destroy
  has_many :sent_feedbacks, class_name: "Feedback", foreign_key: :sender_id , dependent: :destroy
  has_many :notifications , dependent: :destroy

  has_many :employee_appointments, class_name: "Appointment", foreign_key: :employee_id, dependent: :destroy
  has_many :employer__appointments, class_name: "Appointment", foreign_key: :employer_id , dependent: :destroy
  
  validates :email,
    presence:true,
    uniqueness:{case_sensitive: false},
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Email adress please" }

  validates :password, length: {minimum: 8}, presence: true, on: :create
  validates :password_confirmation, length: {minimum: 8}, presence: true, on: :create
  validates :password, length: {minimum: 8}, presence: true, on: :update, if: :encrypted_password_changed?
  validates :password_confirmation, length: {minimum: 8}, presence: true, on: :update, if: :encrypted_password_changed?

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  # we have the link into the welcome email, so we do not need the separate confirmation email
  def send_confirmation_notification?
    false
  end

  def full_name
    if self.first_name.nil? && self.last_name.nil?
        return self.email.split('@')[0]
    else
     return "#{self.first_name.capitalize unless self.first_name.nil?} #{self.last_name.capitalize unless self.last_name.nil?}"
    end
  end

  private
  def notify_profile_updated
      activity = Activity.find_by(name: "user_created")
      Notification.create(user: self, activity: activity)
  end
  def is_always_validate_account_for_admin
    if self.is_site_admin || self.is_company_admin
      self.is_validated = true
    end
  end

end

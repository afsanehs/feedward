class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :welcome_send

  belongs_to :company, optional: true #an employee works for only one company
  has_and_belongs_to_many :received_feedbacks, class_name: "Feedback", foreign_key: :receiver_id, dependent: :destroy
  has_and_belongs_to_many :sent_feedbacks, class_name: "Feedback", foreign_key: :sender_id , dependent: :destroy

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
end

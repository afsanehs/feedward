class Notification < ApplicationRecord
  belongs_to :activity
  belongs_to :user
  belongs_to :feedback, optional: true

end

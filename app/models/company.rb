class Company < ApplicationRecord
  has_many :users #a company is composed by many employees
end
